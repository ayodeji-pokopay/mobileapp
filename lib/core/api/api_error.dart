import 'package:dio/dio.dart';

/// Standard error body returned by `/merchant/**` and app endpoints.
///
/// ```json
/// { "status": 422, "code": "VALIDATION_FAILED", "message": "...",
///   "fieldErrors": [ { "field": "reportRecipients", "message": "..." } ] }
/// ```
/// Auth endpoints keep their legacy `{ message | error }` shape; [from]
/// tolerates both.
class ApiError implements Exception {
  const ApiError({
    required this.code,
    required this.message,
    this.status,
    this.fieldErrors = const {},
    this.retryAfter,
  });

  final String code;
  final String message;
  final int? status;

  /// field name → first message
  final Map<String, String> fieldErrors;
  final Duration? retryAfter;

  static const validationFailed = 'VALIDATION_FAILED';
  static const notFound = 'NOT_FOUND';
  static const unauthorized = 'UNAUTHORIZED';
  static const forbidden = 'FORBIDDEN';
  static const conflict = 'CONFLICT';
  static const accountLocked = 'ACCOUNT_LOCKED';
  static const rateLimited = 'RATE_LIMITED';
  static const notImplemented = 'NOT_IMPLEMENTED';
  static const internal = 'INTERNAL_ERROR';
  static const network = 'NETWORK';
  static const unknown = 'UNKNOWN';

  bool get isNetwork => code == network;

  factory ApiError.from(Object error) {
    if (error is ApiError) return error;
    if (error is! DioException) {
      return ApiError(code: unknown, message: error.toString());
    }
    final res = error.response;
    if (res == null) {
      return ApiError(code: network, message: error.message ?? 'Network error');
    }
    final data = res.data;
    String? code;
    String? message;
    final fields = <String, String>{};
    if (data is Map<String, dynamic>) {
      code = data['code']?.toString();
      final m = data['message'] ?? data['error'];
      if (m is String && m.isNotEmpty) message = m;
      final fe = data['fieldErrors'];
      if (fe is List) {
        for (final f in fe) {
          if (f is Map<String, dynamic>) {
            final name = f['field']?.toString();
            if (name != null && !fields.containsKey(name)) {
              fields[name] = f['message']?.toString() ?? '';
            }
          }
        }
      }
    }
    code ??= switch (res.statusCode) {
      401 => unauthorized,
      403 => forbidden,
      404 => notFound,
      409 => conflict,
      422 => validationFailed,
      423 => accountLocked,
      429 => rateLimited,
      501 => notImplemented,
      _ => (res.statusCode ?? 0) >= 500 ? internal : unknown,
    };
    final ra = res.headers.value('retry-after');
    return ApiError(
      code: code,
      message: message ?? 'Request failed (${res.statusCode})',
      status: res.statusCode,
      fieldErrors: fields,
      retryAfter: ra == null ? null : Duration(seconds: int.tryParse(ra) ?? 0),
    );
  }

  @override
  String toString() => message;
}
