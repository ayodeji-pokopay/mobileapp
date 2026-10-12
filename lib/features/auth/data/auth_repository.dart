import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/models/auth_models.dart';
import '../../../core/cache/cache_store.dart';
import '../../../core/storage/secure_storage.dart';

/// One signed-in device from `GET /users/me/sessions`.
class SessionInfo {
  const SessionInfo({
    required this.tokenId,
    required this.deviceInfo,
    required this.ipAddress,
    required this.location,
    required this.createdAt,
    required this.lastActivity,
    required this.expiresAt,
    required this.active,
    required this.current,
    this.deviceName,
    this.platform,
  });

  final String tokenId;
  final String deviceInfo;
  final String ipAddress;
  final String location;
  final DateTime? createdAt;
  final DateTime? lastActivity;
  final DateTime? expiresAt;
  final bool active;
  final bool current;
  final String? deviceName;
  final String? platform;

  factory SessionInfo.fromJson(Map<String, dynamic> j) => SessionInfo(
    tokenId: j['tokenId']?.toString() ?? '',
    deviceInfo: j['deviceInfo']?.toString() ?? '',
    ipAddress: j['ipAddress']?.toString() ?? '',
    location: j['location']?.toString() ?? '',
    createdAt: DateTime.tryParse(j['createdAt']?.toString() ?? ''),
    lastActivity: DateTime.tryParse(j['lastActivity']?.toString() ?? ''),
    expiresAt: DateTime.tryParse(j['expiresAt']?.toString() ?? ''),
    active: j['active'] == true,
    current: j['current'] == true,
    deviceName: j['deviceName']?.toString(),
    platform: j['platform']?.toString(),
  );

  /// A user-agent string such as "Dart/3.11 (dart:io)" or "curl/8.7.1";
  /// the backend currently echoes it into [deviceName] too.
  static final _looksLikeUserAgent = RegExp(r'^[\w.-]+/\d');

  /// The friendly name the app sent as X-Device-Name, once the backend
  /// stores it; null while it only echoes the user agent.
  String? get friendlyName {
    final n = (deviceName ?? '').trim();
    if (n.isEmpty || _looksLikeUserAgent.hasMatch(n)) return null;
    return n;
  }

  /// "Dart/…" is the app's HTTP client; anything else is probably a
  /// browser or tool.
  bool get isApp =>
      deviceInfo.startsWith('Dart/') ||
      (deviceName ?? '').startsWith('Dart/') ||
      friendlyName != null;
}

class AuthException implements Exception {
  AuthException(this.message, {this.code});
  final String message;

  /// Stable code where the backend provides one, or one of the
  /// client-side codes below.
  final String? code;

  static const deviceReenrol = 'DEVICE_REENROL';
  // Codes the app assigns when the backend sends none.
  static const invalidCredentials = 'INVALID_CREDENTIALS';
  static const serverUnavailable = 'SERVER_UNAVAILABLE';
  static const network = 'NETWORK';
  static const accountLocked = 'ACCOUNT_LOCKED';
  static const rateLimited = 'RATE_LIMITED';
  static const invalidRequest = 'INVALID_REQUEST';
  static const mfaRequired = 'MFA_REQUIRED';
  static const mfaInvalidCode = 'MFA_INVALID_CODE';
  static const mfaExpired = 'MFA_EXPIRED';

  @override
  String toString() => message;
}

/// Thrown by [AuthRepository.login] when the password was right but the
/// account needs its second factor first: a code from the authenticator app
/// ([setup] false), or first-time enrolment because 2FA is required for
/// everyone ([setup] true). [token] is short-lived and single-use; it is not
/// a session.
class MfaStepRequired implements Exception {
  const MfaStepRequired({required this.setup, required this.token, this.email});
  final bool setup;
  final String token;
  final String? email;

  @override
  String toString() =>
      setup ? 'Two-factor setup required' : 'Two-factor code required';
}

/// What the app needs to add Pokopay to an authenticator app.
class MfaSetupInfo {
  const MfaSetupInfo({required this.secret, required this.otpauthUri});
  final String secret;
  final String otpauthUri;
}

class AuthRepository {
  AuthRepository(this._api, this._storage, {CacheStore? cache})
    : _cache = cache;

  final ApiClient _api;
  final SecureStorage _storage;
  final CacheStore? _cache;

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _api.dio.post<Map<String, dynamic>>(
        '/api/v1/auth/login',
        data: LoginRequest(email: email, password: password).toJson(),
        options: Options(extra: const {'skipAuth': true}),
      );
      final data = res.data ?? const <String, dynamic>{};
      _throwIfMfaStep(data);
      return _storeSession(AuthResponse.fromJson(data));
    } on DioException catch (e) {
      throw AuthException(_extractError(e), code: _extractCode(e));
    }
  }

  /// The backend answers a correct password with a second-factor step instead
  /// of tokens when the account has (or must set up) 2FA.
  void _throwIfMfaStep(Map<String, dynamic> data) {
    final email = data['email']?.toString();
    if (data['mfaRequired'] == true) {
      throw MfaStepRequired(
        setup: false,
        token: data['mfaToken']?.toString() ?? '',
        email: email,
      );
    }
    if (data['mfaSetupRequired'] == true) {
      throw MfaStepRequired(
        setup: true,
        token: data['setupToken']?.toString() ?? '',
        email: email,
      );
    }
  }

  /// Second step of sign-in: a 6-digit authenticator [code], or one of the
  /// one-time [recoveryCode]s. Stores the session on success.
  Future<AuthResponse> verifyMfa({
    required String mfaToken,
    String? code,
    String? recoveryCode,
  }) async {
    try {
      final res = await _api.dio.post<Map<String, dynamic>>(
        '/api/v1/auth/mfa/verify',
        data: {
          'mfaToken': mfaToken,
          if (code != null && code.isNotEmpty) 'code': code,
          if (recoveryCode != null && recoveryCode.isNotEmpty)
            'recoveryCode': recoveryCode,
        },
        options: Options(extra: const {'skipAuth': true}),
      );
      return _storeSession(AuthResponse.fromJson(res.data ?? const {}));
    } on DioException catch (e) {
      throw AuthException(_extractError(e), code: _mfaCode(e));
    }
  }

  /// Forced enrolment, step 1: get the secret to add to an authenticator app.
  Future<MfaSetupInfo> startMfaSetup(String setupToken) async {
    try {
      final res = await _api.dio.post<Map<String, dynamic>>(
        '/api/v1/auth/mfa/setup',
        data: {'setupToken': setupToken},
        options: Options(extra: const {'skipAuth': true}),
      );
      final data = res.data ?? const <String, dynamic>{};
      return MfaSetupInfo(
        secret: data['secret']?.toString() ?? '',
        otpauthUri: data['otpauthUri']?.toString() ?? '',
      );
    } on DioException catch (e) {
      throw AuthException(_extractError(e), code: _mfaCode(e));
    }
  }

  /// Forced enrolment, step 2: prove the app works with its first [code].
  /// Stores the session and returns the one-time recovery codes, which the
  /// user must save now; they are never shown again.
  Future<List<String>> confirmMfaSetup({
    required String setupToken,
    required String code,
  }) async {
    try {
      final res = await _api.dio.post<Map<String, dynamic>>(
        '/api/v1/auth/mfa/confirm',
        data: {'setupToken': setupToken, 'code': code},
        options: Options(extra: const {'skipAuth': true}),
      );
      final data = res.data ?? const <String, dynamic>{};
      final session = data['session'];
      if (session is Map<String, dynamic>) {
        await _storeSession(AuthResponse.fromJson(session));
      } else {
        throw AuthException('Missing session');
      }
      return [
        for (final c in (data['recoveryCodes'] as List?) ?? const [])
          c.toString(),
      ];
    } on DioException catch (e) {
      throw AuthException(_extractError(e), code: _mfaCode(e));
    }
  }

  /// 400 = wrong code, 401 = the step expired or was used up (sign in again).
  String? _mfaCode(DioException e) {
    final status = e.response?.statusCode;
    if (status == 400) return AuthException.mfaInvalidCode;
    if (status == 401) return AuthException.mfaExpired;
    return _extractCode(e);
  }

  Future<AuthResponse> _storeSession(AuthResponse auth) async {
    final access = auth.accessToken;
    if (access == null || access.isEmpty) {
      throw AuthException(auth.message ?? 'Missing access token');
    }
    await _storage.writeTokens(
      accessToken: access,
      refreshToken: auth.refreshToken,
      expiresIn: auth.expiresIn,
    );
    return auth;
  }

  Future<UserInfoResponse?> me() async {
    try {
      final res = await _api.dio.get<Map<String, dynamic>>('/api/v1/auth/me');
      if (res.data == null) return null;
      return UserInfoResponse.fromJson(res.data!);
    } on DioException {
      return null;
    }
  }

  /// Finds a merchant record tied to [email] via /api/v1/merchants search,
  /// returning its `mid` if found. Returns null on any failure.
  Future<String?> discoverMidForEmail(String email) async {
    try {
      final res = await _api.dio.get<Map<String, dynamic>>(
        '/api/v1/merchants',
        queryParameters: {'search': email, 'page': 0, 'size': 5},
      );
      final content = (res.data?['content'] as List?) ?? const [];
      for (final item in content) {
        if (item is Map<String, dynamic>) {
          final itemEmail = (item['email'] ?? '').toString().toLowerCase();
          final mid = (item['mid'] ?? '').toString();
          if (mid.isNotEmpty && itemEmail == email.toLowerCase()) {
            return mid;
          }
        }
      }
      final fromSearch = _firstMid(content);
      if (fromSearch != null) return fromSearch;
      // Admin / CSA users have no merchant of their own: start them on the
      // first merchant on the platform; they can switch from the drawer.
      final all = await _api.dio.get<Map<String, dynamic>>(
        '/api/v1/merchants',
        queryParameters: {'page': 0, 'size': 1},
      );
      return _firstMid((all.data?['content'] as List?) ?? const []);
    } on DioException {
      return null;
    }
  }

  String? _firstMid(List<dynamic> content) {
    for (final item in content) {
      if (item is Map<String, dynamic>) {
        final mid = (item['mid'] ?? '').toString();
        if (mid.isNotEmpty) return mid;
      }
    }
    return null;
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _api.dio.post<void>(
        '/api/v1/auth/change-password',
        data: ChangePasswordRequest(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ).toJson(),
      );
    } on DioException catch (e) {
      throw AuthException(_extractError(e), code: _extractCode(e));
    }
  }

  // ── Password reset ──────────────────────────────────────────────────

  /// Always resolves; the backend never reveals whether the email exists.
  Future<void> forgotPassword(String email) async {
    try {
      await _api.dio.post<void>(
        '/api/v1/auth/forgot-password',
        data: {'email': email},
        options: Options(extra: const {'skipAuth': true}),
      );
    } on DioException catch (e) {
      throw AuthException(_extractError(e), code: _extractCode(e));
    }
  }

  /// Checks a reset token from the emailed link before asking for a
  /// new password. Throws [AuthException] when invalid or expired.
  Future<void> verifyResetToken(String token) async {
    try {
      final res = await _api.dio.post<Map<String, dynamic>>(
        '/api/v1/auth/verify-reset-token',
        queryParameters: {'token': token},
        options: Options(extra: const {'skipAuth': true}),
      );
      // The backend answers 200 with {valid: false} for bad tokens.
      if (res.data?['valid'] == false) {
        throw AuthException(
          res.data?['message']?.toString() ?? 'Token is invalid or expired',
          code: 'RESET_TOKEN_INVALID',
        );
      }
    } on DioException catch (e) {
      throw AuthException(_extractError(e), code: _extractCode(e));
    }
  }

  /// Staff invited from the Staff screen finish sign-up here with the
  /// code from their email.
  Future<void> acceptInvite({
    required String code,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _api.dio.post<void>(
        '/api/v1/auth/accept-invite',
        data: {
          'code': code,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
        },
        options: Options(extra: const {'skipAuth': true}),
      );
    } on DioException catch (e) {
      throw AuthException(_extractError(e), code: _extractCode(e));
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await _api.dio.post<void>(
        '/api/v1/auth/reset-password',
        data: {'token': token, 'newPassword': newPassword},
        options: Options(extra: const {'skipAuth': true}),
      );
    } on DioException catch (e) {
      throw AuthException(_extractError(e), code: _extractCode(e));
    }
  }

  // ── Sessions ────────────────────────────────────────────────────────

  Future<List<SessionInfo>> fetchSessions() async {
    final res = await _api.dio.get<List<dynamic>>('/api/v1/users/me/sessions');
    return [
      for (final e in res.data ?? const [])
        if (e is Map<String, dynamic>) SessionInfo.fromJson(e),
    ];
  }

  Future<void> revokeSession(String tokenId) async {
    await _api.dio.delete<void>('/api/v1/users/me/sessions/$tokenId');
  }

  Future<void> revokeOtherSessions() async {
    await _api.dio.post<void>('/api/v1/users/me/sessions/revoke-others');
  }

  // ── Biometric sign-in via backend device tokens ──────────────────────

  /// Enrols this install for biometric sign-in. Requires a live session.
  Future<void> enrolDevice() async {
    final deviceId = await _storage.ensureDeviceId();
    try {
      final res = await _api.dio.post<Map<String, dynamic>>(
        '/api/v1/auth/devices',
        data: {
          'deviceId': deviceId,
          'deviceName': _deviceName(),
          'platform': _platform(),
        },
      );
      final token = res.data?['deviceToken']?.toString();
      if (token == null || token.isEmpty) {
        throw AuthException('Device enrolment failed');
      }
      await _storage.writeDeviceToken(token);
    } on DioException catch (e) {
      throw AuthException(_extractError(e), code: _extractCode(e));
    }
  }

  /// Exchanges the stored device token for a session. Call only after the
  /// OS biometric prompt succeeded.
  Future<AuthResponse> deviceLogin() async {
    final deviceId = await _storage.readDeviceId();
    final deviceToken = await _storage.readDeviceToken();
    if (deviceId == null || deviceToken == null || deviceToken.isEmpty) {
      throw AuthException('Not enrolled', code: AuthException.deviceReenrol);
    }
    try {
      final res = await _api.dio.post<Map<String, dynamic>>(
        '/api/v1/auth/devices/login',
        data: {'deviceId': deviceId, 'deviceToken': deviceToken},
        options: Options(extra: const {'skipAuth': true}),
      );
      return _storeSession(AuthResponse.fromJson(res.data ?? const {}));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _storage.clearDeviceToken();
        throw AuthException(
          _extractError(e),
          code: AuthException.deviceReenrol,
        );
      }
      throw AuthException(_extractError(e), code: _extractCode(e));
    }
  }

  Future<void> revokeDevice() async {
    final deviceId = await _storage.readDeviceId();
    if (deviceId == null || !await _storage.hasDeviceToken()) return;
    try {
      await _api.dio.delete<void>('/api/v1/auth/devices/$deviceId');
    } on DioException {
      // Best effort; the token is dropped locally regardless.
    } finally {
      await _storage.clearDeviceToken();
    }
  }

  /// Signs out but keeps the device enrolment so the merchant can come
  /// back with biometrics. [revokeDevice] is only called when the user
  /// turns biometric sign-in off.
  Future<void> logout() async {
    try {
      await _api.dio.post<void>('/api/v1/auth/logout');
    } on DioException {
      // ignore network errors on logout
    } finally {
      await _storage.clear();
      await _cache?.clear();
    }
  }

  String _deviceName() {
    if (kIsWeb) return 'Web';
    return '${Platform.operatingSystem} ${Platform.operatingSystemVersion}'
        .trim();
  }

  String _platform() {
    if (kIsWeb) return 'WEB';
    if (Platform.isIOS) return 'IOS';
    if (Platform.isAndroid) return 'ANDROID';
    return Platform.operatingSystem.toUpperCase();
  }

  String? _extractCode(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final c = data['code'];
      if (c is String && c.isNotEmpty) return c;
    }
    final status = e.response?.statusCode;
    if (status == 401) return AuthException.invalidCredentials;
    if (status == 423) return AuthException.accountLocked;
    if (status == 429) return AuthException.rateLimited;
    if (status == 400) return AuthException.invalidRequest;
    if (status != null && status >= 500) return AuthException.serverUnavailable;
    if (e.response == null) return AuthException.network;
    return null;
  }

  String _extractError(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final msg = data['message'] ?? data['error'];
      if (msg is String && msg.isNotEmpty) return msg;
    }
    final status = e.response?.statusCode;
    if (status == 401) return 'Invalid email or password';
    if (status != null && status >= 500) {
      return 'Pokopay is temporarily unavailable. Please try again in a few minutes.';
    }
    if (e.response == null) {
      // Timeout, DNS failure, no network: never surface Dio's own text.
      return "Couldn't reach Pokopay. Check your connection and try again.";
    }
    return 'Something went wrong. Please try again.';
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(apiClientProvider),
    ref.watch(secureStorageProvider),
    cache: ref.watch(cacheStoreProvider),
  );
});
