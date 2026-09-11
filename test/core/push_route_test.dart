import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/push/push_registrar.dart';

void main() {
  test('settlement pushes open settlement history', () {
    expect(
      pushRouteFor({'type': 'SETTLEMENT_PAID', 'reference': 'STL-1'}),
      '/settlements?tab=history',
    );
    expect(
      pushRouteFor({'type': 'settlement_failed'}),
      '/settlements?tab=history',
    );
  });

  test('alerts and unknown types open the notification feed', () {
    expect(
      pushRouteFor({'type': 'SUSPICIOUS_ACTIVITY', 'reference': 'T1'}),
      '/notifications',
    );
    expect(pushRouteFor({}), '/notifications');
  });
}
