import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/business_models.dart';
import 'package:pokopay/core/api/models/insights_models.dart';
import 'package:pokopay/features/insights/insights_stats.dart';

void main() {
  // Wednesday 9 Sep 2026, 15:00 local.
  final now = DateTime(2026, 9, 9, 15);

  test('maps the reporting endpoints into the insights view', () {
    final comparison = SummaryComparison.fromJson({
      'current': {
        'total': 120,
        'approved': 100,
        'declined': 14,
        'failed': 6,
        'totalAmount': 612000.00,
        'approvedAmount': 540000.00,
        'approvedFees': 2700.00,
        'avgDurationMs': 4180.5,
        'approvalRate': 83.33,
      },
      'previous': {'total': 100, 'approved': 80, 'approvedAmount': 432000.00},
      'countChangePct': 20.00,
      'approvedChangePct': 25.00,
      'approvedAmountChangePct': 25.00,
    });
    final s = InsightsStats.fromReports(
      comparison: comparison,
      weekday: parseList([
        {
          'isoDayOfWeek': 3,
          'day': 'WEDNESDAY',
          'count': 42,
          'approved': 37,
          'approvalRate': 88.1,
          'approvedAmount': 184500.00,
        },
      ], WeekdayBucket.fromJson),
      hourly: parseList([
        {'hour': 13, 'count': 31, 'approved': 28, 'approvalRate': 90.32},
      ], HourBucket.fromJson),
      terminals: parseList([
        {
          'tid': '2058PK01',
          'count': 210,
          'approved': 198,
          'approvalRate': 94.29,
          'approvedAmount': 980400.00,
        },
        {
          'tid': '2058PK02',
          'count': 10,
          'approved': 9,
          'approvalRate': 90,
          'approvedAmount': 1000.00,
        },
      ], TerminalBucket.fromJson),
      series: parseList([
        {
          'date': '2026-09-08',
          'count': 5,
          'approved': 5,
          'approvedAmount': 2000.0,
        },
        {
          'date': '2026-09-09',
          'count': 3,
          'approved': 3,
          'approvedAmount': 1500.0,
        },
        {
          'date': '2026-09-01',
          'count': 1,
          'approved': 1,
          'approvedAmount': 300.0,
        },
      ], DayPoint.fromJson),
      monthSeries: parseList([
        {
          'date': '2026-09-01',
          'count': 1,
          'approved': 1,
          'approvedAmount': 300.0,
        },
        {
          'date': '2026-09-08',
          'count': 5,
          'approved': 5,
          'approvedAmount': 2000.0,
        },
        {
          'date': '2026-09-09',
          'count': 3,
          'approved': 3,
          'approvedAmount': 1500.0,
        },
      ], DayPoint.fromJson),
      days: 30,
      now: now,
    );

    expect(s.fromServer, isTrue);
    expect(s.totalSales, 540000);
    expect(s.count, 120);
    expect(s.approvedCount, 100);
    expect(s.averageTicket, 5400);
    expect(s.approvalRate, closeTo(0.8333, 1e-4));
    expect(s.fees, 2700);
    expect(s.periodDelta, 25);
    expect(s.periodIsNew, isFalse);
    expect(s.byHourIsCount, isTrue);
    expect(s.peakHour, 13);
    expect(s.byHour[13], 28);
    expect(s.peakWeekday, 3);
    expect(s.byWeekday[2], 184500);
    expect(s.topTerminal, '2058PK01');
    expect(s.byDay.last, 1500);
    expect(s.bestDay, DateTime(2026, 9, 8));
    expect(s.thisWeek, 3500);
    expect(s.lastWeek, 300);
    expect(s.monthToDate, 3800);
    expect(s.monthCount, 9);
  });

  test('a null previous window renders as new', () {
    final c = SummaryComparison.fromJson({
      'current': {
        'total': 3,
        'approved': 3,
        'approvedAmount': 10.0,
        'approvalRate': 100,
      },
      'previous': {'total': 0, 'approved': 0, 'approvedAmount': 0},
      'countChangePct': null,
      'approvedChangePct': null,
      'approvedAmountChangePct': null,
    });
    expect(c.approvedAmountChangePct, isNull);
    final s = InsightsStats.fromReports(
      comparison: c,
      weekday: const [],
      hourly: const [],
      terminals: const [],
      series: const [],
      monthSeries: const [],
      days: 7,
      now: now,
    );
    expect(s.periodIsNew, isTrue);
    expect(s.isEmpty, isFalse);
  });

  test('suspicious-activity notifications parse their extra fields', () {
    final n = NotificationItem.fromJson({
      'id': 'b1e4',
      'type': 'SUSPICIOUS_ACTIVITY',
      'title': 'Unusual reversal activity',
      'body': 'Terminal 2058PK01 recorded 7 reversals…',
      'reference': '2058PK01',
      'read': false,
      'createdAt': '2026-09-10T13:42:07Z',
      'severity': 'HIGH',
      'rule': 'REVERSAL_BURST',
      'evidence': {'tid': '2058PK01', 'reversals': 7, 'windowMinutes': 60},
      'acknowledged': false,
    });
    expect(n.isAlert, isTrue);
    expect(n.needsReview, isTrue);
    expect(n.evidence?['reversals'], 7);
    expect(n.copyWith(acknowledged: true).needsReview, isFalse);

    final plain = NotificationItem.fromJson({
      'id': 'x',
      'type': 'SETTLEMENT_COMPLETED',
      'severity': null,
      'rule': null,
      'evidence': null,
      'acknowledged': false,
    });
    expect(plain.isAlert, isFalse);
  });
}
