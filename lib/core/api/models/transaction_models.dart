import 'package:freezed_annotation/freezed_annotation.dart';

import 'lenient.dart';

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
    @LenientNum() num? amount,
    @LenientNum() num? feeAmount,
    String? currencyCode,
    String? status,
    String? responseCode,
    String? responseCodeDescription,
    String? authCode,
    String? processorHost,
    @LenientInt() int? durationMs,
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
  // "TID-STAN-RRN": only trust the parts when they look like a 6-digit
  // STAN and a 12-digit RRN; other references yield nothing rather than
  // a random word on the receipt.
  String? get stan {
    final p = _refParts;
    return p.length >= 3 && RegExp(r'^\d{6}$').hasMatch(p[1]) ? p[1] : null;
  }

  String? get rrn {
    final p = _refParts;
    return p.length >= 3 && RegExp(r'^\d{12}$').hasMatch(p[2]) ? p[2] : null;
  }

  String? get last4 {
    final p = panMasked ?? '';
    return p.length >= 4 ? p.substring(p.length - 4) : null;
  }
}

@freezed
abstract class PageTransactionResponse with _$PageTransactionResponse {
  const factory PageTransactionResponse({
    @Default(<TransactionResponse>[]) List<TransactionResponse> content,
    @LenientInt() int? totalElements,
    @LenientInt() int? totalPages,
    @LenientInt() int? number,
    @LenientInt() int? size,
    @LenientBool() bool? first,
    @LenientBool() bool? last,
  }) = _PageTransactionResponse;

  factory PageTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$PageTransactionResponseFromJson(json);
}
