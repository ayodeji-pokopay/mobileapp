import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage(this._storage);

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _biometricEmailKey = 'biometric_email';
  static const _biometricPasswordKey = 'biometric_password';

  final FlutterSecureStorage _storage;

  Future<String?> readAccessToken() => _storage.read(key: _accessTokenKey);
  Future<String?> readRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> writeTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  Future<void> clear() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<void> saveBiometricCredentials({
    required String email,
    required String password,
  }) async {
    await _storage.write(key: _biometricEmailKey, value: email);
    await _storage.write(key: _biometricPasswordKey, value: password);
  }

  Future<({String email, String password})?>
      readBiometricCredentials() async {
    final email = await _storage.read(key: _biometricEmailKey);
    final password = await _storage.read(key: _biometricPasswordKey);
    if (email == null || password == null) return null;
    return (email: email, password: password);
  }

  Future<bool> hasBiometricCredentials() async {
    final email = await _storage.read(key: _biometricEmailKey);
    return email != null && email.isNotEmpty;
  }

  Future<void> clearBiometricCredentials() async {
    await _storage.delete(key: _biometricEmailKey);
    await _storage.delete(key: _biometricPasswordKey);
  }
}

final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage(
    const FlutterSecureStorage(
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
  );
});
