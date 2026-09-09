import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/models/merchant_models.dart';
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

final terminalsProvider = FutureProvider<List<String>>((ref) {
  final mid = ref.watch(_midProvider);
  if (mid == null || mid.isEmpty) {
    return Future.error(
      Exception('No merchant context yet — please re-login.'),
    );
  }
  return ref.watch(merchantRepositoryProvider).fetchTerminals(mid: mid);
});

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
