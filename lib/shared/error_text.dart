import 'package:dio/dio.dart';

import '../core/api/api_error.dart';
import '../l10n/generated/app_localizations.dart';

/// Human copy for any error surfaced to a screen. Standard `/merchant/**`
/// bodies are mapped by [ApiError.code]; anything else falls back to its
/// own message.
String describeError(Object error, AppLocalizations l10n) {
  final e = error is DioException || error is ApiError
      ? ApiError.from(error)
      : null;
  if (e == null) {
    return error.toString().replaceFirst('Exception: ', '');
  }
  return switch (e.code) {
    ApiError.network => l10n.errorNetwork,
    ApiError.validationFailed =>
      e.fieldErrors.isNotEmpty
          ? e.fieldErrors.values.first
          : (e.message.isNotEmpty ? e.message : l10n.errorValidation),
    ApiError.notFound => l10n.errorNotFound,
    ApiError.unauthorized => l10n.errorUnauthorized,
    ApiError.forbidden => l10n.errorForbidden,
    ApiError.conflict => e.message.isNotEmpty ? e.message : l10n.errorConflict,
    ApiError.accountLocked => l10n.errorAccountLocked,
    ApiError.rateLimited => l10n.errorRateLimited,
    ApiError.notImplemented => l10n.errorNotImplemented,
    ApiError.internal => l10n.errorInternal,
    _ => e.message.isNotEmpty ? e.message : l10n.errorUnknown,
  };
}
