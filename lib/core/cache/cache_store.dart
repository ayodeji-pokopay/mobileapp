import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachedEntry {
  const CachedEntry({required this.json, required this.savedAt});
  final Map<String, dynamic> json;
  final DateTime savedAt;
}

/// Small JSON cache on top of shared_preferences. Each key stores the last
/// successful response so screens can render while offline.
class CacheStore {
  CacheStore({SharedPreferences? prefs}) : _prefs = prefs;

  SharedPreferences? _prefs;
  static const _prefix = 'cache:';

  Future<SharedPreferences> get _store async =>
      _prefs ??= await SharedPreferences.getInstance();

  Future<void> write(String key, Map<String, dynamic> json) async {
    final p = await _store;
    await p.setString(
      '$_prefix$key',
      jsonEncode({'savedAt': DateTime.now().toIso8601String(), 'data': json}),
    );
  }

  Future<CachedEntry?> read(String key) async {
    final p = await _store;
    final raw = p.getString('$_prefix$key');
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final data = decoded['data'];
      final savedAt = DateTime.tryParse(decoded['savedAt']?.toString() ?? '');
      if (data is! Map<String, dynamic> || savedAt == null) return null;
      return CachedEntry(json: data, savedAt: savedAt);
    } catch (_) {
      return null;
    }
  }

  Future<void> remove(String key) async {
    final p = await _store;
    await p.remove('$_prefix$key');
  }

  Future<void> clear() async {
    final p = await _store;
    for (final k in p.getKeys().where((k) => k.startsWith(_prefix))) {
      await p.remove(k);
    }
  }
}

final cacheStoreProvider = Provider<CacheStore>((_) => CacheStore());
