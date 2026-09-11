import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/auth_models.dart';
import 'package:pokopay/core/api/models/business_models.dart';
import 'package:pokopay/core/api/models/transaction_models.dart';
import 'package:pokopay/core/config/app_config.dart';
import 'package:pokopay/features/auth/presentation/auth_controller.dart';
import 'package:pokopay/features/dashboard/presentation/dashboard_providers.dart';

void main() {
  final now = DateTime(2026, 9, 11, 12);

  group('terminal health', () {
    test('buckets by heartbeat age', () {
      TerminalResponse t(DateTime? seen) =>
          TerminalResponse(tid: 'T', lastHeartbeat: seen?.toIso8601String());
      expect(
        terminalHealth(t(now.subtract(const Duration(minutes: 3))), now: now),
        TerminalHealth.online,
      );
      expect(
        terminalHealth(t(now.subtract(const Duration(hours: 5))), now: now),
        TerminalHealth.idle,
      );
      expect(
        terminalHealth(t(now.subtract(const Duration(days: 2))), now: now),
        TerminalHealth.offline,
      );
      expect(terminalHealth(t(null), now: now), TerminalHealth.offline);
    });
  });

  group('approval health', () {
    TransactionResponse tx(String status, {String? reason}) =>
        TransactionResponse(status: status, responseCodeDescription: reason);

    test('warns when today is well below the baseline', () {
      final h = ApprovalHealth.compute([
        tx('APPROVED'),
        tx('DECLINED', reason: 'Insufficient funds'),
        tx('DECLINED', reason: 'Insufficient funds'),
        tx('FAILED', reason: 'Timeout'),
        tx('REVERSED'),
        tx('DECLINED', reason: 'Card expired'),
      ], 0.85);
      expect(h.todayCount, 6);
      expect(h.todayRate, closeTo(1 / 6, 1e-9));
      expect(h.topReason, 'Insufficient funds');
      expect(h.warning, isTrue);
    });

    test('stays quiet with a small sample or no baseline', () {
      final few = ApprovalHealth.compute([tx('DECLINED'), tx('DECLINED')], 0.9);
      expect(few.warning, isFalse);
      final noBase = ApprovalHealth.compute(
        List.filled(10, tx('DECLINED')),
        null,
      );
      expect(noBase.warning, isFalse);
    });

    test('a normal day does not warn', () {
      final h = ApprovalHealth.compute([
        ...List.filled(9, tx('APPROVED')),
        tx('DECLINED', reason: 'x'),
      ], 0.85);
      expect(h.warning, isFalse);
    });
  });

  group('activity filter', () {
    test('matches by status and type', () {
      final ok = TransactionResponse(
        status: 'APPROVED',
        transactionType: 'PURCHASE',
      );
      final rev = TransactionResponse(
        status: 'APPROVED',
        transactionType: 'REVERSAL',
      );
      final dec = TransactionResponse(status: 'DECLINED');
      expect(matchesActivityFilter(ok, ActivityFilter.approved), isTrue);
      expect(matchesActivityFilter(rev, ActivityFilter.approved), isFalse);
      expect(matchesActivityFilter(rev, ActivityFilter.reversed), isTrue);
      expect(matchesActivityFilter(dec, ActivityFilter.declined), isTrue);
      expect(matchesActivityFilter(dec, ActivityFilter.all), isTrue);
    });
  });

  group('permissions', () {
    AuthState withPerms(List<String> p) => AuthState(
      status: AuthStatus.authenticated,
      user: UserInfoResponse(permissions: p),
    );
    test('empty list is the owner', () {
      final a = withPerms(const []);
      expect(a.canViewMoney, isTrue);
      expect(a.isStaffView, isFalse);
    });
    test('cashier sees sales but not money', () {
      final a = withPerms(const ['VIEW_SALES']);
      expect(a.canViewSales, isTrue);
      expect(a.canViewMoney, isFalse);
      expect(a.canManagePreferences, isFalse);
      expect(a.isStaffView, isTrue);
    });
  });

  test('security config parses with defaults', () {
    expect(const SecurityInfo().lockTimeoutMinutes, 15);
    final s = AppConfig.fromJson({
      'security': {'blockCompromisedDevices': true, 'lockTimeoutMinutes': 5},
      'region': {'dialCode': '+233'},
    });
    expect(s.security.blockCompromisedDevices, isTrue);
    expect(s.security.lockTimeoutMinutes, 5);
    expect(s.dialCode, '233');
    expect(
      AppConfig.fromJson(const {}).security.blockCompromisedDevices,
      isFalse,
    );
  });
}
