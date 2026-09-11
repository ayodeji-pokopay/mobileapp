import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  final _local = FlutterLocalNotificationsPlugin();
  bool _foregroundReady = false;
  final _tapped = StreamController<Map<String, dynamic>>.broadcast();

  /// `data` of a notification the user tapped (foreground banner).
  Stream<Map<String, dynamic>> get tapped => _tapped.stream;

  static const _channel = AndroidNotificationChannel(
    'pokopay_alerts',
    'Pokopay alerts',
    description: 'Payouts, settlements and account alerts',
    importance: Importance.high,
  );

  /// Lets a push that arrives while the app is open show as a banner.
  /// iOS can present FCM notifications itself; Android needs a local
  /// notification on a channel.
  Future<void> initForeground() async {
    final m = _messaging;
    if (m == null || _foregroundReady) return;
    _foregroundReady = true;
    if (Platform.isIOS) {
      await m.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      return;
    }
    await _local.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (r) {
        final raw = r.payload;
        if (raw == null || raw.isEmpty) return;
        try {
          _tapped.add((jsonDecode(raw) as Map).cast<String, dynamic>());
        } catch (_) {}
      },
    );
    await _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);
  }

  Future<void> showForeground(RemoteMessage m) async {
    if (Platform.isIOS) return; // presented by the system, see above
    final n = m.notification;
    final title = n?.title ?? m.data['title']?.toString();
    final body = n?.body ?? m.data['body']?.toString();
    if (title == null && body == null) return;
    await _local.show(
      id: m.messageId.hashCode,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: jsonEncode(m.data),
    );
  }

  static String get platform => Platform.isIOS ? 'IOS' : 'ANDROID';

  /// Asks for permission, fetches the token and registers it for [mid].
  /// Safe to call repeatedly; only re-posts when token or mid change.
  Future<void> register({required String mid}) async {
    final m = _messaging;
    if (m == null) return;
    debugPrint('push: register start for $mid');
    try {
      final settings = await m.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint('push: permission ${settings.authorizationStatus.name}');
      if (settings.authorizationStatus == AuthorizationStatus.denied) return;
      if (Platform.isIOS) {
        // FCM on iOS needs the APNs token first; it can lag the prompt.
        String? apns;
        for (var i = 0; i < 45 && apns == null; i++) {
          apns = await m.getAPNSToken();
          if (apns == null)
            await Future<void>.delayed(const Duration(seconds: 1));
        }
        debugPrint('push: apns token ${apns == null ? 'missing' : 'ok'}');
      }
      final token = await m.getToken();
      if (token == null || token.isEmpty) {
        debugPrint('push: no FCM token yet');
        return;
      }
      await registerToken(mid: mid, token: token);
      debugPrint(
        'push: registered token …${token.substring(token.length - 8)} for $mid',
      );
      _refreshSub ??= m.onTokenRefresh.listen(
        (t) => registerToken(mid: mid, token: t),
      );
    } catch (e) {
      debugPrint('push: registration failed: $e');
      rethrow;
    }
  }

  Future<void>? _inFlight;

  @visibleForTesting
  Future<void> registerToken({required String mid, required String token}) {
    final key = '$mid:$token';
    if (key == _lastRegisteredKey) return Future.value();
    // Coalesce concurrent callers (auth + preferences both rebuild the
    // registrar on start-up) into one request.
    return _inFlight ??= _post(
      mid: mid,
      token: token,
      key: key,
    ).whenComplete(() => _inFlight = null);
  }

  Future<void> _post({
    required String mid,
    required String token,
    required String key,
  }) async {
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
    if (deviceId != null) {
      try {
        await _api.dio.delete<void>(
          '/api/v1/devices/push/$deviceId',
          queryParameters: {'mid': mid},
        );
      } catch (_) {}
    }
    // Force a fresh token on the next sign-in.
    try {
      await _messaging?.deleteToken();
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
