import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/config/app_config.dart';

void main() {
  group('compareVersions', () {
    test('compares numerically per segment', () {
      expect(compareVersions('1.2.10', '1.2.9'), greaterThan(0));
      expect(compareVersions('1.0.0', '1.0.0'), 0);
      expect(compareVersions('0.9', '1.0.0'), lessThan(0));
      expect(compareVersions('1.0.0+12', '1.0.0'), 0);
    });
  });

  group('AppConfig', () {
    test('defaults are permissive', () {
      const c = AppConfig.defaults;
      expect(c.requiresUpdate('0.0.1'), isFalse);
      expect(c.maintenance.enabled, isFalse);
      expect(c.currency.code, 'NGN');
      expect(c.features.paymentLinks, isFalse);
    });

    test('parses a full payload', () {
      final c = AppConfig.fromJson({
        'minSupportedVersion': '1.1.0',
        'latestVersion': '1.2.0',
        'forceUpdate': false,
        'storeUrl': 'https://example.com',
        'maintenance': {'enabled': true, 'message': 'Back at 3pm'},
        'support': {'email': 'help@pokopayng.com'},
        'features': {'paymentLinks': true, 'invoices': false},
        'currency': {'code': 'NGN', 'symbol': '₦'},
      });
      expect(c.requiresUpdate('1.0.9'), isTrue);
      expect(c.requiresUpdate('1.1.0'), isFalse);
      expect(c.maintenance.enabled, isTrue);
      expect(c.maintenance.message, 'Back at 3pm');
      expect(c.support.email, 'help@pokopayng.com');
      expect(c.features.paymentLinks, isTrue);
    });

    test('forceUpdate wins regardless of version', () {
      final c = AppConfig.fromJson({'forceUpdate': true});
      expect(c.requiresUpdate('99.0.0'), isTrue);
    });

    test('ignores malformed nested objects', () {
      final c = AppConfig.fromJson({'maintenance': 'yes', 'currency': 42});
      expect(c.maintenance.enabled, isFalse);
      expect(c.currency.symbol, '₦');
    });
  });
}
