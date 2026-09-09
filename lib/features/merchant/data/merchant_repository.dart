import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/models/merchant_models.dart';
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
    DateTime? startDate,
    DateTime? endDate,
    int page = 0,
    int size = 20,
  }) {
    final key =
        'settlements:$mid:$page:$size:'
        '${startDate == null ? '' : _formatDate(startDate)}:'
        '${endDate == null ? '' : _formatDate(endDate)}';
    return _cached(
      key,
      () async =>
          (await _api.dio.get<Map<String, dynamic>>(
            '/api/v1/merchant/reports/settlements',
            queryParameters: {
              if (mid != null) 'mid': mid,
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
