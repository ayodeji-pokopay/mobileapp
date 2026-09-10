import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_models.freezed.dart';
part 'transaction_models.g.dart';

/// One POS transaction as returned by `GET /merchant/transactions`.
/// Field names follow the backend; derived getters give the app-friendly
/// names used across screens.
@freezed
abstract class TransactionResponse with _$TransactionResponse {
  const TransactionResponse._();

  const factory TransactionResponse({
    String? id,
    String? transactionRef,
    String? tid,
    String? mid,
    String? merchantEmail,
    String? storeName,
    String? transactionType,
    String? panMasked,
    String? cardScheme,
    String? cardBank,
    String? cardBrand,
    String? cardType,
    String? cardCountryCode,
    num? amount,
    num? feeAmount,
    String? currencyCode,
    String? status,
    String? responseCode,
    String? responseCodeDescription,
    String? authCode,
    String? processorHost,
    int? durationMs,
    String? errorMessage,
    String? initiatedAt,
    String? completedAt,
    String? settlementReference,
    String? settlementStatus,
    String? originalReference,
    String? receiptUrl,
  }) = _TransactionResponse;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  String? get reference => transactionRef;
  String? get type => transactionType;
  String? get maskedPan => panMasked;
  num? get fee => feeAmount;
  num? get netAmount => amount == null ? null : amount! - (feeAmount ?? 0);
  String? get transactionDate => completedAt ?? initiatedAt;
  String? get scheme => cardScheme ?? cardBrand;

  /// `transactionRef` is "TID-STAN-RRN"; split it when the parts exist.
  List<String> get _refParts => (transactionRef ?? '').split('-');
  String? get stan => _refParts.length >= 3 ? _refParts[1] : null;
  String? get rrn => _refParts.length >= 3 ? _refParts[2] : null;

  String? get last4 {
    final p = panMasked ?? '';
    return p.length >= 4 ? p.substring(p.length - 4) : null;
  }
}

@freezed
abstract class PageTransactionResponse with _$PageTransactionResponse {
  const factory PageTransactionResponse({
    @Default(<TransactionResponse>[]) List<TransactionResponse> content,
    int? totalElements,
    int? totalPages,
    int? number,
    int? size,
    bool? first,
    bool? last,
  }) = _PageTransactionResponse;

  factory PageTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$PageTransactionResponseFromJson(json);
}
