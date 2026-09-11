import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokopay/core/api/models/transaction_models.dart';
import 'package:pokopay/core/l10n/locale_controller.dart';
import 'package:pokopay/core/theme/app_theme.dart';
import 'package:pokopay/l10n/generated/app_localizations.dart';
import 'package:pokopay/shared/receipt_image.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('receipt renders to a PNG off-screen', (tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.build(dark: false),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          FallbackMaterialLocalizationsDelegate(),
          FallbackWidgetsLocalizationsDelegate(),
          FallbackCupertinoLocalizationsDelegate(),
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (c) {
            ctx = c;
            return const SizedBox();
          },
        ),
      ),
    );
    final t = TransactionResponse(
      transactionRef: 'TID-000123-000456',
      tid: '2POK0001',
      amount: 1500,
      status: 'APPROVED',
      panMasked: '506099******1234',
      cardScheme: 'VERVE',
      completedAt: '2026-09-12T10:00:00Z',
    );
    // Fonts can't be fetched in tests and google_fonts reports that as an
    // uncaught async error; the fallback face is fine for this check.
    final bytes = await tester.runAsync(
      () => runZonedGuarded(
        () => buildReceiptImage(ctx, t: t, business: 'POKOPAY PILOT'),
        (e, _) {
          if (!e.toString().contains('font')) throw e;
        },
      )!,
    );
    expect(bytes, isNotNull);
    expect(bytes!.length, greaterThan(1000));
    // PNG signature
    expect(bytes.sublist(0, 4), [0x89, 0x50, 0x4E, 0x47]);
  });
}
