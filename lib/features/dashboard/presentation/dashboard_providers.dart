import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api/models/business_models.dart';
import '../../../core/api/models/transaction_models.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/data/merchant_repository.dart';
import '../../merchant/presentation/merchant_providers.dart';

// ── Same weekday last week ───────────────────────────────────────────

/// Approved sales on the same weekday last week, from the timeseries
/// endpoint. Null when the backend can't answer (older backend, offline).
final sameWeekdayLastWeekProvider = FutureProvider<double?>((ref) async {
  final mid = ref.watch(authControllerProvider).mid;
  if (mid == null) return null;
  final now = DateTime.now();
  final day = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(const Duration(days: 7));
  try {
    final points = await ref
        .watch(merchantRepositoryProvider)
        .fetchTimeseries(mid: mid, start: day, end: day);
    if (points.isEmpty) return 0;
    return points.fold<double>(0, (a, p) => a + p.approvedAmount);
  } catch (_) {
    return null;
  }
});

// ── Approval health ──────────────────────────────────────────────────

class ApprovalHealth {
  const ApprovalHealth({
    required this.todayCount,
    required this.todayRate,
    required this.baselineRate,
    required this.topReason,
  });

  final int todayCount;

  /// 0..1
  final double todayRate;

  /// 0..1, over the last 30 days; null when unknown.
  final double? baselineRate;
  final String? topReason;

  static const minSample = 5;
  static const dropPoints = 0.15;

  /// Enough sales today, and a decline rate clearly above the norm.
  bool get warning =>
      baselineRate != null &&
      todayCount >= minSample &&
      todayRate < baselineRate! - dropPoints;

  static ApprovalHealth compute(
    List<TransactionResponse> today,
    double? baselineRate,
  ) {
    var approved = 0;
    final reasons = <String, int>{};
    for (final t in today) {
      final status = (t.status ?? '').toUpperCase();
      if (status == 'APPROVED') {
        approved++;
        continue;
      }
      if (status == 'REVERSED') continue;
      final r = (t.responseCodeDescription ?? t.errorMessage ?? '').trim();
      if (r.isNotEmpty) reasons[r] = (reasons[r] ?? 0) + 1;
    }
    String? top;
    var topN = 0;
    reasons.forEach((k, v) {
      if (v > topN) {
        topN = v;
        top = k;
      }
    });
    return ApprovalHealth(
      todayCount: today.length,
      todayRate: today.isEmpty ? 1 : approved / today.length,
      baselineRate: baselineRate,
      topReason: top,
    );
  }
}

final approvalHealthProvider = FutureProvider<ApprovalHealth>((ref) async {
  final mid = ref.watch(authControllerProvider).mid;
  final today = await ref.watch(allTransactionsProvider(1).future);
  double? baseline;
  if (mid != null) {
    try {
      final now = DateTime.now();
      final c = await ref
          .watch(merchantRepositoryProvider)
          .fetchSummaryComparison(
            mid: mid,
            start: DateTime(
              now.year,
              now.month,
              now.day,
            ).subtract(const Duration(days: 30)),
            end: DateTime(
              now.year,
              now.month,
              now.day,
            ).subtract(const Duration(days: 1)),
          );
      if (c.current.total >= 20) baseline = c.current.approvalRate / 100;
    } catch (_) {}
  }
  return ApprovalHealth.compute(today, baseline);
});

// ── Terminal health ──────────────────────────────────────────────────

enum TerminalHealth { online, idle, offline }

TerminalHealth terminalHealth(TerminalResponse t, {DateTime? now}) {
  final seen = DateTime.tryParse(t.lastHeartbeat ?? '');
  if (seen == null) return TerminalHealth.offline;
  final age = (now ?? DateTime.now()).difference(seen.toLocal());
  if (age <= const Duration(minutes: 10)) return TerminalHealth.online;
  if (age <= const Duration(hours: 24)) return TerminalHealth.idle;
  return TerminalHealth.offline;
}

// ── Sales goal (client-side) ─────────────────────────────────────────

class SalesGoal {
  const SalesGoal({this.daily, this.monthly});
  final double? daily;
  final double? monthly;
  bool get isSet => daily != null || monthly != null;
}

class SalesGoalController extends Notifier<SalesGoal> {
  static const _dailyKey = 'goal_daily';
  static const _monthlyKey = 'goal_monthly';

  @override
  SalesGoal build() {
    _load();
    return const SalesGoal();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    state = SalesGoal(
      daily: p.getDouble(_dailyKey),
      monthly: p.getDouble(_monthlyKey),
    );
  }

  Future<void> save({double? daily, double? monthly}) async {
    final p = await SharedPreferences.getInstance();
    if (daily == null || daily <= 0) {
      await p.remove(_dailyKey);
    } else {
      await p.setDouble(_dailyKey, daily);
    }
    if (monthly == null || monthly <= 0) {
      await p.remove(_monthlyKey);
    } else {
      await p.setDouble(_monthlyKey, monthly);
    }
    state = SalesGoal(
      daily: daily == null || daily <= 0 ? null : daily,
      monthly: monthly == null || monthly <= 0 ? null : monthly,
    );
  }
}

final salesGoalProvider = NotifierProvider<SalesGoalController, SalesGoal>(
  SalesGoalController.new,
);

// ── Activity filter ──────────────────────────────────────────────────

enum ActivityFilter { all, approved, declined, reversed }

final activityFilterProvider =
    NotifierProvider<ActivityFilterController, ActivityFilter>(
      ActivityFilterController.new,
    );

class ActivityFilterController extends Notifier<ActivityFilter> {
  @override
  ActivityFilter build() => ActivityFilter.all;
  void set(ActivityFilter f) => state = f;
}

bool matchesActivityFilter(TransactionResponse t, ActivityFilter f) {
  final status = (t.status ?? '').toUpperCase();
  final type = (t.type ?? '').toUpperCase();
  return switch (f) {
    ActivityFilter.all => true,
    ActivityFilter.approved => status == 'APPROVED' && !type.contains('REVERS'),
    ActivityFilter.declined => status == 'DECLINED' || status == 'FAILED',
    ActivityFilter.reversed =>
      status == 'REVERSED' ||
          type.contains('REVERS') ||
          type.contains('REFUND'),
  };
}

/// Most recent approved sale, for "send / print last receipt".
final lastReceiptProvider = Provider<TransactionResponse?>((ref) {
  final page = ref.watch(recentTransactionsProvider).asData?.value;
  if (page == null) return null;
  for (final t in page.content) {
    if ((t.status ?? '').toUpperCase() == 'APPROVED') return t;
  }
  return null;
});
