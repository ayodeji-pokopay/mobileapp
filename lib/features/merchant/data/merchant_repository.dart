import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:typed_data';

import '../../../core/api/api_client.dart';
import '../../../core/api/models/business_models.dart';
import '../../../core/api/models/insights_models.dart';
import '../../../core/api/models/staff_models.dart';
import '../../../core/api/models/merchant_models.dart';
import '../../../core/api/models/transaction_models.dart';
import '../../../core/api/models/wallet_models.dart';
import '../../../core/cache/cache_store.dart';
import '../../../core/connectivity/offline_status.dart';

/// Lightweight merchant row from the platform merchant list.
class MerchantSummaryItem {
  const MerchantSummaryItem({
    required this.mid,
    required this.name,
    required this.email,
    required this.status,
  });
  final String mid;
  final String name;
  final String email;
  final String status;
}

typedef CacheMiss = void Function(DateTime savedAt);
typedef VoidCallback = void Function();

class MerchantRepository {
  MerchantRepository(
    this._api, {
    CacheStore? cache,
    this.onServedFromCache,
    this.onFresh,
  }) : _cache = cache;

  final ApiClient _api;
  final CacheStore? _cache;
  final CacheMiss? onServedFromCache;
  final VoidCallback? onFresh;

  /// Runs [fetch]; on success caches the JSON under [key]. If the network is
  /// unreachable and a cached copy exists, returns that instead and reports
  /// it through [onServedFromCache].
  Future<T> _cached<T>(
    String key,
    Future<Map<String, dynamic>> Function() fetch,
    T Function(Map<String, dynamic> json) parse,
  ) async {
    try {
      final json = await fetch();
      await _cache?.write(key, json);
      onFresh?.call();
      return parse(json);
    } on DioException catch (e) {
      if (_cache != null && isOffline(e)) {
        final entry = await _cache.read(key);
        if (entry != null) {
          onServedFromCache?.call(entry.savedAt);
          return parse(entry.json);
        }
      }
      rethrow;
    }
  }

  static bool isOffline(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return true;
      case DioExceptionType.unknown:
        return e.error is SocketException;
      default:
        return false;
    }
  }

  Future<MerchantSettlementSummary> fetchSummary({String? mid}) {
    return _cached(
      'summary:$mid',
      () async =>
          (await _api.dio.get<Map<String, dynamic>>(
            '/api/v1/merchant/reports/summary',
            queryParameters: {if (mid != null) 'mid': mid},
          )).data ??
          const {},
      MerchantSettlementSummary.fromJson,
    );
  }

  Future<MerchantSalesReportResponse> fetchSales({
    String? mid,
    String? tid,
    String period = 'WEEKLY',
    DateTime? startDate,
    DateTime? endDate,
  }) {
    final key =
        'sales:$mid:$tid:$period:'
        '${startDate == null ? '' : _formatDate(startDate)}:'
        '${endDate == null ? '' : _formatDate(endDate)}';
    return _cached(
      key,
      () async =>
          (await _api.dio.get<Map<String, dynamic>>(
            '/api/v1/merchant/reports/sales',
            queryParameters: {
              if (mid != null) 'mid': mid,
              if (tid != null) 'tid': tid,
              'period': period,
              if (startDate != null) 'startDate': _formatDate(startDate),
              if (endDate != null) 'endDate': _formatDate(endDate),
            },
          )).data ??
          const {},
      MerchantSalesReportResponse.fromJson,
    );
  }

  Future<PageSettlementResponse> fetchSettlements({
    String? mid,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int page = 0,
    int size = 20,
  }) {
    final key =
        'settlements:$mid:$status:$page:$size:'
        '${startDate == null ? '' : _formatDate(startDate)}:'
        '${endDate == null ? '' : _formatDate(endDate)}';
    return _cached(
      key,
      () async =>
          (await _api.dio.get<Map<String, dynamic>>(
            '/api/v1/merchant/reports/settlements',
            queryParameters: {
              if (mid != null) 'mid': mid,
              if (status != null && status.isNotEmpty) 'status': status,
              if (startDate != null) 'startDate': _formatDate(startDate),
              if (endDate != null) 'endDate': _formatDate(endDate),
              'page': page,
              'size': size,
            },
          )).data ??
          const {},
      PageSettlementResponse.fromJson,
    );
  }

  Future<SettlementResponse> fetchSettlement(String reference) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/api/v1/merchant/reports/settlements/$reference',
    );
    return SettlementResponse.fromJson(res.data ?? const {});
  }

  Future<List<String>> fetchTerminals({String? mid}) {
    return _cached(
      'terminals:$mid',
      () async => {
        'items':
            (await _api.dio.get<List<dynamic>>(
              '/api/v1/merchant/reports/terminals',
              queryParameters: {if (mid != null) 'mid': mid},
            )).data ??
            const [],
      },
      (json) => ((json['items'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  /// Merchants visible to the signed-in user (admins see all).
  Future<List<MerchantSummaryItem>> searchMerchants({
    String? search,
    int page = 0,
    int size = 30,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/api/v1/merchants',
      queryParameters: {
        if (search != null && search.isNotEmpty) 'search': search,
        'page': page,
        'size': size,
      },
    );
    final content = (res.data?['content'] as List?) ?? const [];
    return [
      for (final item in content)
        if (item is Map<String, dynamic>)
          MerchantSummaryItem(
            mid: (item['mid'] ?? '').toString(),
            name: (item['merchantName'] ?? item['businessName'] ?? '')
                .toString(),
            email: (item['email'] ?? '').toString(),
            status: (item['status'] ?? '').toString(),
          ),
    ].where((m) => m.mid.isNotEmpty).toList();
  }

  // ── Wallet ──────────────────────────────────────────────────────────

  Future<WalletResponse> fetchWallet(String mid) {
    return _cached(
      'wallet:$mid',
      () async =>
          (await _api.dio.get<Map<String, dynamic>>(
            '/api/v1/wallets/mid/$mid',
          )).data ??
          const {},
      WalletResponse.fromJson,
    );
  }

  // ── Transactions ────────────────────────────────────────────────────

  Future<PageTransactionResponse> fetchTransactions({
    required String mid,
    DateTime? startDate,
    DateTime? endDate,
    String? tid,
    String? status,
    String? last4,
    int page = 0,
    int size = 30,
  }) {
    final query = {
      'mid': mid,
      if (startDate != null) 'startDate': _formatDate(startDate),
      if (endDate != null) 'endDate': _formatDate(endDate),
      if (tid != null && tid.isNotEmpty) 'tid': tid,
      if (status != null && status.isNotEmpty) 'status': status,
      if (last4 != null && last4.isNotEmpty) 'last4': last4,
      'page': page,
      'size': size,
    };
    Future<Map<String, dynamic>> fetch() async =>
        (await _api.dio.get<Map<String, dynamic>>(
          '/api/v1/merchant/transactions',
          queryParameters: query,
        )).data ??
        const {};
    // Only the unfiltered first page is worth keeping for offline use.
    if (page == 0 && (status ?? '').isEmpty && (last4 ?? '').isEmpty) {
      return _cached(
        'transactions:$mid:${query['startDate']}:${query['endDate']}:$tid',
        fetch,
        PageTransactionResponse.fromJson,
      );
    }
    return fetch().then(PageTransactionResponse.fromJson);
  }

  Future<TransactionResponse> fetchTransaction(
    String reference, {
    required String mid,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/api/v1/merchant/transactions/$reference',
      queryParameters: {'mid': mid},
    );
    return TransactionResponse.fromJson(res.data ?? const {});
  }

  // ── Statements & PDFs ───────────────────────────────────────────────

  Future<List<StatementResponse>> fetchStatements({
    required String mid,
    required int year,
  }) {
    return _cached(
      'statements:$mid:$year',
      () async => {
        'items':
            (await _api.dio.get<List<dynamic>>(
              '/api/v1/merchant/statements',
              queryParameters: {'mid': mid, 'year': year},
            )).data ??
            const [],
      },
      (json) => ((json['items'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(StatementResponse.fromJson)
          .toList(),
    );
  }

  Future<Uint8List> downloadStatementPdf(String id, {required String mid}) {
    return _bytes('/api/v1/merchant/statements/$id/pdf', {'mid': mid});
  }

  Future<Uint8List> downloadSalesPdf({
    required String mid,
    String? period,
    DateTime? startDate,
    DateTime? endDate,
    String? tid,
  }) {
    return _bytes('/api/v1/merchant/reports/sales/pdf', {
      'mid': mid,
      if (period != null) 'period': period,
      if (startDate != null) 'startDate': _formatDate(startDate),
      if (endDate != null) 'endDate': _formatDate(endDate),
      if (tid != null && tid.isNotEmpty) 'tid': tid,
    });
  }

  Future<Uint8List> _bytes(String path, Map<String, dynamic> query) async {
    final res = await _api.dio.get<List<int>>(
      path,
      queryParameters: query,
      options: Options(
        responseType: ResponseType.bytes,
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
    return Uint8List.fromList(res.data ?? const []);
  }

  // ── Terminals ───────────────────────────────────────────────────────

  Future<List<TerminalResponse>> fetchTerminalsDetailed({required String mid}) {
    return _cached(
      'terminals-v2:$mid',
      () async => {
        'items':
            (await _api.dio.get<List<dynamic>>(
              '/api/v1/merchant/terminals',
              queryParameters: {'mid': mid},
            )).data ??
            const [],
      },
      (json) => ((json['items'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(TerminalResponse.fromJson)
          .toList(),
    );
  }

  Future<TerminalResponse> updateTerminalLabel({
    required String mid,
    required String id,
    required String label,
  }) async {
    final res = await _api.dio.put<Map<String, dynamic>>(
      '/api/v1/merchant/terminals/$id',
      queryParameters: {'mid': mid},
      data: {'label': label},
    );
    await _cache?.remove('terminals-v2:$mid');
    return TerminalResponse.fromJson(res.data ?? const {});
  }

  // ── Preferences ─────────────────────────────────────────────────────

  Future<MerchantPreferences> fetchPreferences({required String mid}) {
    return _cached(
      'preferences:$mid',
      () async =>
          (await _api.dio.get<Map<String, dynamic>>(
            '/api/v1/merchant/preferences',
            queryParameters: {'mid': mid},
          )).data ??
          const {},
      MerchantPreferences.fromJson,
    );
  }

  /// Partial update: only non-null fields in [changes] are sent.
  Future<MerchantPreferences> updatePreferences({
    required String mid,
    bool? dailySettlementReport,
    bool? monthlySettlementReport,
    List<String>? reportRecipients,
    String? language,
    bool? pushEnabled,
    num? dailyTarget,
    num? monthlyTarget,
  }) async {
    final res = await _api.dio.put<Map<String, dynamic>>(
      '/api/v1/merchant/preferences',
      queryParameters: {'mid': mid},
      data: {
        if (dailyTarget != null) 'dailyTarget': dailyTarget,
        if (monthlyTarget != null) 'monthlyTarget': monthlyTarget,
        if (dailySettlementReport != null)
          'dailySettlementReport': dailySettlementReport,
        if (monthlySettlementReport != null)
          'monthlySettlementReport': monthlySettlementReport,
        if (reportRecipients != null) 'reportRecipients': reportRecipients,
        if (language != null) 'language': language,
        if (pushEnabled != null) 'pushEnabled': pushEnabled,
      },
    );
    final json = res.data ?? const <String, dynamic>{};
    await _cache?.write('preferences:$mid', json);
    return MerchantPreferences.fromJson(json);
  }

  // ── Insights (reports/transactions/*) ───────────────────────────────

  Map<String, dynamic> _window(String mid, DateTime start, DateTime end) => {
    'mid': mid,
    'startDate': _formatDate(start),
    'endDate': _formatDate(end),
  };

  Future<T> _report<T>(
    String name,
    Map<String, dynamic> query,
    T Function(Object? data) parse,
  ) async {
    final res = await _api.dio.get<Object>(
      '/api/v1/merchant/reports/transactions/$name',
      queryParameters: query,
    );
    return parse(res.data);
  }

  Future<SummaryComparison> fetchSummaryComparison({
    required String mid,
    required DateTime start,
    required DateTime end,
  }) => _report(
    'summary-comparison',
    _window(mid, start, end),
    (d) => SummaryComparison.fromJson((d as Map).cast()),
  );

  Future<List<WeekdayBucket>> fetchWeekday({
    required String mid,
    required DateTime start,
    required DateTime end,
  }) => _report(
    'weekday',
    _window(mid, start, end),
    (d) => parseList(d, WeekdayBucket.fromJson),
  );

  Future<List<HourBucket>> fetchHourly({
    required String mid,
    required DateTime start,
    required DateTime end,
  }) => _report(
    'hourly',
    _window(mid, start, end),
    (d) => parseList(d, HourBucket.fromJson),
  );

  Future<List<TerminalBucket>> fetchByTerminal({
    required String mid,
    required DateTime start,
    required DateTime end,
  }) => _report(
    'by-terminal',
    _window(mid, start, end),
    (d) => parseList(d, TerminalBucket.fromJson),
  );

  Future<List<DayPoint>> fetchTimeseries({
    required String mid,
    required DateTime start,
    required DateTime end,
  }) => _report(
    'timeseries',
    _window(mid, start, end),
    (d) => parseList(d, DayPoint.fromJson),
  );

  Future<List<DeclineReason>> fetchDeclineReasons({
    required String mid,
    required DateTime start,
    required DateTime end,
  }) => _report(
    'by-decline-reason',
    _window(mid, start, end),
    (d) => parseList(d, DeclineReason.fromJson),
  );

  // ── Staff ───────────────────────────────────────────────────────────

  List<StaffMember> _staffList(Object? data) {
    final list = data is Map ? data['content'] : data;
    return parseList(list, StaffMember.fromJson);
  }

  Future<List<StaffMember>> fetchStaff({required String mid}) async {
    final res = await _api.dio.get<Object>(
      '/api/v1/merchant/staff',
      queryParameters: {'mid': mid},
    );
    return _staffList(res.data);
  }

  Future<void> inviteStaff({
    required String mid,
    required String email,
    required String name,
    required String role,
  }) async {
    await _api.dio.post<void>(
      '/api/v1/merchant/staff',
      queryParameters: {'mid': mid},
      data: {'email': email, 'name': name, 'role': role},
    );
  }

  Future<void> updateStaff({
    required String mid,
    required String id,
    String? role,
    bool? active,
  }) async {
    await _api.dio.put<void>(
      '/api/v1/merchant/staff/$id',
      queryParameters: {'mid': mid},
      data: {
        if (role != null) 'role': role,
        if (active != null) 'active': active,
      },
    );
  }

  // ── Notifications ───────────────────────────────────────────────────

  Future<NotificationFeed> fetchNotifications({
    required String mid,
    int page = 0,
    int size = 30,
  }) {
    Future<Map<String, dynamic>> fetch() async =>
        (await _api.dio.get<Map<String, dynamic>>(
          '/api/v1/merchant/notifications',
          queryParameters: {'mid': mid, 'page': page, 'size': size},
        )).data ??
        const {};
    if (page == 0) {
      return _cached('notifications:$mid', fetch, NotificationFeed.fromJson);
    }
    return fetch().then(NotificationFeed.fromJson);
  }

  /// Marks a suspicious-activity alert as reviewed (and read); re-arms
  /// detection for that terminal + rule.
  Future<void> acknowledgeNotification(String id) async {
    await _api.dio.post<void>('/api/v1/merchant/notifications/$id/acknowledge');
  }

  Future<void> markNotificationRead(String id) async {
    await _api.dio.post<void>('/api/v1/merchant/notifications/$id/read');
  }

  Future<void> markAllNotificationsRead({required String mid}) async {
    await _api.dio.post<void>(
      '/api/v1/merchant/notifications/read-all',
      queryParameters: {'mid': mid},
    );
  }

  Future<Map<String, dynamic>> fetchMerchantByMid(String mid) {
    return _cached(
      'merchant:$mid',
      () async =>
          (await _api.dio.get<Map<String, dynamic>>(
            '/api/v1/merchants/mid/$mid',
          )).data ??
          const {},
      (json) => json,
    );
  }

  String _formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}

final merchantRepositoryProvider = Provider<MerchantRepository>((ref) {
  return MerchantRepository(
    ref.watch(apiClientProvider),
    cache: ref.watch(cacheStoreProvider),
    onServedFromCache: (savedAt) =>
        ref.read(offlineStatusProvider.notifier).servedFromCache(savedAt),
    onFresh: () => ref.read(offlineStatusProvider.notifier).online(),
  );
});

class ApiError implements Exception {
  ApiError(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  factory ApiError.from(Object error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        final msg = data['message'] ?? data['error'];
        if (msg is String && msg.isNotEmpty) {
          return ApiError(msg, statusCode: error.response?.statusCode);
        }
      }
      return ApiError(
        error.message ?? 'Network error',
        statusCode: error.response?.statusCode,
      );
    }
    return ApiError(error.toString());
  }

  @override
  String toString() => message;
}
