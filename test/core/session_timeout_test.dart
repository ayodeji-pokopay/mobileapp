import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/config/app_config.dart';
import 'package:pokopay/core/session/session_timeout.dart';

void main() {
  test('idle sign-out is due after the chosen minutes', () {
    final t0 = DateTime(2026, 9, 15, 9);
    expect(
      idleSignOutDue(t0, t0.add(const Duration(minutes: 59)), 60),
      isFalse,
    );
    expect(idleSignOutDue(t0, t0.add(const Duration(minutes: 60)), 60), isTrue);
    expect(idleSignOutDue(t0, t0.add(const Duration(days: 3)), 0), isFalse);
  });

  test('remote config supplies the default session timeout', () {
    expect(const SecurityInfo().sessionTimeoutMinutes, 60);
    expect(
      AppConfig.fromJson({
        'security': {'sessionTimeoutMinutes': 30},
      }).security.sessionTimeoutMinutes,
      30,
    );
  });
}
