import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../api/api_client.dart';
import '../cache/cache_store.dart';
import '../../shared/format.dart';
import 'app_config.dart';

final packageInfoProvider = FutureProvider<PackageInfo>((_) {
  return PackageInfo.fromPlatform();
});

/// Fetches remote config, falling back to the last cached copy and then to
/// defaults. Never throws, so the app always starts.
final appConfigProvider = FutureProvider<AppConfig>((ref) async {
  final info = await ref.watch(packageInfoProvider.future);
  final cache = ref.watch(cacheStoreProvider);
  final dio = ref.watch(apiClientProvider).dio;
  const key = 'app_config';

  AppConfig apply(AppConfig c) {
    MoneyFormat.configure(
      symbol: c.currency.symbol,
      code: c.currency.code,
      locale: c.currency.locale,
    );
    return c;
  }

  try {
    final res = await dio.get<Map<String, dynamic>>(
      '/api/v1/app/config',
      queryParameters: {'platform': _platform(), 'version': info.version},
      options: Options(
        receiveTimeout: const Duration(seconds: 6),
        extra: const {'skipAuth': true},
      ),
    );
    final json = res.data ?? const <String, dynamic>{};
    await cache.write(key, json);
    return apply(AppConfig.fromJson(json));
  } catch (e) {
    final cached = await cache.read(key);
    if (cached != null) return apply(AppConfig.fromJson(cached.json));
    if (kDebugMode) debugPrint('[config] using defaults: $e');
    return apply(AppConfig.defaults);
  }
});

String _platform() {
  if (kIsWeb) return 'web';
  if (Platform.isIOS) return 'ios';
  if (Platform.isAndroid) return 'android';
  return Platform.operatingSystem;
}
