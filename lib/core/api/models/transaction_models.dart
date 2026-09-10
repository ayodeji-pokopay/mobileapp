import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_models.freezed.dart';
part 'transaction_models.g.dart';

@freezed
abstract class TransactionResponse with _$TransactionResponse {
  const factory TransactionResponse({
    String? reference,
    String? rrn,
    String? stan,
    String? authCode,
    String? mid,
    String? tid,
    String? storeName,
    String? terminalSerial,
    String? merchantAddress,
    String? type,
    String? status,
    String? responseCode,
    num? amount,
    num? fee,
    num? netAmount,
    String? currency,
    String? cardScheme,
    String? cardType,
    String? maskedPan,
    String? channel,
    String? transactionDate,
    String? settlementReference,
    String? settlementStatus,
    String? originalReference,
    String? receiptUrl,
  }) = _TransactionResponse;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);
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
