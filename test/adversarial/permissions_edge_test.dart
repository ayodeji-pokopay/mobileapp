import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/auth_models.dart';
import 'package:pokopay/core/push/push_registrar.dart';
import 'package:pokopay/features/auth/presentation/auth_controller.dart';
import 'package:pokopay/features/dashboard/presentation/dashboard_providers.dart';
import 'package:pokopay/core/api/models/transaction_models.dart';

AuthState user({
  List<String> perms = const [],
  String? role,
  List<String> tids = const [],
}) => AuthState(
  status: AuthStatus.authenticated,
  user: UserInfoResponse(permissions: perms, role: role, terminalIds: tids),
);

void main() {
  test('permission names are matched case-insensitively', () {
    final a = user(perms: const ['view_sales', 'Share_Receipts']);
    expect(
      a.canViewSales,
      isTrue,
      reason: 'backend casing must not lock a cashier out',
    );
    expect(a.canShareReceipts, isTrue);
    expect(a.canViewMoney, isFalse);
  });

  test(
    'whitespace and duplicates in permissions and terminal ids are tolerated',
    () {
      final a = user(
        perms: const [' VIEW_SALES ', 'VIEW_SALES'],
        tids: const [' 2POK0005 ', '2POK0005'],
      );
      expect(a.canViewSales, isTrue);
      expect(a.inScope('2POK0005'), isTrue);
      expect(
        a.inScope('2pok0005'),
        isTrue,
        reason: 'tids compared case-insensitively',
      );
    },
  );

  test('unknown role with an empty list is still the owner', () {
    expect(user(role: 'SOMETHING_NEW').canManageStaff, isTrue);
    expect(
      user(role: 'cashier', perms: const ['VIEW_SALES']).canManageStaff,
      isFalse,
    );
  });

  test('push route survives odd data payloads', () {
    expect(pushRouteFor({'type': 42}), '/notifications');
    expect(pushRouteFor({'type': null}), '/notifications');
    expect(pushRouteFor({'type': 'settlement_paid'}), contains('/settlements'));
    expect(
      () => pushRouteFor({
        'type': ['SETTLEMENT_PAID'],
      }),
      returnsNormally,
    );
  });

  test('activity filter tolerates missing fields', () {
    for (final f in ActivityFilter.values) {
      expect(
        () => matchesActivityFilter(const TransactionResponse(), f),
        returnsNormally,
      );
    }
  });
}
