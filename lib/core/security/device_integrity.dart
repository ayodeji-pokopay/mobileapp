import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_device/safe_device.dart';

/// Root / jailbreak signal for the running device. Detection is
/// best-effort (a determined attacker can hide it), which is why the app
/// also never holds card data: this is a deterrent and an audit signal,
/// not the security boundary.
class DeviceIntegrity {
  const DeviceIntegrity({
    required this.compromised,
    required this.emulator,
    required this.developerMode,
  });

  final bool compromised;
  final bool emulator;
  final bool developerMode;

  static const clean = DeviceIntegrity(
    compromised: false,
    emulator: false,
    developerMode: false,
  );
}

final deviceIntegrityProvider = FutureProvider<DeviceIntegrity>((ref) async {
  if (kIsWeb) return DeviceIntegrity.clean;
  // iOS simulator processes carry SIMULATOR_* variables; safe_device does
  // not always report them as unreal.
  final simulator = Platform.environment.keys.any(
    (k) => k.startsWith('SIMULATOR_'),
  );
  Future<bool> probe(Future<bool> call, {required bool fallback}) async {
    try {
      return await call;
    } catch (_) {
      return fallback; // a missing platform method must not flip the answer
    }
  }

  final compromised = await probe(SafeDevice.isJailBroken, fallback: false);
  final real = await probe(SafeDevice.isRealDevice, fallback: true);
  final dev = await probe(SafeDevice.isDevelopmentModeEnable, fallback: false);
  return DeviceIntegrity(
    compromised: compromised,
    emulator: !real || simulator,
    developerMode: dev,
  );
});
