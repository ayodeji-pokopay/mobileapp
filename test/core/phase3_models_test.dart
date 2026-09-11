import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/business_models.dart';
import 'package:pokopay/core/api/models/merchant_models.dart';
import 'package:pokopay/core/api/models/staff_models.dart';

void main() {
  test('summary carries the new settlement timing and weekday fields', () {
    final s = MerchantSettlementSummary.fromJson({
      'todaySales': 1.0,
      'yesterdaySales': 0,
      'sameWeekdayLastWeekSales': 168500.0,
      'todaySettlement': {
        'amount': 184500.0,
        'status': 'FAILED',
        'expectedDate': '2026-09-12T23:00:00+01:00',
        'settledAt': null,
        'failureReason': 'Bank rejected the transfer',
      },
    });
    expect(s.sameWeekdayLastWeekSales, 168500.0);
    expect(s.todaySettlement?.status, 'FAILED');
    expect(s.todaySettlement?.failureReason, 'Bank rejected the transfer');
    expect(s.todaySettlement?.settledAt, isNull);
  });

  test('preferences carry sales targets', () {
    final p = MerchantPreferences.fromJson({
      'dailySettlementReport': true,
      'monthlySettlementReport': true,
      'reportRecipients': [],
      'language': 'en',
      'pushEnabled': true,
      'dailyTarget': 50000.0,
      'monthlyTarget': null,
    });
    expect(p.dailyTarget, 50000.0);
    expect(p.monthlyTarget, isNull);
  });

  test('staff members parse with sensible defaults', () {
    final m = StaffMember.fromJson({
      'id': 'u1',
      'email': 'ade@shop.ng',
      'name': 'Ade',
      'role': 'cashier',
      'active': true,
      'status': 'INVITED',
    });
    expect(m.role, 'CASHIER');
    expect(m.active, isTrue);
    expect(m.pendingInvite, isTrue);
    final owner = StaffMember.fromJson({
      'id': 'u0',
      'email': 'o@x',
      'role': 'OWNER',
    });
    expect(owner.active, isTrue);
    expect(owner.pendingInvite, isFalse);
  });

  test('decline reasons parse', () {
    final r = DeclineReason.fromJson({
      'responseCode': '06',
      'description': 'Error',
      'count': 54,
    });
    expect(r.count, 54);
    expect(r.description, 'Error');
  });
}
