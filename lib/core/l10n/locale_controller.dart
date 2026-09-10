import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Languages the app ships. Native names are shown in the picker.
class AppLanguage {
  const AppLanguage(this.code, this.nativeName, this.englishName);
  final String code;
  final String nativeName;
  final String englishName;
  Locale get locale => Locale(code);

  static const all = [
    AppLanguage('en', 'English', 'English'),
    AppLanguage('yo', 'Yorùbá', 'Yoruba'),
    AppLanguage('ha', 'Hausa', 'Hausa'),
    AppLanguage('ig', 'Igbo', 'Igbo'),
    AppLanguage('pcm', 'Naijá (Pidgin)', 'Nigerian Pidgin'),
  ];
}

/// User's language choice; null follows the phone setting.
class LocaleController extends Notifier<Locale?> {
  static const _key = 'pref_locale';

  @override
  Locale? build() {
    _load();
    return null;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code != null && code.isNotEmpty) state = Locale(code);
  }

  Future<void> set(Locale? locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_key);
    } else {
      await prefs.setString(_key, locale.languageCode);
    }
  }
}

final localeProvider = NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);

/// Flutter's Material/Cupertino strings don't exist for Yoruba, Hausa,
/// Igbo or Pidgin. These delegates answer for every locale and hand back
/// English strings when Flutter has no translation, so date pickers and
/// system dialogs keep working.
class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();
  static const _en = Locale('en');

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    final d = GlobalMaterialLocalizations.delegate;
    return d.load(d.isSupported(locale) ? locale : _en);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();
  static const _en = Locale('en');

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    final d = GlobalCupertinoLocalizations.delegate;
    return d.load(d.isSupported(locale) ? locale : _en);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}

class FallbackWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const FallbackWidgetsLocalizationsDelegate();
  static const _en = Locale('en');

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    final d = GlobalWidgetsLocalizations.delegate;
    return d.load(d.isSupported(locale) ? locale : _en);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
