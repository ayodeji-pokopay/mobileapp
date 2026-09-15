import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/auth_controller.dart';

/// True when the user has been idle (no touch, or app in background)
/// for at least [minutes]. 0 means never sign out automatically.
bool idleSignOutDue(DateTime lastActive, DateTime now, int minutes) {
  if (minutes <= 0) return false;
  return now.difference(lastActive) >= Duration(minutes: minutes);
}

/// Signs the merchant out after a period of inactivity, so a phone left
/// on a counter doesn't stay signed in forever. Distinct from the app
/// lock, which only covers the screen.
class SessionTimeoutController extends Notifier<int>
    with WidgetsBindingObserver {
  static const _key = 'session_timeout_minutes';
  static const _lastActiveKey = 'session_last_active';

  /// Debug builds only: `--dart-define=DEV_SESSION_MINUTES=1`.
  static const _devMinutes = int.fromEnvironment('DEV_SESSION_MINUTES');
  static const options = [15, 30, 60, 720, 0];

  /// Overridden from remote config (`security.sessionTimeoutMinutes`).
  static int defaultMinutes = 60;

  DateTime _lastActive = DateTime.now();
  Timer? _ticker;

  @override
  int build() {
    WidgetsBinding.instance.addObserver(this);
    _ticker = Timer.periodic(const Duration(minutes: 1), (_) => _check());
    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
      _ticker?.cancel();
    });
    _load();
    return defaultMinutes;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt(_key);
    if (saved != null) state = saved;
    if (kDebugMode && _devMinutes > 0) state = _devMinutes;
    // Last activity from the previous process, so a relaunch after a long
    // background stay still signs out.
    final last = prefs.getInt(_lastActiveKey);
    if (last != null) {
      _lastActive = DateTime.fromMillisecondsSinceEpoch(last);
    }
    debugPrint('session: loaded timeout=${state}m lastActive=$_lastActive');
    _check();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastActiveKey, _lastActive.millisecondsSinceEpoch);
  }

  Future<void> setMinutes(int minutes) async {
    state = minutes;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, minutes);
  }

  /// Call on any user interaction.
  void touch() => _lastActive = DateTime.now();

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycle) {
    if (lifecycle == AppLifecycleState.resumed) {
      _check();
    } else {
      _persist();
    }
  }

  void _check() {
    final auth = ref.read(authControllerProvider);
    if (auth.status != AuthStatus.authenticated) {
      _lastActive = DateTime.now();
      return;
    }
    final idleFor = DateTime.now().difference(_lastActive);
    debugPrint('session: check idle=$idleFor timeout=${state}m');
    if (idleSignOutDue(_lastActive, DateTime.now(), state)) {
      _lastActive = DateTime.now();
      _persist();
      debugPrint('session: signing out for inactivity');
      ref.read(authControllerProvider.notifier).logout(idle: true);
    } else {
      _persist();
    }
  }
}

final sessionTimeoutProvider = NotifierProvider<SessionTimeoutController, int>(
  SessionTimeoutController.new,
);
