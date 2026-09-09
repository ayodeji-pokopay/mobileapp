import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/auth_controller.dart';

void main() {
  // ignore: avoid_print
  print('[pokopay] main() starting');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const ProviderScope(child: PokopayApp()));
}

class PokopayApp extends ConsumerWidget {
  const PokopayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Force auth controller to build immediately so _bootstrap runs
    // without waiting for the first router redirect.
    ref.watch(authControllerProvider);
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Pokopay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}
