import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/l10n/generated/app_localizations.dart';

Map<String, dynamic> arb(String code) =>
    jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync())
        as Map<String, dynamic>;

Set<String> placeholders(String s) =>
    RegExp(r'\{(\w+)[,}]').allMatches(s).map((m) => m.group(1)!).toSet();

void main() {
  final en = arb('en');
  final keys = en.keys.where((k) => !k.startsWith('@')).toSet();

  for (final code in ['yo', 'ha', 'ig', 'pcm']) {
    test(
      '$code has every English key with matching placeholders and no empties',
      () {
        final other = arb(code);
        final missing = keys.where((k) => !other.containsKey(k)).toList();
        expect(missing, isEmpty, reason: 'missing in $code');
        final extra = other.keys
            .where((k) => !k.startsWith('@') && !keys.contains(k))
            .toList();
        expect(extra, isEmpty, reason: 'stale keys in $code');
        for (final k in keys) {
          final v = other[k];
          expect(v, isA<String>(), reason: '$code.$k');
          expect((v as String).trim(), isNotEmpty, reason: '$code.$k is empty');
          expect(
            placeholders(v),
            placeholders(en[k] as String),
            reason: '$code.$k placeholders differ',
          );
          final opens = '{'.allMatches(v).length,
              closes = '}'.allMatches(v).length;
          expect(opens, closes, reason: '$code.$k has unbalanced braces');
        }
      },
    );
  }

  test(
    'every supported locale loads and renders plural/placeholder strings',
    () {
      for (final locale in AppLocalizations.supportedLocales) {
        final l10n = lookupAppLocalizations(locale);
        expect(l10n.lockWrongPin(1), isNotEmpty, reason: '$locale');
        expect(l10n.lockWrongPin(3), isNotEmpty, reason: '$locale');
        expect(l10n.sessionTimeoutHours(12), isNotEmpty, reason: '$locale');
        expect(
          l10n.staffInviteSent('a@b.c'),
          contains('a@b.c'),
          reason: '$locale',
        );
        expect(
          l10n.dashboardApprovalWarningBody(40, 85),
          contains('40'),
          reason: '$locale',
        );
      }
      expect(
        AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet(),
        {'en', 'yo', 'ha', 'ig', 'pcm'},
      );
      expect(const Locale('pcm').languageCode, 'pcm');
    },
  );
}
