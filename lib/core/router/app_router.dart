import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_controller.dart';
import '../../features/auth/presentation/change_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/reports/presentation/reports_screen.dart';
import '../../features/settings/presentation/business_details_screen.dart';
import '../../features/settings/presentation/personal_info_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/settlements/presentation/settlements_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/stores/presentation/stores_screen.dart';
import '../../features/wallet/presentation/wallet_screen.dart';

class AppRoutes {
  AppRoutes._();
  static const splash = '/';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const reports = '/reports';
  static const settlements = '/settlements';
  static const wallet = '/wallet';
  static const stores = '/stores';
  static const notifications = '/notifications';
  static const settings = '/settings';
  static const personalInfo = '/settings/personal';
  static const businessDetails = '/settings/business';
  static const changePassword = '/settings/security/change-password';
}

/// Optional screen to open right after sign-in, for previews and screenshots:
/// `flutter run --dart-define=START_ROUTE=/wallet`. Ignored when empty.
const _startRoute = String.fromEnvironment('START_ROUTE');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: _AuthListenable(ref),
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final loc = state.matchedLocation;
      if (auth.status == AuthStatus.unknown) return AppRoutes.splash;

      final isUnauthed = auth.status == AuthStatus.unauthenticated;
      final isAuthed = auth.status == AuthStatus.authenticated;

      if (isUnauthed && loc != AppRoutes.login) return AppRoutes.login;
      if (isAuthed && (loc == AppRoutes.login || loc == AppRoutes.splash)) {
        return _startRoute.isNotEmpty ? _startRoute : AppRoutes.dashboard;
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (_, _) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.reports,
        builder: (_, _) => const ReportsScreen(),
      ),
      GoRoute(
        path: AppRoutes.settlements,
        builder: (_, state) =>
            SettlementsScreen(initialTab: state.uri.queryParameters['tab']),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (_, _) => const NotificationsScreen(),
      ),
      GoRoute(path: AppRoutes.wallet, builder: (_, _) => const WalletScreen()),
      GoRoute(path: AppRoutes.stores, builder: (_, _) => const StoresScreen()),
      GoRoute(
        path: AppRoutes.settings,
        builder: (_, _) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.personalInfo,
        builder: (_, _) => const PersonalInfoScreen(),
      ),
      GoRoute(
        path: AppRoutes.businessDetails,
        builder: (_, _) => const BusinessDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        builder: (_, _) => const ChangePasswordScreen(),
      ),
    ],
  );
});

class _AuthListenable extends ChangeNotifier {
  _AuthListenable(this._ref) {
    _ref.listen(authControllerProvider, (_, _) => notifyListeners());
  }
  final Ref _ref;
}
