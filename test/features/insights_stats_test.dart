import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/transaction_models.dart';
import 'package:pokopay/features/insights/insights_stats.dart';

TransactionResponse txn(
  DateTime at,
  num amount, {
  String status = 'APPROVED',
  String tid = 'T1',
}) => TransactionResponse(
  transactionRef: 'REF-${at.millisecondsSinceEpoch}',
  tid: tid,
  amount: amount,
  status: status,
  completedAt: at.toIso8601String(),
);

void main() {
  // Wednesday 9 Sep 2026, 15:00 local.
  final now = DateTime(2026, 9, 9, 15);

  test('aggregates approved transactions by hour, weekday and day', () {
    final s = InsightsStats.compute(
      [
        txn(DateTime(2026, 9, 9, 9), 1000), // Wed 9am
        txn(DateTime(2026, 9, 9, 9, 30), 500), // Wed 9am
        txn(DateTime(2026, 9, 8, 18), 2000, tid: 'T2'), // Tue 6pm
        txn(DateTime(2026, 9, 8, 18), 700, status: 'FAILED'),
        txn(DateTime(2026, 9, 1, 12), 300), // last week
      ],
      30,
      now: now,
    );

    expect(s.count, 5);
    expect(s.approvedCount, 4);
    expect(s.totalSales, 3800);
    expect(s.averageTicket, 950);
    expect(s.approvalRate, closeTo(0.8, 1e-9));
    expect(s.peakHour, 18);
    expect(s.peakWeekday, 2); // Tuesday
    expect(s.byDay.length, 30);
    expect(s.byDay.last, 1500);
    expect(s.thisWeek, 3500);
    expect(s.lastWeek, 300);
    expect(s.weekOnWeek, closeTo(1066.67, 0.01));
    expect(s.monthToDate, 3800);
    expect(s.monthCount, 4);
    expect(s.bestDay, DateTime(2026, 9, 8));
    expect(s.bestDayAmount, 2000);
    expect(s.topTerminal, 'T2');
  });

  test('handles an empty window', () {
    final s = InsightsStats.compute(const [], 7, now: now);
    expect(s.isEmpty, isTrue);
    expect(s.averageTicket, 0);
    expect(s.weekOnWeek, 0);
    expect(s.bestDay, isNull);
  });

  test('week on week is null when last week had no sales', () {
    final s = InsightsStats.compute(
      [txn(DateTime(2026, 9, 9, 9), 100)],
      7,
      now: now,
    );
    expect(s.weekOnWeek, isNull);
  });
}
