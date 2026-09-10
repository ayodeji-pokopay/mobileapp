import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../config/app_config_provider.dart';
import '../storage/secure_storage.dart';

/// Registers this install's FCM token with the backend
/// (`POST /devices/push`) and removes it on sign-out or when the user
/// turns push off (`DELETE /devices/push/{deviceId}`).
class PushService {
  PushService({
    required ApiClient api,
    required SecureStorage storage,
    required Future<String> Function() appVersion,
    FirebaseMessaging? messaging,
  }) : _api = api,
       _storage = storage,
       _appVersion = appVersion,
       _messaging = messaging;

  final ApiClient _api;
  final SecureStorage _storage;
  final Future<String> Function() _appVersion;
  final FirebaseMessaging? _messaging;

  String? _lastRegisteredKey;
  StreamSubscription<String>? _refreshSub;

  static String get platform => Platform.isIOS ? 'IOS' : 'ANDROID';

  /// Asks for permission, fetches the token and registers it for [mid].
  /// Safe to call repeatedly; only re-posts when token or mid change.
  Future<void> register({required String mid}) async {
    final m = _messaging;
    if (m == null) return;
    final settings = await m.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.denied) return;
    final token = await m.getToken();
    if (token == null || token.isEmpty) return;
    await registerToken(mid: mid, token: token);
    _refreshSub ??= m.onTokenRefresh.listen(
      (t) => registerToken(mid: mid, token: t),
    );
  }

  @visibleForTesting
  Future<void> registerToken({
    required String mid,
    required String token,
  }) async {
    final key = '$mid:$token';
    if (key == _lastRegisteredKey) return;
    final deviceId = await _storage.ensureDeviceId();
    await _api.dio.post<void>(
      '/api/v1/devices/push',
      data: {
        'mid': mid,
        'platform': platform,
        'token': token,
        'deviceId': deviceId,
        'appVersion': await _appVersion(),
      },
    );
    _lastRegisteredKey = key;
  }

  /// Best-effort removal; errors are swallowed so sign-out never blocks.
  Future<void> unregister({required String mid}) async {
    _lastRegisteredKey = null;
    await _refreshSub?.cancel();
    _refreshSub = null;
    final deviceId = await _storage.readDeviceId();
    if (deviceId == null) return;
    try {
      await _api.dio.delete<void>(
        '/api/v1/devices/push/$deviceId',
        queryParameters: {'mid': mid},
      );
    } catch (_) {}
  }
}

final pushServiceProvider = Provider<PushService>((ref) {
  return PushService(
    api: ref.watch(apiClientProvider),
    storage: ref.watch(secureStorageProvider),
    appVersion: () async =>
        (await ref.read(packageInfoProvider.future)).version,
    messaging: firebaseReady ? FirebaseMessaging.instance : null,
  );
});

/// Set by main() once Firebase.initializeApp succeeded. When false (no
/// Firebase config for this platform, or init failed) push is skipped
/// silently and the in-app feed still works.
bool firebaseReady = false;
