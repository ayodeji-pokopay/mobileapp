import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/api_client.dart';

import '../helpers/fakes.dart';

void main() {
  late FakeSecureStorage storage;
  late List<String> log;
  late int expired;

  /// Builds a Dio with the auth interceptor. [handler] answers every
  /// request, including the refresh call.
  Dio build(Handler handler) {
    final options = BaseOptions(baseUrl: 'https://test.local');
    final adapter = FakeAdapter((o) {
      final auth = o.headers['Authorization'];
      log.add('${o.method} ${o.path} ${auth ?? '-'}');
      return handler(o);
    });
    final dio = Dio(options)..httpClientAdapter = adapter;
    final bare = Dio(options)..httpClientAdapter = adapter;
    dio.interceptors.add(AuthInterceptor(
      storage: storage,
      refresher: TokenRefresher(dio: bare, storage: storage),
      dio: dio,
      onSessionExpired: () => expired++,
    ));
    return dio;
  }

  setUp(() {
    storage = FakeSecureStorage();
    log = [];
    expired = 0;
  });

  test('attaches the bearer token', () async {
    storage.data['access'] = 'A1';
    final dio = build((o) async => json({'ok': true}));
    await dio.get<Map<String, dynamic>>('/api/v1/auth/me');
    expect(log.single, 'GET /api/v1/auth/me Bearer A1');
  });

  test('retries once with a fresh token after a 401', () async {
    storage.data['access'] = 'OLD';
    storage.data['refresh'] = 'R1';
    final dio = build((o) async {
      if (o.path == '/api/v1/auth/refresh') {
        expect(o.data, {'refreshToken': 'R1'});
        return json({'accessToken': 'NEW', 'refreshToken': 'R2', 'expiresIn': 900});
      }
      final auth = o.headers['Authorization'];
      return auth == 'Bearer NEW' ? json({'ok': true}) : json({}, status: 401);
    });
    final res = await dio.get<Map<String, dynamic>>('/api/v1/merchant/x');
    expect(res.data, {'ok': true});
    expect(storage.data['access'], 'NEW');
    expect(storage.data['refresh'], 'R2');
    expect(storage.data['expiry'], isNotNull);
    expect(log, [
      'GET /api/v1/merchant/x Bearer OLD',
      'POST /api/v1/auth/refresh -',
      'GET /api/v1/merchant/x Bearer NEW',
    ]);
    expect(expired, 0);
  });

  test('expires the session when the refresh token is rejected', () async {
    storage.data['access'] = 'OLD';
    storage.data['refresh'] = 'DEAD';
    final dio = build((o) async {
      if (o.path == '/api/v1/auth/refresh') {
        return json({'code': 'REFRESH_EXPIRED'}, status: 401);
      }
      return json({}, status: 401);
    });
    await expectLater(
      dio.get<Map<String, dynamic>>('/api/v1/merchant/x'),
      throwsA(isA<DioException>()),
    );
    expect(expired, 1);
    expect(storage.data.containsKey('access'), isFalse);
    expect(storage.data.containsKey('refresh'), isFalse);
  });

  test('does not sign out when the refresh call itself is offline', () async {
    storage.data['access'] = 'OLD';
    storage.data['refresh'] = 'R1';
    final dio = build((o) async {
      if (o.path == '/api/v1/auth/refresh') throw offline(o);
      return json({}, status: 401);
    });
    await expectLater(
      dio.get<Map<String, dynamic>>('/api/v1/merchant/x'),
      throwsA(isA<DioException>()),
    );
    expect(expired, 0);
    expect(storage.data['access'], 'OLD');
  });

  test('refreshes proactively when the token is about to expire', () async {
    storage.data['access'] = 'OLD';
    storage.data['refresh'] = 'R1';
    storage.data['expiry'] =
        DateTime.now().add(const Duration(seconds: 10)).toIso8601String();
    final dio = build((o) async {
      if (o.path == '/api/v1/auth/refresh') {
        return json({'accessToken': 'NEW', 'expiresIn': 900});
      }
      return json({'ok': true});
    });
    await dio.get<Map<String, dynamic>>('/api/v1/merchant/x');
    expect(log, [
      'POST /api/v1/auth/refresh -',
      'GET /api/v1/merchant/x Bearer NEW',
    ]);
  });

  test('skipAuth requests never carry or refresh a token', () async {
    storage.data['access'] = 'A1';
    final dio = build((o) async => json({}, status: 401));
    await expectLater(
      dio.post<Map<String, dynamic>>(
        '/api/v1/auth/login',
        options: Options(extra: const {'skipAuth': true}),
      ),
      throwsA(isA<DioException>()),
    );
    expect(log.single, 'POST /api/v1/auth/login -');
    expect(expired, 0);
  });
}
