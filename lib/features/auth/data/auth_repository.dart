import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/models/auth_models.dart';
import '../../../core/cache/cache_store.dart';
import '../../../core/storage/secure_storage.dart';

class AuthException implements Exception {
  AuthException(this.message);
  final String message;
  @override
  String toString() => message;
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
      );
      final auth = AuthResponse.fromJson(res.data ?? const {});
      final access = auth.accessToken;
      if (access == null || access.isEmpty) {
        throw AuthException(auth.message ?? 'Missing access token');
      }
      await _storage.writeTokens(
        accessToken: access,
        refreshToken: auth.refreshToken,
      );
      return auth;
    } on DioException catch (e) {
      throw AuthException(_extractError(e));
    }
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
      // Fall back to the first merchant with a mid if email match failed.
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
      throw AuthException(_extractError(e));
    }
  }

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

  String _extractError(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final msg = data['message'] ?? data['error'];
      if (msg is String && msg.isNotEmpty) return msg;
    }
    if (e.response?.statusCode == 401) return 'Invalid email or password';
    return e.message ?? 'Something went wrong. Please try again.';
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(apiClientProvider),
    ref.watch(secureStorageProvider),
    cache: ref.watch(cacheStoreProvider),
  );
});
