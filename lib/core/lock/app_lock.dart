import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/auth_controller.dart';
import '../biometric/biometric_service.dart';
import '../storage/secure_storage.dart';

class AppLockSettings {
  const AppLockSettings({
    this.enabled = true,
    this.timeoutMinutes = 15,
    this.useBiometrics = true,
  });
  final bool enabled;

  /// 0 means lock as soon as the app leaves the foreground.
  final int timeoutMinutes;
  final bool useBiometrics;

  AppLockSettings copyWith({
    bool? enabled,
    int? timeoutMinutes,
    bool? useBiometrics,
  }) => AppLockSettings(
    enabled: enabled ?? this.enabled,
    timeoutMinutes: timeoutMinutes ?? this.timeoutMinutes,
    useBiometrics: useBiometrics ?? this.useBiometrics,
  );
}

class AppLockState {
  const AppLockState({
    this.settings = const AppLockSettings(),
    this.locked = false,
    this.covered = false,
    this.failedAttempts = 0,
    this.loaded = false,
    this.hasPin = false,
  });

  /// A PIN has been set; without one only biometrics can unlock.
  final bool hasPin;
  final AppLockSettings settings;

  /// The lock screen is up and needs a PIN or biometric to dismiss.
  final bool locked;

  /// The app is in the background; content is hidden from the switcher.
  final bool covered;
  final int failedAttempts;
  final bool loaded;

  AppLockState copyWith({
    AppLockSettings? settings,
    bool? locked,
    bool? covered,
    int? failedAttempts,
    bool? loaded,
    bool? hasPin,
  }) => AppLockState(
    settings: settings ?? this.settings,
    locked: locked ?? this.locked,
    covered: covered ?? this.covered,
    failedAttempts: failedAttempts ?? this.failedAttempts,
    loaded: loaded ?? this.loaded,
    hasPin: hasPin ?? this.hasPin,
  );
}

/// Locks the app behind Face ID / fingerprint or a PIN after it has been
/// in the background longer than the chosen timeout.
class AppLockController extends Notifier<AppLockState>
    with WidgetsBindingObserver {
  static const _enabledKey = 'lock_enabled';
  static const _timeoutKey = 'lock_timeout_minutes';
  static const _bioKey = 'lock_biometrics';
  static const _pinHashKey = 'lock_pin_hash';
  static const _pinSaltKey = 'lock_pin_salt';
  static const maxAttempts = 5;

  DateTime? _pausedAt;

  @override
  AppLockState build() {
    WidgetsBinding.instance.addObserver(this);
    ref.onDispose(() => WidgetsBinding.instance.removeObserver(this));
    _load();
    return const AppLockState();
  }

  /// Default timeout for users who haven't chosen one; remote config
  /// (`security.lockTimeoutMinutes`) may override it before first load.
  static int defaultTimeoutMinutes = 15;

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final pin = await ref.read(secureStorageProvider).readValue(_pinHashKey);
    // Lock is on by default; the user can change it in Settings › Security.
    state = state.copyWith(
      settings: AppLockSettings(
        enabled: prefs.getBool(_enabledKey) ?? true,
        timeoutMinutes: prefs.getInt(_timeoutKey) ?? defaultTimeoutMinutes,
        useBiometrics: prefs.getBool(_bioKey) ?? true,
      ),
      loaded: true,
      hasPin: pin != null && pin.isNotEmpty,
    );
  }

  bool get _authenticated =>
      ref.read(authControllerProvider).status == AuthStatus.authenticated;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!this.state.settings.enabled || !_authenticated) return;
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        _pausedAt ??= DateTime.now();
        if (!this.state.covered)
          this.state = this.state.copyWith(covered: true);
      case AppLifecycleState.resumed:
        final since = _pausedAt;
        _pausedAt = null;
        final timeout = Duration(minutes: this.state.settings.timeoutMinutes);
        final shouldLock =
            since != null && DateTime.now().difference(since) >= timeout;
        this.state = this.state.copyWith(
          covered: false,
          locked: this.state.locked || shouldLock,
        );
      case AppLifecycleState.detached:
        break;
    }
  }

  /// Lock right now (e.g. from a "Lock" button or tests).
  void lockNow() {
    if (state.settings.enabled) state = state.copyWith(locked: true);
  }

  Future<void> _save(AppLockSettings s) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, s.enabled);
    await prefs.setInt(_timeoutKey, s.timeoutMinutes);
    await prefs.setBool(_bioKey, s.useBiometrics);
    state = state.copyWith(settings: s);
  }

  Future<void> enable({
    String? pin,
    int? timeoutMinutes,
    bool? useBiometrics,
  }) async {
    if (pin != null) await setPin(pin);
    await _save(
      state.settings.copyWith(
        enabled: true,
        timeoutMinutes: timeoutMinutes,
        useBiometrics: useBiometrics,
      ),
    );
  }

  Future<void> disable() async {
    final storage = ref.read(secureStorageProvider);
    await storage.deleteValue(_pinHashKey);
    await storage.deleteValue(_pinSaltKey);
    await _save(state.settings.copyWith(enabled: false));
    state = state.copyWith(
      locked: false,
      covered: false,
      failedAttempts: 0,
      hasPin: false,
    );
  }

  Future<void> setTimeout(int minutes) =>
      _save(state.settings.copyWith(timeoutMinutes: minutes));

  Future<void> setUseBiometrics(bool v) =>
      _save(state.settings.copyWith(useBiometrics: v));

  Future<void> setPin(String pin) async {
    final storage = ref.read(secureStorageProvider);
    final rng = Random.secure();
    final salt = List.generate(
      16,
      (_) => rng.nextInt(256),
    ).map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    await storage.writeValue(_pinSaltKey, salt);
    await storage.writeValue(_pinHashKey, _hash(pin, salt));
    state = state.copyWith(hasPin: true);
  }

  String _hash(String pin, String salt) =>
      sha256.convert(utf8.encode('$salt:$pin')).toString();

  /// Returns true and unlocks on success. After [maxAttempts] failures the
  /// user is signed out.
  Future<bool> verifyPin(String pin) async {
    final storage = ref.read(secureStorageProvider);
    final salt = await storage.readValue(_pinSaltKey);
    final hash = await storage.readValue(_pinHashKey);
    if (salt != null && hash != null && _hash(pin, salt) == hash) {
      state = state.copyWith(locked: false, failedAttempts: 0);
      return true;
    }
    final attempts = state.failedAttempts + 1;
    if (attempts >= maxAttempts) {
      state = state.copyWith(locked: false, failedAttempts: 0);
      await ref.read(authControllerProvider.notifier).logout();
      return false;
    }
    state = state.copyWith(failedAttempts: attempts);
    return false;
  }

  Future<bool> unlockWithBiometrics(String reason) async {
    final ok = await ref
        .read(biometricServiceProvider)
        .authenticate(reason: reason);
    if (ok) state = state.copyWith(locked: false, failedAttempts: 0);
    return ok;
  }
}

final appLockProvider = NotifierProvider<AppLockController, AppLockState>(
  AppLockController.new,
);
