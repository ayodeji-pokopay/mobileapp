import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/models/business_models.dart';
import '../../../core/api/models/insights_models.dart';
import '../../../core/api/models/staff_models.dart';
import '../../../core/api/models/merchant_models.dart';
import '../../../core/api/models/transaction_models.dart';
import '../../../core/api/models/wallet_models.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../insights/insights_stats.dart';
import '../data/merchant_repository.dart';
export '../data/merchant_repository.dart' show MerchantSummaryItem;

final _midProvider = Provider<String?>((ref) {
  return ref.watch(authControllerProvider).mid;
});

final summaryProvider = FutureProvider<MerchantSettlementSummary>((ref) {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) {
    return Future.error(
      Exception('No merchant context yet — please re-login.'),
    );
  }
  return ref.watch(merchantRepositoryProvider).fetchSummary(mid: mid);
});

class SalesPeriodNotifier extends Notifier<String> {
  @override
  String build() => 'WEEKLY';

  void set(String value) => state = value;
}

final salesPeriodProvider = NotifierProvider<SalesPeriodNotifier, String>(
  SalesPeriodNotifier.new,
);

final salesReportProvider = FutureProvider<MerchantSalesReportResponse>((ref) {
  final mid = ref.watch(_midProvider);
  final period = ref.watch(salesPeriodProvider);
  if (mid == null || mid.isEmpty) {
    return Future.error(
      Exception('No merchant context yet — please re-login.'),
    );
  }
  return ref
      .watch(merchantRepositoryProvider)
      .fetchSales(mid: mid, period: period);
});

final settlementsProvider = FutureProvider<PageSettlementResponse>((ref) {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) {
    return Future.error(
      Exception('No merchant context yet — please re-login.'),
    );
  }
  return ref
      .watch(merchantRepositoryProvider)
      .fetchSettlements(mid: mid, size: 50);
});

final merchantProfileProvider = FutureProvider<Map<String, dynamic>>((ref) {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) {
    return Future.error(
      Exception('No merchant context yet — please re-login.'),
    );
  }
  return ref.watch(merchantRepositoryProvider).fetchMerchantByMid(mid);
});

/// Weekly sales used for the dashboard sparkline, independent of the
/// period the user picks on the Sales screen.
final weeklySalesProvider = FutureProvider<MerchantSalesReportResponse>((ref) {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) {
    return Future.error(
      Exception('No merchant context yet — please re-login.'),
    );
  }
  return ref
      .watch(merchantRepositoryProvider)
      .fetchSales(mid: mid, period: 'WEEKLY');
});

final terminalsProvider = FutureProvider<List<TerminalResponse>>((ref) {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
  return ref.watch(merchantRepositoryProvider).fetchTerminalsDetailed(mid: mid);
});

Exception _noMerchant() =>
    Exception('No merchant context yet — please re-login.');

/// Merchants the user may switch to, filtered by [query].
final merchantListProvider =
    FutureProvider.family<List<MerchantSummaryItem>, String>((ref, query) {
      return ref
          .watch(merchantRepositoryProvider)
          .searchMerchants(search: query);
    });

/// Display name for the active business: merchant profile name first,
/// then the user's tenant, then the user's own name.
final businessNameProvider = Provider<String>((ref) {
  final profileName = ref
      .watch(merchantProfileProvider)
      .asData
      ?.value['merchantName']
      ?.toString();
  if (profileName != null && profileName.isNotEmpty) return profileName;
  final user = ref.watch(authControllerProvider).user;
  final fromMe = user?.merchantName ?? '';
  if (fromMe.isNotEmpty &&
      !ref.watch(authControllerProvider).canSwitchMerchant) {
    return fromMe;
  }
  final tenant = user?.tenants.isNotEmpty == true
      ? (user!.tenants.first.name ?? '')
      : '';
  if (tenant.isNotEmpty) return tenant;
  final full = [
    user?.firstName,
    user?.lastName,
  ].whereType<String>().join(' ').trim();
  return full.isEmpty ? 'Your business' : full;
});

/// Settlement status filter for the settlements list (server-side).
class SettlementStatusFilter extends Notifier<String?> {
  @override
  String? build() => null;
  void set(String? v) => state = v;
}

final settlementStatusProvider =
    NotifierProvider<SettlementStatusFilter, String?>(
      SettlementStatusFilter.new,
    );

final filteredSettlementsProvider = FutureProvider<PageSettlementResponse>((
  ref,
) {
  final mid = ref.watch(_midProvider);
  final status = ref.watch(settlementStatusProvider);
  if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
  return ref
      .watch(merchantRepositoryProvider)
      .fetchSettlements(mid: mid, status: status, size: 50);
});

final walletProvider = FutureProvider<WalletResponse>((ref) {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
  return ref.watch(merchantRepositoryProvider).fetchWallet(mid);
});

/// Query for the transactions list. Dates are inclusive, in Lagos time.
typedef TransactionQuery = ({String? status, String? last4, int days});

final transactionsProvider =
    FutureProvider.family<PageTransactionResponse, TransactionQuery>((ref, q) {
      final mid = ref.watch(_midProvider);
      if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
      final now = DateTime.now();
      return ref
          .watch(merchantRepositoryProvider)
          .fetchTransactions(
            mid: mid,
            startDate: now.subtract(Duration(days: q.days)),
            endDate: now,
            status: q.status,
            last4: q.last4,
            size: 50,
          );
    });

/// Latest transactions for the dashboard activity feed.
final recentTransactionsProvider = FutureProvider<PageTransactionResponse>((
  ref,
) {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
  // The backend defaults to "today" without dates; ask for the last 30 days.
  final now = DateTime.now();
  return ref
      .watch(merchantRepositoryProvider)
      .fetchTransactions(
        mid: mid,
        startDate: now.subtract(const Duration(days: 30)),
        endDate: now,
        size: 40, // Home shows 8 after role/terminal scoping
      );
});

/// Days covered by a sales period code.
int periodDays(String period) => switch (period) {
  'DAILY' => 1,
  'WEEKLY' => 7,
  'MONTHLY' => 30,
  'YEARLY' => 365,
  _ => 7,
};

/// All transactions inside a sales period, used to draw the daily chart
/// since the report itself has no daily breakdown.
final periodTransactionsProvider =
    FutureProvider.family<PageTransactionResponse, String>((ref, period) {
      final mid = ref.watch(_midProvider);
      if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
      final now = DateTime.now();
      return ref
          .watch(merchantRepositoryProvider)
          .fetchTransactions(
            mid: mid,
            startDate: now.subtract(Duration(days: periodDays(period) - 1)),
            endDate: now,
            size: 500,
          );
    });

/// Sum of approved amounts per calendar day over the last [days] days,
/// oldest first. Days with no sales are zero.
List<double> dailyTotals(List<TransactionResponse> txns, int days) {
  final now = DateTime.now();
  final start = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(Duration(days: days - 1));
  final totals = List<double>.filled(days, 0);
  for (final t in txns) {
    if ((t.status ?? '').toUpperCase() != 'APPROVED') continue;
    final d = DateTime.tryParse(t.transactionDate ?? '')?.toLocal();
    if (d == null) continue;
    final i = DateTime(d.year, d.month, d.day).difference(start).inDays;
    if (i >= 0 && i < days) totals[i] += (t.amount ?? 0).toDouble();
  }
  return totals;
}

final transactionDetailProvider =
    FutureProvider.family<TransactionResponse, String>((ref, reference) {
      final mid = ref.watch(_midProvider);
      if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
      return ref
          .watch(merchantRepositoryProvider)
          .fetchTransaction(reference, mid: mid);
    });

final statementsProvider = FutureProvider.family<List<StatementResponse>, int>((
  ref,
  year,
) {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
  return ref
      .watch(merchantRepositoryProvider)
      .fetchStatements(mid: mid, year: year);
});

/// Server-side merchant preferences with optimistic updates.
class PreferencesController extends AsyncNotifier<MerchantPreferences> {
  @override
  Future<MerchantPreferences> build() {
    final mid = ref.watch(_midProvider);
    if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
    return ref.watch(merchantRepositoryProvider).fetchPreferences(mid: mid);
  }

  Future<void> save({
    bool? dailySettlementReport,
    bool? monthlySettlementReport,
    List<String>? reportRecipients,
    String? language,
    bool? pushEnabled,
    num? dailyTarget,
    num? monthlyTarget,
  }) async {
    final mid = ref.read(_midProvider);
    if (mid == null || mid.isEmpty) throw _noMerchant();
    final previous = state.asData?.value;
    if (previous != null) {
      state = AsyncData(
        previous.copyWith(
          dailyTarget: dailyTarget ?? previous.dailyTarget,
          monthlyTarget: monthlyTarget ?? previous.monthlyTarget,
          dailySettlementReport:
              dailySettlementReport ?? previous.dailySettlementReport,
          monthlySettlementReport:
              monthlySettlementReport ?? previous.monthlySettlementReport,
          reportRecipients: reportRecipients ?? previous.reportRecipients,
          language: language ?? previous.language,
          pushEnabled: pushEnabled ?? previous.pushEnabled,
        ),
      );
    }
    try {
      final saved = await ref
          .read(merchantRepositoryProvider)
          .updatePreferences(
            mid: mid,
            dailySettlementReport: dailySettlementReport,
            monthlySettlementReport: monthlySettlementReport,
            reportRecipients: reportRecipients,
            language: language,
            pushEnabled: pushEnabled,
            dailyTarget: dailyTarget,
            monthlyTarget: monthlyTarget,
          );
      state = AsyncData(saved);
    } catch (e) {
      if (previous != null) state = AsyncData(previous);
      rethrow;
    }
  }
}

final preferencesProvider =
    AsyncNotifierProvider<PreferencesController, MerchantPreferences>(
      PreferencesController.new,
    );

/// Notification feed with unread count; marks everything read on open.
class NotificationsController extends AsyncNotifier<NotificationFeed> {
  @override
  Future<NotificationFeed> build() {
    final mid = ref.watch(_midProvider);
    if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
    return ref.watch(merchantRepositoryProvider).fetchNotifications(mid: mid);
  }

  /// Optimistically marks an alert reviewed, then tells the backend.
  Future<void> acknowledge(String id) async {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        content: [
          for (final n in current.content)
            if (n.id == id) n.copyWith(acknowledged: true, read: true) else n,
        ],
      ),
    );
    try {
      await ref.read(merchantRepositoryProvider).acknowledgeNotification(id);
    } catch (_) {
      ref.invalidateSelf();
      rethrow;
    }
  }

  Future<void> markAllRead() async {
    final mid = ref.read(_midProvider);
    final current = state.asData?.value;
    if (mid == null || current == null || current.unreadCount == 0) return;
    state = AsyncData(
      current.copyWith(
        unreadCount: 0,
        content: [for (final n in current.content) n.copyWith(read: true)],
      ),
    );
    try {
      await ref
          .read(merchantRepositoryProvider)
          .markAllNotificationsRead(mid: mid);
    } catch (_) {
      // Keep the optimistic state; the next refresh reconciles it.
    }
  }
}

final notificationsProvider =
    AsyncNotifierProvider<NotificationsController, NotificationFeed>(
      NotificationsController.new,
    );

// ── Paged lists ─────────────────────────────────────────────────────

/// Inclusive date window plus optional filters for the transactions list.
typedef TransactionFilter = ({
  String? status,
  String? last4,
  DateTime start,
  DateTime end,
});

typedef SettlementFilter = ({String? status, DateTime? start, DateTime? end});

class Paged<T> {
  const Paged({
    required this.items,
    required this.page,
    required this.hasMore,
    this.loadingMore = false,
    this.total,
  });
  final List<T> items;
  final int page;
  final bool hasMore;
  final bool loadingMore;
  final int? total;

  Paged<T> copyWith({
    List<T>? items,
    int? page,
    bool? hasMore,
    bool? loadingMore,
    int? total,
  }) => Paged(
    items: items ?? this.items,
    page: page ?? this.page,
    hasMore: hasMore ?? this.hasMore,
    loadingMore: loadingMore ?? this.loadingMore,
    total: total ?? this.total,
  );
}

const _pageSize = 40;

/// Transactions for a filter, loaded a page at a time. Call [loadMore]
/// when the list nears its end.
class TransactionsList extends AsyncNotifier<Paged<TransactionResponse>> {
  TransactionsList(this.filter);
  final TransactionFilter filter;

  Future<PageTransactionResponse> _fetch(int page) {
    final mid = ref.read(_midProvider);
    if (mid == null || mid.isEmpty) throw _noMerchant();
    return ref
        .read(merchantRepositoryProvider)
        .fetchTransactions(
          mid: mid,
          startDate: filter.start,
          endDate: filter.end,
          status: filter.status,
          last4: filter.last4,
          page: page,
          size: _pageSize,
        );
  }

  @override
  Future<Paged<TransactionResponse>> build() async {
    ref.watch(_midProvider);
    final p = await _fetch(0);
    return Paged(
      items: p.content,
      page: 0,
      hasMore: p.last == false,
      total: p.totalElements,
    );
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(current.copyWith(loadingMore: true));
    try {
      final p = await _fetch(current.page + 1);
      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...p.content],
          page: current.page + 1,
          hasMore: p.last == false,
          loadingMore: false,
          total: p.totalElements,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(loadingMore: false));
    }
  }
}

final transactionsListProvider =
    AsyncNotifierProvider.family<
      TransactionsList,
      Paged<TransactionResponse>,
      TransactionFilter
    >(TransactionsList.new);

class SettlementsList extends AsyncNotifier<Paged<SettlementResponse>> {
  SettlementsList(this.filter);
  final SettlementFilter filter;

  Future<PageSettlementResponse> _fetch(int page) {
    final mid = ref.read(_midProvider);
    if (mid == null || mid.isEmpty) throw _noMerchant();
    return ref
        .read(merchantRepositoryProvider)
        .fetchSettlements(
          mid: mid,
          status: filter.status,
          startDate: filter.start,
          endDate: filter.end,
          page: page,
          size: _pageSize,
        );
  }

  @override
  Future<Paged<SettlementResponse>> build() async {
    ref.watch(_midProvider);
    final p = await _fetch(0);
    return Paged(
      items: p.content,
      page: 0,
      hasMore: p.last == false,
      total: p.totalElements,
    );
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(current.copyWith(loadingMore: true));
    try {
      final p = await _fetch(current.page + 1);
      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...p.content],
          page: current.page + 1,
          hasMore: p.last == false,
          loadingMore: false,
          total: p.totalElements,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(loadingMore: false));
    }
  }
}

final settlementsListProvider =
    AsyncNotifierProvider.family<
      SettlementsList,
      Paged<SettlementResponse>,
      SettlementFilter
    >(SettlementsList.new);

/// Every transaction in the last [days] days, following pages until the
/// backend says it is done (capped at 2000 rows). Powers Insights.
final allTransactionsProvider =
    FutureProvider.family<List<TransactionResponse>, int>((ref, days) async {
      final mid = ref.watch(_midProvider);
      if (mid == null || mid.isEmpty) throw _noMerchant();
      final repo = ref.watch(merchantRepositoryProvider);
      final now = DateTime.now();
      final start = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: days - 1));
      final out = <TransactionResponse>[];
      for (var page = 0; page < 10; page++) {
        final p = await repo.fetchTransactions(
          mid: mid,
          startDate: start,
          endDate: now,
          page: page,
          size: 200,
        );
        out.addAll(p.content);
        if (p.last != false || out.length >= 2000) break;
      }
      return out;
    });

/// Insights for the last [days] days. Uses the backend's reporting
/// endpoints (Lagos-time buckets, previous-period comparison) and falls
/// back to summing the transaction list on the phone if they are not
/// reachable, so the screen keeps working on older backends.
final insightsProvider = FutureProvider.family<InsightsStats, int>((
  ref,
  days,
) async {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) throw _noMerchant();
  final repo = ref.watch(merchantRepositoryProvider);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final start = today.subtract(Duration(days: days - 1));
  final monthStart = DateTime(now.year, now.month, 1);
  try {
    final results = await Future.wait<Object>([
      repo.fetchSummaryComparison(mid: mid, start: start, end: today),
      repo.fetchWeekday(mid: mid, start: start, end: today),
      repo.fetchHourly(mid: mid, start: start, end: today),
      repo.fetchByTerminal(mid: mid, start: start, end: today),
      repo.fetchTimeseries(mid: mid, start: start, end: today),
      repo.fetchTimeseries(mid: mid, start: monthStart, end: today),
    ]);
    return InsightsStats.fromReports(
      comparison: results[0] as SummaryComparison,
      weekday: results[1] as List<WeekdayBucket>,
      hourly: results[2] as List<HourBucket>,
      terminals: results[3] as List<TerminalBucket>,
      series: results[4] as List<DayPoint>,
      monthSeries: results[5] as List<DayPoint>,
      days: days,
      now: now,
    );
  } on DioException catch (e) {
    // Offline: let the caller show the offline state, not stale maths.
    if (MerchantRepository.isOffline(e)) rethrow;
    final txns = await ref.watch(allTransactionsProvider(days).future);
    return InsightsStats.compute(txns, days, now: now);
  }
});

final staffProvider = FutureProvider<List<StaffMember>>((ref) {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) return Future.error(_noMerchant());
  return ref.watch(merchantRepositoryProvider).fetchStaff(mid: mid);
});
