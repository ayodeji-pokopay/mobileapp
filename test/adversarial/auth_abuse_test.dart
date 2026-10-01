import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/api_client.dart';

import '../helpers/fakes.dart';

void main() {
  late FakeSecureStorage storage;
  late int refreshCalls;
  late int expired;

  Dio build(Handler apiHandler, {Handler? refreshHandler}) {
    final dio = Dio(BaseOptions(baseUrl: 'https://test.local'));
    final refreshDio = Dio(BaseOptions(baseUrl: 'https://test.local'));
    refreshDio.httpClientAdapter = FakeAdapter((o) {
      refreshCalls++;
      return (refreshHandler ??
          (_) async => json({
            'accessToken': 'new',
            'refreshToken': 'r2',
            'expiresIn': 900,
          }))(o);
    });
    dio.httpClientAdapter = FakeAdapter(apiHandler);
    final retryDio = Dio(BaseOptions(baseUrl: 'https://test.local'))
      ..httpClientAdapter = FakeAdapter(apiHandler);
    dio.interceptors.add(
      AuthInterceptor(
        storage: storage,
        refresher: TokenRefresher(dio: refreshDio, storage: storage),
        retryDio: retryDio,
        onSessionExpired: () => expired++,
      ),
    );
    return dio;
  }

  setUp(() {
    storage = FakeSecureStorage();
    storage.data['access'] = 'old';
    storage.data['refresh'] = 'r1';
    refreshCalls = 0;
    expired = 0;
  });

  test('a burst of 401s refreshes exactly once', () async {
    final dio = build((o) async {
      final auth = o.headers['Authorization'];
      return auth == 'Bearer new'
          ? json({'ok': true})
          : json({'message': 'expired'}, status: 401);
    });
    await Future.wait([
      for (var i = 0; i < 10; i++) dio.get<dynamic>('/api/v1/x$i'),
    ]);
    expect(refreshCalls, 1);
    expect(expired, 0);
    expect(storage.data['refresh'], 'r2');
  });

  test('a fresh token that is still refused ends the session once', () async {
    final dio = build((o) async => json({'message': 'disabled'}, status: 401));
    for (var i = 0; i < 3; i++) {
      try {
        await dio.get<dynamic>('/api/v1/me');
      } on DioException {
        // expected
      }
    }
    expect(expired, greaterThanOrEqualTo(1));
  });

  test('refresh endpoint down (503) must not sign the user out', () async {
    final dio = build(
      (o) async => json({'message': 'expired'}, status: 401),
      refreshHandler: (o) async =>
          json({'message': 'maintenance'}, status: 503),
    );
    try {
      await dio.get<dynamic>('/api/v1/me');
    } on DioException {
      // expected: request fails
    }
    expect(
      expired,
      0,
      reason: 'an outage on /auth/refresh is not an invalid session',
    );
    expect(
      storage.data['refresh'],
      'r1',
      reason: 'tokens must survive a transient refresh failure',
    );
  });

  test('refresh offline keeps tokens and does not sign out', () async {
    final dio = build(
      (o) async => json({'message': 'expired'}, status: 401),
      refreshHandler: (o) async => throw offline(o),
    );
    try {
      await dio.get<dynamic>('/api/v1/me');
    } on DioException {
      // expected
    }
    expect(expired, 0);
    expect(storage.data['access'], 'old');
  });

  test('a refresh response without tokens is treated as invalid', () async {
    final dio = build(
      (o) async => json({'message': 'expired'}, status: 401),
      refreshHandler: (o) async => json({'unexpected': true}),
    );
    try {
      await dio.get<dynamic>('/api/v1/me');
    } on DioException {
      // expected
    }
    expect(expired, 1);
  });

  test('skipAuth requests never trigger a refresh', () async {
    final dio = build((o) async => json({'message': 'bad creds'}, status: 401));
    try {
      await dio.post<dynamic>(
        '/api/v1/auth/login',
        options: Options(extra: const {'skipAuth': true}),
      );
    } on DioException {
      // expected
    }
    expect(refreshCalls, 0);
    expect(expired, 0);
  });

  test('a 401 with no refresh token stored signs out immediately', () async {
    storage.data.remove('refresh');
    final dio = build((o) async => json({'message': 'expired'}, status: 401));
    try {
      await dio.get<dynamic>('/api/v1/me');
    } on DioException {
      // expected
    }
    expect(refreshCalls, 0);
    expect(expired, 1);
  });
}
