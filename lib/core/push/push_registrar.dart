import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/auth_controller.dart';
import '../router/app_router.dart';
import '../security/device_integrity.dart';
import '../../features/merchant/presentation/merchant_providers.dart';
import 'push_service.dart';

/// Keeps the backend's push registration in step with who is signed in
/// and the "push notifications" preference. Watched from the app root.
final pushRegistrarProvider = Provider<void>((ref) {
  final auth = ref.watch(authControllerProvider);
  final mid = auth.mid;
  if (auth.status != AuthStatus.authenticated || mid == null) return;
  // Simulators and emulators can't receive push; don't prompt for it.
  final integrity = ref.watch(deviceIntegrityProvider).asData?.value;
  debugPrint(
    'push: registrar integrity=${integrity == null ? 'pending' : 'emulator=${integrity.emulator}'}',
  );
  if (integrity == null || integrity.emulator) return;
  final enabled =
      ref.watch(preferencesProvider).asData?.value.pushEnabled ?? true;
  final push = ref.read(pushServiceProvider);
  if (enabled) {
    push.register(mid: mid).catchError((_) {});
  } else {
    push.unregister(mid: mid);
  }
});

/// A push arriving while the app is open: show a banner and refresh
/// the bell.
final pushMessagesProvider = Provider<void>((ref) {
  if (!firebaseReady) return;
  final push = ref.read(pushServiceProvider);
  push.initForeground();
  final sub = FirebaseMessaging.onMessage.listen((m) {
    ref.invalidate(notificationsProvider);
    push.showForeground(m);
  });
  ref.onDispose(sub.cancel);
});

/// `data` of the push the user tapped, from any state: terminated
/// (launch message), background, or a foreground banner.
final pushTapProvider = StreamProvider<Map<String, dynamic>>((ref) async* {
  if (!firebaseReady) return;
  final push = ref.read(pushServiceProvider);
  final initial = await FirebaseMessaging.instance.getInitialMessage();
  if (initial != null) yield initial.data;
  final controller = StreamController<Map<String, dynamic>>();
  final subs = [
    FirebaseMessaging.onMessageOpenedApp.listen((m) => controller.add(m.data)),
    push.tapped.listen(controller.add),
  ];
  ref.onDispose(() {
    for (final s in subs) {
      s.cancel();
    }
    controller.close();
  });
  yield* controller.stream;
});

/// Where a tapped push should take the user, by its `type`.
String pushRouteFor(Map<String, dynamic> data) {
  final type = (data['type'] ?? '').toString().toUpperCase();
  return switch (type) {
    'SETTLEMENT_PAID' ||
    'SETTLEMENT_COMPLETED' ||
    'SETTLEMENT_FAILED' ||
    'SETTLEMENT_PENDING' => '${AppRoutes.settlements}?tab=history',
    _ => AppRoutes.notifications,
  };
}
