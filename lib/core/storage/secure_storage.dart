import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Keychain / Keystore backed storage for session and device credentials.
///
/// Biometric sign-in uses a backend-issued device token, never the
/// user's password.
class SecureStorage {
  SecureStorage(this._storage);

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _expiresAtKey = 'token_expires_at';
  static const _deviceIdKey = 'device_id';
  static const _deviceTokenKey = 'device_token';

  /// Refresh this long before the access token actually expires.
  static const expirySkew = Duration(seconds: 45);

  final FlutterSecureStorage _storage;

  Future<String?> readAccessToken() => _storage.read(key: _accessTokenKey);
  Future<String?> readRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<DateTime?> readTokenExpiry() async {
    final raw = await _storage.read(key: _expiresAtKey);
    return raw == null ? null : DateTime.tryParse(raw);
  }

  Future<void> writeTokens({
    required String accessToken,
    String? refreshToken,
    int? expiresIn,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
    if (expiresIn != null && expiresIn > 0) {
      final at = DateTime.now().add(Duration(seconds: expiresIn));
      await _storage.write(key: _expiresAtKey, value: at.toIso8601String());
    } else {
      await _storage.delete(key: _expiresAtKey);
    }
  }

  /// Removes the session tokens only; the device enrolment survives so
  /// the user can sign back in with biometrics.
  Future<void> clear() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _expiresAtKey);
  }

  /// Stable per-install identifier, created on first use.
  Future<String> ensureDeviceId() async {
    final existing = await _storage.read(key: _deviceIdKey);
    if (existing != null && existing.isNotEmpty) return existing;
    final rng = Random.secure();
    final id = List.generate(
      16,
      (_) => rng.nextInt(256),
    ).map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    await _storage.write(key: _deviceIdKey, value: id);
    return id;
  }

  Future<String?> readDeviceId() => _storage.read(key: _deviceIdKey);
  Future<String?> readDeviceToken() => _storage.read(key: _deviceTokenKey);

  Future<void> writeDeviceToken(String token) =>
      _storage.write(key: _deviceTokenKey, value: token);

  Future<bool> hasDeviceToken() async {
    final t = await _storage.read(key: _deviceTokenKey);
    return t != null && t.isNotEmpty;
  }

  Future<void> clearDeviceToken() => _storage.delete(key: _deviceTokenKey);

  // Generic slots for other secure values (app-lock PIN hash and salt).
  Future<String?> readValue(String key) => _storage.read(key: key);
  Future<void> writeValue(String key, String value) =>
      _storage.write(key: key, value: value);
  Future<void> deleteValue(String key) => _storage.delete(key: key);
}

final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage(
    const FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    ),
  );
});
