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
  // Current backends carry it on the summary; older ones need timeseries.
  final fromSummary = ref
      .watch(summaryProvider)
      .asData
      ?.value
      .sameWeekdayLastWeekSales;
  if (fromSummary != null) return fromSummary.toDouble();
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
    double? baselineRate, {
    String? topReasonOverride,
  }) {
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
      topReason: topReasonOverride ?? top,
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
  String? serverReason;
  if (mid != null) {
    try {
      final now = DateTime.now();
      final day = DateTime(now.year, now.month, now.day);
      final reasons = await ref
          .watch(merchantRepositoryProvider)
          .fetchDeclineReasons(mid: mid, start: day, end: day);
      reasons.sort((a, b) => b.count.compareTo(a.count));
      final top = reasons.isEmpty ? null : reasons.first;
      if (top != null && top.description.isNotEmpty && top.count > 0) {
        serverReason = top.description;
      }
    } catch (_) {}
  }
  return ApprovalHealth.compute(
    today,
    baseline,
    topReasonOverride: serverReason,
  );
});

// ── Terminal health ──────────────────────────────────────────────────

enum TerminalHealth { online, degraded, idle, offline }

/// The backend's verdict when it sends one (thresholds live server-side
/// so app and console agree); otherwise judged from heartbeat age.
TerminalHealth terminalHealth(TerminalResponse t, {DateTime? now}) {
  switch ((t.health ?? '').toUpperCase()) {
    case 'HEALTHY':
      return TerminalHealth.online;
    case 'DEGRADED':
      return t.healthReasons.contains('STALE')
          ? TerminalHealth.idle
          : TerminalHealth.degraded;
    case 'OFFLINE':
      return TerminalHealth.offline;
  }
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

/// Targets live in merchant preferences (`dailyTarget`, `monthlyTarget`)
/// so every device and staff member sees the same goal; a local copy
/// keeps the ring working offline and on older backends.
class SalesGoalController extends Notifier<SalesGoal> {
  static const _dailyKey = 'goal_daily';
  static const _monthlyKey = 'goal_monthly';

  @override
  SalesGoal build() {
    final prefs = ref.watch(preferencesProvider).asData?.value;
    if (prefs != null &&
        (prefs.dailyTarget != null || prefs.monthlyTarget != null)) {
      final g = SalesGoal(
        daily: _positive(prefs.dailyTarget),
        monthly: _positive(prefs.monthlyTarget),
      );
      _mirror(g);
      return g;
    }
    _load();
    return const SalesGoal();
  }

  static double? _positive(num? v) => v == null || v <= 0 ? null : v.toDouble();

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    state = SalesGoal(
      daily: p.getDouble(_dailyKey),
      monthly: p.getDouble(_monthlyKey),
    );
  }

  Future<void> _mirror(SalesGoal g) async {
    final p = await SharedPreferences.getInstance();
    if (g.daily == null) {
      await p.remove(_dailyKey);
    } else {
      await p.setDouble(_dailyKey, g.daily!);
    }
    if (g.monthly == null) {
      await p.remove(_monthlyKey);
    } else {
      await p.setDouble(_monthlyKey, g.monthly!);
    }
  }

  Future<void> save({double? daily, double? monthly}) async {
    final g = SalesGoal(daily: _positive(daily), monthly: _positive(monthly));
    await _mirror(g);
    state = g;
    try {
      // 0 clears a target server-side (null would leave it untouched).
      await ref
          .read(preferencesProvider.notifier)
          .save(dailyTarget: g.daily ?? 0, monthlyTarget: g.monthly ?? 0);
    } catch (_) {
      // Keep the local value; it syncs on the next successful save.
    }
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
