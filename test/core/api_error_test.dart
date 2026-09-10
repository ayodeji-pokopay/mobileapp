import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/api_error.dart';

DioException _http(
  int status,
  Object? body, {
  Map<String, List<String>>? headers,
}) {
  final o = RequestOptions(path: '/x');
  return DioException(
    requestOptions: o,
    response: Response(
      requestOptions: o,
      statusCode: status,
      data: body,
      headers: Headers.fromMap(headers ?? {}),
    ),
  );
}

void main() {
  test('parses the standard body with code and field errors', () {
    final e = ApiError.from(
      _http(422, {
        'code': 'VALIDATION_FAILED',
        'message': 'At most 5 report recipients allowed',
        'fieldErrors': [
          {'field': 'reportRecipients', 'message': 'Too many'},
          {'field': 'reportRecipients', 'message': 'ignored duplicate'},
        ],
      }),
    );
    expect(e.code, ApiError.validationFailed);
    expect(e.status, 422);
    expect(e.message, 'At most 5 report recipients allowed');
    expect(e.fieldErrors, {'reportRecipients': 'Too many'});
  });

  test('falls back to a code derived from the HTTP status', () {
    expect(ApiError.from(_http(404, null)).code, ApiError.notFound);
    expect(
      ApiError.from(_http(423, {'error': 'Locked'})).code,
      ApiError.accountLocked,
    );
    expect(ApiError.from(_http(503, null)).code, ApiError.internal);
    expect(ApiError.from(_http(501, null)).code, ApiError.notImplemented);
  });

  test('legacy auth shape keeps its message', () {
    final e = ApiError.from(_http(401, {'error': 'Invalid credentials'}));
    expect(e.code, ApiError.unauthorized);
    expect(e.message, 'Invalid credentials');
  });

  test('network failures map to NETWORK with no status', () {
    final e = ApiError.from(
      DioException(
        requestOptions: RequestOptions(path: '/x'),
        type: DioExceptionType.connectionError,
      ),
    );
    expect(e.code, ApiError.network);
    expect(e.status, isNull);
    expect(e.isNetwork, isTrue);
  });

  test('reads Retry-After for rate limits', () {
    final e = ApiError.from(
      _http(
        429,
        null,
        headers: {
          'retry-after': ['30'],
        },
      ),
    );
    expect(e.code, ApiError.rateLimited);
    expect(e.retryAfter, const Duration(seconds: 30));
  });
}
