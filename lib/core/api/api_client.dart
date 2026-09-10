import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/session_events.dart';
import '../storage/secure_storage.dart';

String resolveBaseUrl() {
  const override = String.fromEnvironment('API_BASE_URL');
  if (override.isNotEmpty) return override;
  return 'https://api.pokopayng.com';
}

class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Dio get dio => _dio;
}

enum RefreshResult { ok, invalid, network }

/// Human-readable device name sent as X-Device-Name so sessions can be
/// told apart in Settings › Active devices.
String get deviceLabel {
  if (kIsWeb) return 'Web';
  final os = Platform.operatingSystem;
  final name = switch (os) {
    'ios' => 'iPhone',
    'android' => 'Android',
    _ => os,
  };
  return '$name ${Platform.operatingSystemVersion.split(' ').take(2).join(' ')}'
      .trim();
}

/// Single-flight token refresh. Uses its own bare [Dio] so the auth
/// interceptor never recurses into itself.
class TokenRefresher {
  TokenRefresher({required Dio dio, required SecureStorage storage})
    : _dio = dio,
      _storage = storage;

  final Dio _dio;
  final SecureStorage _storage;
  Future<RefreshResult>? _inflight;

  Future<RefreshResult> refresh() {
    return _inflight ??= _refresh().whenComplete(() => _inflight = null);
  }

  Future<RefreshResult> _refresh() async {
    final refreshToken = await _storage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return RefreshResult.invalid;
    }
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/api/v1/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      final data = res.data ?? const {};
      final access = data['accessToken']?.toString();
      if (access == null || access.isEmpty) return RefreshResult.invalid;
      await _storage.writeTokens(
        accessToken: access,
        refreshToken: data['refreshToken']?.toString(),
        expiresIn: (data['expiresIn'] as num?)?.toInt(),
      );
      return RefreshResult.ok;
    } on DioException catch (e) {
      // Any HTTP answer (401 REFRESH_EXPIRED, 400, 5xx) means the refresh
      // token is not usable; no answer at all means we are offline.
      return e.response == null ? RefreshResult.network : RefreshResult.invalid;
    }
  }
}

/// Attaches the bearer token, refreshes it shortly before expiry, and
/// retries a request once after a 401. When the refresh token is dead the
/// session is cleared and [SessionEvents.expire] fires.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required SecureStorage storage,
    required TokenRefresher refresher,
    required Dio dio,
    required VoidCallback onSessionExpired,
  }) : _storage = storage,
       _refresher = refresher,
       _dio = dio,
       _onSessionExpired = onSessionExpired;

  final SecureStorage _storage;
  final TokenRefresher _refresher;
  final Dio _dio;
  final VoidCallback _onSessionExpired;

  static bool _skipAuth(RequestOptions o) => o.extra['skipAuth'] == true;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_skipAuth(options)) return handler.next(options);

    final expiry = await _storage.readTokenExpiry();
    if (expiry != null &&
        DateTime.now().isAfter(expiry.subtract(SecureStorage.expirySkew))) {
      final r = await _refresher.refresh();
      if (r == RefreshResult.invalid) await _expire();
    }

    final token = await _storage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['X-Device-Id'] = await _storage.ensureDeviceId();
    options.headers['X-Device-Name'] = deviceLabel;
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final o = err.requestOptions;
    final is401 = err.response?.statusCode == 401;
    if (!is401 || _skipAuth(o) || o.extra['retried'] == true) {
      return handler.next(err);
    }

    // Another request may already have refreshed the token.
    final current = await _storage.readAccessToken();
    final sent = (o.headers['Authorization'] as String?)?.replaceFirst(
      'Bearer ',
      '',
    );
    var canRetry = current != null && current.isNotEmpty && current != sent;

    if (!canRetry) {
      final r = await _refresher.refresh();
      if (r == RefreshResult.ok) {
        canRetry = true;
      } else if (r == RefreshResult.invalid) {
        await _expire();
        return handler.next(err);
      } else {
        return handler.next(err);
      }
    }

    try {
      final token = await _storage.readAccessToken();
      o.headers['Authorization'] = 'Bearer $token';
      o.extra['retried'] = true;
      final response = await _dio.fetch<dynamic>(o);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  Future<void> _expire() async {
    await _storage.clear();
    _onSessionExpired();
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final session = ref.read(sessionEventsProvider.notifier);
  final options = BaseOptions(
    baseUrl: resolveBaseUrl(),
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 20),
    contentType: 'application/json',
    responseType: ResponseType.json,
  );
  final dio = Dio(options);
  final refresher = TokenRefresher(dio: Dio(options), storage: storage);

  dio.interceptors.add(
    AuthInterceptor(
      storage: storage,
      refresher: refresher,
      dio: dio,
      onSessionExpired: session.expire,
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }

  return ApiClient(dio);
});
