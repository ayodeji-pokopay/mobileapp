import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/auth_controller.dart';
import '../../features/merchant/presentation/merchant_providers.dart';
import 'push_service.dart';

/// Keeps the backend's push registration in step with who is signed in
/// and the "push notifications" preference. Watched from the app root.
final pushRegistrarProvider = Provider<void>((ref) {
  final auth = ref.watch(authControllerProvider);
  final mid = auth.mid;
  if (auth.status != AuthStatus.authenticated || mid == null) return;
  final enabled =
      ref.watch(preferencesProvider).asData?.value.pushEnabled ?? true;
  final push = ref.read(pushServiceProvider);
  if (enabled) {
    push.register(mid: mid).catchError((_) {});
  } else {
    push.unregister(mid: mid);
  }
});

/// A push arriving while the app is open: refresh the bell.
final pushMessagesProvider = Provider<void>((ref) {
  if (!firebaseReady) return;
  final sub = FirebaseMessaging.onMessage.listen((_) {
    ref.invalidate(notificationsProvider);
  });
  ref.onDispose(sub.cancel);
});
