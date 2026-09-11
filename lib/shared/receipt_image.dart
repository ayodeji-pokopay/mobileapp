import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../core/api/models/transaction_models.dart';
import '../core/l10n/locale_controller.dart';
import '../core/theme/app_colors.dart';
import '../features/reports/presentation/receipt_sheet.dart';
import '../l10n/generated/app_localizations.dart';

/// Renders the on-screen receipt card to a PNG, off-screen, so it can be
/// shared to WhatsApp, email or saved to Photos. Uses the caller's locale
/// and theme so the image matches what the merchant sees.
Future<Uint8List> buildReceiptImage(
  BuildContext context, {
  required TransactionResponse t,
  required String business,
}) {
  final locale = Localizations.localeOf(context);
  final theme = Theme.of(context);
  final widget = MediaQuery(
    data: const MediaQueryData(
      size: Size(420, 1400),
      devicePixelRatio: 3,
      textScaler: TextScaler.noScaling,
    ),
    child: Localizations(
      locale: locale,
      delegates: const [
        AppLocalizations.delegate,
        FallbackMaterialLocalizationsDelegate(),
        FallbackWidgetsLocalizationsDelegate(),
        FallbackCupertinoLocalizationsDelegate(),
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Theme(
          data: theme,
          child: Material(
            color: AppColors.canvas,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: SizedBox(
                width: 384,
                child: ReceiptCard(t: t, business: business),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  return ScreenshotController().captureFromLongWidget(
    widget,
    delay: const Duration(milliseconds: 250),
    pixelRatio: 3,
    context: context,
    constraints: const BoxConstraints(maxWidth: 420),
  );
}
