import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/models/business_models.dart';
import '../../../core/api/models/merchant_models.dart';
import '../../../core/api/models/transaction_models.dart';
import '../../../core/api/models/wallet_models.dart';
import '../../auth/presentation/auth_controller.dart';
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
  return ref
      .watch(merchantRepositoryProvider)
      .fetchTransactions(mid: mid, size: 8);
});

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
  }) async {
    final mid = ref.read(_midProvider);
    if (mid == null || mid.isEmpty) throw _noMerchant();
    final previous = state.asData?.value;
    if (previous != null) {
      state = AsyncData(
        previous.copyWith(
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
