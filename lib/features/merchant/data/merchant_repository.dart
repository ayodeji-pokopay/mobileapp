import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/models/merchant_models.dart';

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

class MerchantRepository {
  MerchantRepository(this._api);

  final ApiClient _api;

  Future<MerchantSettlementSummary> fetchSummary({String? mid}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/api/v1/merchant/reports/summary',
      queryParameters: {if (mid != null) 'mid': mid},
    );
    return MerchantSettlementSummary.fromJson(res.data ?? const {});
  }

  Future<MerchantSalesReportResponse> fetchSales({
    String? mid,
    String? tid,
    String period = 'WEEKLY',
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/api/v1/merchant/reports/sales',
      queryParameters: {
        if (mid != null) 'mid': mid,
        if (tid != null) 'tid': tid,
        'period': period,
        if (startDate != null) 'startDate': _formatDate(startDate),
        if (endDate != null) 'endDate': _formatDate(endDate),
      },
    );
    return MerchantSalesReportResponse.fromJson(res.data ?? const {});
  }

  Future<PageSettlementResponse> fetchSettlements({
    String? mid,
    DateTime? startDate,
    DateTime? endDate,
    int page = 0,
    int size = 20,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/api/v1/merchant/reports/settlements',
      queryParameters: {
        if (mid != null) 'mid': mid,
        if (startDate != null) 'startDate': _formatDate(startDate),
        if (endDate != null) 'endDate': _formatDate(endDate),
        'page': page,
        'size': size,
      },
    );
    return PageSettlementResponse.fromJson(res.data ?? const {});
  }

  Future<SettlementResponse> fetchSettlement(String reference) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/api/v1/merchant/reports/settlements/$reference',
    );
    return SettlementResponse.fromJson(res.data ?? const {});
  }

  Future<List<String>> fetchTerminals({String? mid}) async {
    final res = await _api.dio.get<List<dynamic>>(
      '/api/v1/merchant/reports/terminals',
      queryParameters: {if (mid != null) 'mid': mid},
    );
    return (res.data ?? const []).map((e) => e.toString()).toList();
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

  Future<Map<String, dynamic>> fetchMerchantByMid(String mid) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/api/v1/merchants/mid/$mid',
    );
    return res.data ?? const {};
  }

  String _formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}

final merchantRepositoryProvider = Provider<MerchantRepository>((ref) {
  return MerchantRepository(ref.watch(apiClientProvider));
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
