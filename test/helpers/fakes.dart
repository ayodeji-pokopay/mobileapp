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
  Future<String?> readAccessToken() async => data['access'];
  @override
  Future<String?> readRefreshToken() async => data['refresh'];
  @override
  Future<void> writeTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    data['access'] = accessToken;
    if (refreshToken != null) data['refresh'] = refreshToken;
  }

  @override
  Future<void> clear() async {
    data.remove('access');
    data.remove('refresh');
  }

  @override
  Future<void> saveBiometricCredentials({
    required String email,
    required String password,
  }) async {
    data['bio_email'] = email;
    data['bio_password'] = password;
  }

  @override
  Future<({String email, String password})?> readBiometricCredentials() async {
    final e = data['bio_email'];
    final p = data['bio_password'];
    if (e == null || p == null) return null;
    return (email: e, password: p);
  }

  @override
  Future<bool> hasBiometricCredentials() async =>
      (data['bio_email'] ?? '').isNotEmpty;

  @override
  Future<void> clearBiometricCredentials() async {
    data.remove('bio_email');
    data.remove('bio_password');
  }
}
