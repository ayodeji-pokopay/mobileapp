import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pokopay/core/api/models/auth_models.dart';
import 'package:pokopay/core/router/app_router.dart';
import 'package:pokopay/features/auth/presentation/auth_controller.dart';

class _Cashier extends AuthController {
  @override
  AuthState build() => const AuthState(
    status: AuthStatus.authenticated,
    user: UserInfoResponse(
      mid: 'M',
      role: 'MERCHANT',
      permissions: ['VIEW_SALES', 'SHARE_RECEIPTS'],
    ),
  );
}

class _SignedOut extends AuthController {
  @override
  AuthState build() => const AuthState(status: AuthStatus.unauthenticated);
}

void main() {
  test(
    'a cashier is bounced off money screens; a visitor off everything private',
    () async {
      final cashier = ProviderContainer(
        overrides: [authControllerProvider.overrideWith(_Cashier.new)],
      );
      addTearDown(cashier.dispose);
      final r = cashier.read(routerProvider);
      for (final loc in [
        AppRoutes.wallet,
        AppRoutes.settlements,
        AppRoutes.insights,
      ]) {
        final target = await _redirectFor(r, loc);
        expect(target, isIn([AppRoutes.dashboard, loc]), reason: loc);
      }
      expect(await _redirectFor(r, AppRoutes.wallet), AppRoutes.dashboard);
      expect(await _redirectFor(r, AppRoutes.settlements), AppRoutes.dashboard);
      expect(
        await _redirectFor(r, AppRoutes.reports),
        AppRoutes.reports,
        reason: 'VIEW_SALES keeps Sales',
      );

      final visitor = ProviderContainer(
        overrides: [authControllerProvider.overrideWith(_SignedOut.new)],
      );
      addTearDown(visitor.dispose);
      final v = visitor.read(routerProvider);
      for (final loc in [
        AppRoutes.dashboard,
        AppRoutes.settings,
        AppRoutes.staff,
        AppRoutes.sessions,
        AppRoutes.wallet,
      ]) {
        expect(await _redirectFor(v, loc), AppRoutes.login, reason: loc);
      }
      for (final loc in [
        AppRoutes.login,
        AppRoutes.forgotPassword,
        AppRoutes.acceptInvite,
      ]) {
        expect(await _redirectFor(v, loc), loc, reason: '$loc stays public');
      }
    },
  );
}

/// Resolves where the router would land for [location] without rendering.
Future<String> _redirectFor(GoRouter r, String location) async {
  final info = await r.routeInformationParser
      .parseRouteInformationWithDependencies(
        RouteInformation(uri: Uri.parse(location)),
        _FakeContext(),
      );
  return info.uri.path;
}

class _FakeContext extends Fake implements BuildContext {
  @override
  bool get mounted => true;
}
