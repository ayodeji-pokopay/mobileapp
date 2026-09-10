import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Broadcast channel between the HTTP layer and the auth controller.
/// The Dio interceptor calls [expire] when a refresh fails; the controller
/// listens and moves the app to the login screen.
class SessionEvents extends Notifier<int> {
  @override
  int build() => 0;

  void expire() => state = state + 1;
}

final sessionEventsProvider = NotifierProvider<SessionEvents, int>(
  SessionEvents.new,
);
