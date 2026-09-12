import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/auth_models.dart';
import 'package:pokopay/core/api/models/staff_models.dart';
import 'package:pokopay/features/auth/presentation/auth_controller.dart';

void main() {
  test('staff rows carry status, scope, permissions and inviter', () {
    final m = StaffMember.fromJson({
      'id': '3f9a',
      'email': 'ade@shop.ng',
      'name': 'Ade Bello',
      'role': 'CASHIER',
      'active': true,
      'status': 'INVITED',
      'permissions': ['SHARE_RECEIPTS', 'VIEW_SALES'],
      'terminalIds': ['2POK0005'],
      'invitedAt': '2026-09-12T09:00:00+01:00',
      'acceptedAt': null,
      'lastActiveAt': null,
      'invitedBy': 'owner@shop.ng',
    });
    expect(m.pendingInvite, isTrue);
    expect(m.disabled, isFalse);
    expect(m.terminalIds, ['2POK0005']);
    expect(m.permissions, contains('SHARE_RECEIPTS'));
    expect(m.invitedBy, 'owner@shop.ng');
    expect(m.isOwner, isFalse);

    final off = StaffMember.fromJson({
      'id': 'x',
      'email': 'x@y',
      'role': 'MANAGER',
      'active': false,
      'status': 'DISABLED',
    });
    expect(off.disabled, isTrue);
    expect(off.pendingInvite, isFalse);
  });

  test('activity page parses a Spring page', () {
    final p = StaffActivityPage.fromJson({
      'content': [
        {
          'id': 'a1',
          'action': 'ROLE_CHANGED',
          'actorEmail': 'owner@shop.ng',
          'targetEmail': 'ade@shop.ng',
          'detail': 'CASHIER → MANAGER',
          'createdAt': '2026-09-12T10:03:00+01:00',
        },
      ],
      'last': false,
    });
    expect(p.items.single.action, 'ROLE_CHANGED');
    expect(p.items.single.detail, 'CASHIER → MANAGER');
    expect(p.last, isFalse);
    expect(StaffActivityPage.fromJson(const []).last, isTrue);
  });

  test('cashier terminal scope gates rows; empty scope allows all', () {
    final scoped = AuthState(
      status: AuthStatus.authenticated,
      user: const UserInfoResponse(
        permissions: ['VIEW_SALES', 'SHARE_RECEIPTS'],
        terminalIds: ['2POK0005'],
      ),
    );
    expect(scoped.inScope('2POK0005'), isTrue);
    expect(scoped.inScope('2POK0001'), isFalse);
    expect(scoped.inScope(null), isFalse);
    expect(scoped.canShareReceipts, isTrue);
    expect(scoped.canExportReports, isFalse);
    expect(scoped.canManageTerminals, isFalse);

    final owner = AuthState(
      status: AuthStatus.authenticated,
      user: const UserInfoResponse(),
    );
    expect(owner.inScope('anything'), isTrue);
    expect(owner.canManageStaff, isTrue);
  });
}
