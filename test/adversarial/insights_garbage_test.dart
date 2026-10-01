import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/business_models.dart';
import 'package:pokopay/core/api/models/insights_models.dart';
import 'package:pokopay/core/api/models/transaction_models.dart';
import 'package:pokopay/features/dashboard/presentation/dashboard_providers.dart';
import 'package:pokopay/features/insights/insights_stats.dart';

void main() {
  final now = DateTime(2026, 10, 1, 15);

  test(
    'client stats ignore unparseable, future and negative rows without crashing',
    () {
      final s = InsightsStats.compute(
        [
          const TransactionResponse(
            status: 'APPROVED',
            amount: 10,
            completedAt: 'not a date',
          ),
          TransactionResponse(
            status: 'APPROVED',
            amount: 10,
            completedAt: now.add(const Duration(days: 30)).toIso8601String(),
          ),
          TransactionResponse(
            status: 'approved',
            amount: -50,
            completedAt: now.toIso8601String(),
          ),
          TransactionResponse(
            status: 'APPROVED',
            amount: null,
            completedAt: now.toIso8601String(),
            tid: '',
          ),
          TransactionResponse(
            status: null,
            amount: 5,
            completedAt: now.toIso8601String(),
          ),
        ],
        7,
        now: now,
      );
      expect(s.count, 5);
      expect(s.byDay.length, 7);
      expect(() => s.peakHour, returnsNormally);
      expect(() => s.weekOnWeek, returnsNormally);
    },
  );

  test('ten thousand rows compute quickly', () {
    final rows = List.generate(
      10000,
      (i) => TransactionResponse(
        status: i % 3 == 0 ? 'DECLINED' : 'APPROVED',
        amount: i % 500,
        tid: 'T${i % 7}',
        completedAt: now.subtract(Duration(minutes: i * 3)).toIso8601String(),
      ),
    );
    final sw = Stopwatch()..start();
    final s = InsightsStats.compute(rows, 30, now: now);
    sw.stop();
    expect(sw.elapsedMilliseconds, lessThan(1000));
    expect(s.approvedCount, greaterThan(0));
  });

  test('server buckets outside their ranges are ignored', () {
    final s = InsightsStats.fromReports(
      comparison: SummaryComparison.fromJson({
        'current': {
          'total': 1,
          'approved': 1,
          'approvedAmount': 1,
          'approvalRate': 100,
        },
      }),
      weekday: [
        WeekdayBucket.fromJson({'isoDayOfWeek': 9, 'approvedAmount': 5}),
        WeekdayBucket.fromJson({'isoDayOfWeek': 0}),
      ],
      hourly: [
        HourBucket.fromJson({'hour': 25, 'approved': 3}),
        HourBucket.fromJson({'hour': -1}),
      ],
      terminals: const [],
      series: [
        DayPoint.fromJson({'date': 'garbage', 'approvedAmount': 9}),
      ],
      monthSeries: const [],
      days: 7,
      now: now,
    );
    expect(s.byWeekday.every((v) => v == 0), isTrue);
    expect(s.byHour.every((v) => v == 0), isTrue);
    expect(s.byDay.every((v) => v == 0), isTrue);
  });

  test('approval health with declines only and empty reasons', () {
    final h = ApprovalHealth.compute(
      List.filled(
        20,
        const TransactionResponse(
          status: 'DECLINED',
          responseCodeDescription: '',
        ),
      ),
      0.9,
    );
    expect(h.todayRate, 0);
    expect(h.warning, isTrue);
    expect(h.topReason, isNull);
  });

  test('terminal health with timestamps from the future or wrong format', () {
    expect(
      () => terminalHealth(
        const TerminalResponse(lastHeartbeat: '2099-01-01T00:00:00Z'),
      ),
      returnsNormally,
    );
    expect(
      terminalHealth(const TerminalResponse(lastHeartbeat: '12/09/2026')),
      TerminalHealth.offline,
    );
    expect(
      terminalHealth(const TerminalResponse(lastHeartbeat: '')),
      TerminalHealth.offline,
    );
  });
}
