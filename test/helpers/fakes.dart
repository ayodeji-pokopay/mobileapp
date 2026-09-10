import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokopay/core/api/api_client.dart';
import 'package:pokopay/core/storage/secure_storage.dart';

typedef Handler = Future<ResponseBody> Function(RequestOptions options);

/// Dio adapter that answers requests from an in-test handler.
class FakeAdapter implements HttpClientAdapter {
  FakeAdapter(this.handler);
  final Handler handler;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    requests.add(options);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody json(Object data, {int status = 200}) => ResponseBody.fromString(
  jsonEncode(data),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

DioException offline(RequestOptions o) => DioException(
  requestOptions: o,
  type: DioExceptionType.connectionError,
  message: 'Network is unreachable',
);

ApiClient fakeApi(Handler handler, {FakeAdapter? adapter}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://test.local'));
  dio.httpClientAdapter = adapter ?? FakeAdapter(handler);
  return ApiClient(dio);
}

/// In-memory replacement for the keychain-backed storage.
class FakeSecureStorage extends SecureStorage {
  FakeSecureStorage() : super(const FlutterSecureStorage());
  final Map<String, String> data = {};

  @override
  Future<String?> readValue(String key) async => data[key];
  @override
  Future<void> writeValue(String key, String value) async => data[key] = value;
  @override
  Future<void> deleteValue(String key) async => data.remove(key);

  @override
  Future<String?> readAccessToken() async => data['access'];
  @override
  Future<String?> readRefreshToken() async => data['refresh'];
  @override
  Future<DateTime?> readTokenExpiry() async {
    final raw = data['expiry'];
    return raw == null ? null : DateTime.tryParse(raw);
  }

  @override
  Future<void> writeTokens({
    required String accessToken,
    String? refreshToken,
    int? expiresIn,
  }) async {
    data['access'] = accessToken;
    if (refreshToken != null && refreshToken.isNotEmpty) {
      data['refresh'] = refreshToken;
    }
    if (expiresIn != null && expiresIn > 0) {
      data['expiry'] = DateTime.now()
          .add(Duration(seconds: expiresIn))
          .toIso8601String();
    } else {
      data.remove('expiry');
    }
  }

  @override
  Future<void> clear() async {
    data.remove('access');
    data.remove('refresh');
    data.remove('expiry');
  }

  @override
  Future<String> ensureDeviceId() async =>
      data.putIfAbsent('deviceId', () => 'device-1');
  @override
  Future<String?> readDeviceId() async => data['deviceId'];
  @override
  Future<String?> readDeviceToken() async => data['deviceToken'];
  @override
  Future<void> writeDeviceToken(String token) async =>
      data['deviceToken'] = token;
  @override
  Future<bool> hasDeviceToken() async => (data['deviceToken'] ?? '').isNotEmpty;
  @override
  Future<void> clearDeviceToken() async => data.remove('deviceToken');
}
