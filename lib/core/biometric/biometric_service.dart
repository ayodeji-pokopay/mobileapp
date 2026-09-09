import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  BiometricService(this._auth);

  final LocalAuthentication _auth;

  Future<bool> isAvailable() async {
    try {
      final supported = await _auth.isDeviceSupported();
      if (!supported) return false;
      return await _auth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate({
    String reason = 'Authenticate to continue',
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );
    } catch (_) {
      return false;
    }
  }
}

final biometricServiceProvider = Provider<BiometricService>((_) {
  return BiometricService(LocalAuthentication());
});

final biometricAvailableProvider = FutureProvider<bool>((ref) {
  return ref.watch(biometricServiceProvider).isAvailable();
});
