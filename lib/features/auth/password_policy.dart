import '../../l10n/generated/app_localizations.dart';
import 'data/auth_repository.dart';

/// Backend policy since 30 Sep 2026: 12+ characters with upper and lower
/// case, a digit and a symbol. Returns a message or null when acceptable.
String? validateNewPassword(String? value, AppLocalizations l10n) {
  final v = value ?? '';
  if (v.isEmpty) return l10n.validationNewPasswordRequired;
  if (v.length < minPasswordLength) return l10n.validationPasswordLength;
  if (!meetsPasswordComplexity(v)) return l10n.validationPasswordComplexity;
  return null;
}

const minPasswordLength = 12;

bool meetsPasswordComplexity(String v) =>
    RegExp(r'[A-Z]').hasMatch(v) &&
    RegExp(r'[a-z]').hasMatch(v) &&
    RegExp(r'\d').hasMatch(v) &&
    RegExp(r'[^A-Za-z0-9]').hasMatch(v);

/// Localised copy for auth failures where the backend's own message is the
/// right thing to show (password reuse, lockout) unless the code says
/// otherwise.
String authMessage(AuthException e, AppLocalizations l10n) => switch (e.code) {
  AuthException.network => l10n.errorNetwork,
  AuthException.serverUnavailable => l10n.errorServiceUnavailable,
  AuthException.rateLimited => l10n.errorRateLimited,
  _ => e.message.isNotEmpty ? e.message : l10n.errorUnknown,
};
