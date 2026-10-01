import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/config/app_config.dart';

void main() {
  test('remote config with wrong types falls back to defaults', () {
    final c = AppConfig.fromJson({
      'minSupportedVersion': 123,
      'latestVersion': null,
      'forceUpdate': 'yes',
      'maintenance': 'down',
      'support': ['x'],
      'features': null,
      'currency': {'symbol': 7, 'code': null, 'locale': ''},
      'security': 'strict',
      'region': {'dialCode': '+234 (0)'},
    });
    expect(c.forceUpdate, isFalse);
    expect(c.maintenance.enabled, isFalse);
    expect(c.security.lockTimeoutMinutes, 15);
    expect(c.dialCode, '2340');
    expect(c.currency.code, isNotEmpty);
    expect(c.currency.symbol, isNotEmpty);
    expect(c.currency.locale, isNotEmpty);
  });

  test('absurd security values are clamped', () {
    final c = AppConfig.fromJson({
      'security': {'lockTimeoutMinutes': -1, 'sessionTimeoutMinutes': 1e9},
    });
    expect(c.security.lockTimeoutMinutes, greaterThanOrEqualTo(0));
    expect(c.security.sessionTimeoutMinutes, lessThanOrEqualTo(24 * 60 * 30));
  });

  test('empty body is the defaults', () {
    final c = AppConfig.fromJson(const {});
    expect(c.features.paymentLinks, isFalse);
    expect(c.security.blockCompromisedDevices, isFalse);
    expect(c.support.email, isNotEmpty);
  });
}
