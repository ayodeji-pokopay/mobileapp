import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/config/app_gate.dart';
import 'core/connectivity/offline_status.dart';
import 'core/l10n/locale_controller.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_mode_controller.dart';
import 'features/auth/presentation/auth_controller.dart';
import 'features/merchant/presentation/merchant_providers.dart';
import 'l10n/generated/app_localizations.dart';

/// Sentry DSN, injected at build time:
/// `flutter build apk --dart-define=SENTRY_DSN=https://...`.
/// When empty (local dev), crash reporting is skipped entirely.
const _sentryDsn = String.fromEnvironment('SENTRY_DSN');
const _environment = String.fromEnvironment(
  'APP_ENV',
  defaultValue: 'development',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  const app = ProviderScope(child: PokopayApp());
  if (_sentryDsn.isEmpty) {
    runApp(app);
    return;
  }
  await SentryFlutter.init((options) {
    options.dsn = _sentryDsn;
    options.environment = _environment;
    options.tracesSampleRate = 0.2;
    options.sendDefaultPii = false;
    options.attachScreenshot = false;
    options.beforeSend = (event, hint) {
      // Never ship request bodies or auth headers.
      event.request = null;
      return event;
    };
  }, appRunner: () => runApp(SentryWidget(child: app)));
}

class PokopayApp extends ConsumerWidget {
  const PokopayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Force auth controller to build immediately so _bootstrap runs
    // without waiting for the first router redirect.
    ref.watch(authControllerProvider);
    final router = ref.watch(routerProvider);
    final mode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final platformDark =
        MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    final dark = switch (mode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system => platformDark,
    };
    // Palette getters are read at build time; re-key the app so every
    // widget rebuilds when the palette flips.
    final theme = AppTheme.build(dark: dark);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
        statusBarBrightness: dark ? Brightness.dark : Brightness.light,
      ),
    );

    // Refetch merchant data as soon as connectivity returns.
    ref.listen(connectivityProvider, (prev, next) {
      final wasOffline = prev?.asData?.value == false;
      if (wasOffline && next.asData?.value == true) {
        ref.invalidate(summaryProvider);
        ref.invalidate(settlementsProvider);
        ref.invalidate(salesReportProvider);
        ref.invalidate(weeklySalesProvider);
        ref.invalidate(terminalsProvider);
        ref.invalidate(merchantProfileProvider);
        ref.invalidate(walletProvider);
        ref.invalidate(recentTransactionsProvider);
        ref.invalidate(notificationsProvider);
      }
    });

    return MaterialApp.router(
      key: ValueKey('${AppColors.isDark}-${locale?.languageCode}'),
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: router,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        FallbackMaterialLocalizationsDelegate(),
        FallbackWidgetsLocalizationsDelegate(),
        FallbackCupertinoLocalizationsDelegate(),
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        final l10n = AppLocalizations.of(context);
        return AppGate(
          updateTitle: l10n.updateRequiredTitle,
          updateBody: l10n.updateRequiredBody,
          updateButton: l10n.updateRequiredButton,
          maintenanceTitle: l10n.maintenanceTitle,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
