import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// User's appearance choice: follow the system, or force light / dark.
/// Persisted locally; the first frame uses the system setting.
class ThemeModeController extends Notifier<ThemeMode> {
  static const _key = 'pref_theme_mode';

  @override
  ThemeMode build() {
    _load();
    return ThemeMode.system;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_key);
    final mode = ThemeMode.values.cast<ThemeMode?>().firstWhere(
      (m) => m?.name == v,
      orElse: () => null,
    );
    if (mode != null && mode != state) state = mode;
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
);
