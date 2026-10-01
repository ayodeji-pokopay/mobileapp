import 'package:freezed_annotation/freezed_annotation.dart';

import 'lenient.dart';

part 'merchant_models.freezed.dart';
part 'merchant_models.g.dart';

@freezed
abstract class MerchantSettlementSummary with _$MerchantSettlementSummary {
  const factory MerchantSettlementSummary({
    String? mid,
    @LenientInt() int? totalSettlements,
    @LenientNum() num? totalSettledAmount,
    @LenientNum() num? pendingAmount,
    @LenientInt() int? todayTransactions,
    @LenientNum() num? todaySales,
    @LenientNum() num? yesterdaySales,
    @LenientInt() int? yesterdayTransactions,
    @LenientNum() num? sameWeekdayLastWeekSales,
    @LenientNum() num? monthToDateSales,
    TodaySettlement? todaySettlement,
    @LenientInt() int? activeTerminals,
    @LenientInt() int? instantTerminals,
  }) = _MerchantSettlementSummary;

  factory MerchantSettlementSummary.fromJson(Map<String, dynamic> json) =>
      _$MerchantSettlementSummaryFromJson(json);
}

@freezed
abstract class TodaySettlement with _$TodaySettlement {
  const factory TodaySettlement({
    @LenientNum() num? amount,
    String? status,
    String? expectedDate,
    String? settledAt,
    String? failureReason,
  }) = _TodaySettlement;

  factory TodaySettlement.fromJson(Map<String, dynamic> json) =>
      _$TodaySettlementFromJson(json);
}

@freezed
abstract class PeriodTotals with _$PeriodTotals {
  const factory PeriodTotals({
    String? startDate,
    String? endDate,
    @LenientNum() num? totalSales,
    @LenientInt() int? totalTransactionCount,
    @LenientNum() num? totalFees,
    @LenientNum() num? netAmount,
  }) = _PeriodTotals;

  factory PeriodTotals.fromJson(Map<String, dynamic> json) =>
      _$PeriodTotalsFromJson(json);
}

@freezed
abstract class ChannelSummary with _$ChannelSummary {
  const factory ChannelSummary({
    String? channel,
    @LenientNum() num? totalAmount,
    @LenientInt() int? transactionCount,
  }) = _ChannelSummary;

  factory ChannelSummary.fromJson(Map<String, dynamic> json) =>
      _$ChannelSummaryFromJson(json);
}

@freezed
abstract class TerminalSummary with _$TerminalSummary {
  const factory TerminalSummary({
    String? tid,
    String? terminalLocation,
    @LenientNum() num? totalSales,
    @LenientInt() int? transactionCount,
    @LenientNum() num? fees,
  }) = _TerminalSummary;

  factory TerminalSummary.fromJson(Map<String, dynamic> json) =>
      _$TerminalSummaryFromJson(json);
}

@freezed
abstract class CountAmount with _$CountAmount {
  const factory CountAmount({int? count, num? amount}) = _CountAmount;

  factory CountAmount.fromJson(Map<String, dynamic> json) =>
      _$CountAmountFromJson(json);
}

@freezed
abstract class CardSchemeSummary with _$CardSchemeSummary {
  const CardSchemeSummary._();

  const factory CardSchemeSummary({
    String? cardScheme,
    @LenientInt() int? transactionCount,
    @LenientNum() num? totalAmount,
    @LenientNum() num? totalSales,
    @LenientNum() num? totalFees,
    @LenientNum() num? fees,
    @LenientNum() num? netAmount,
    @LenientNum() num? averageTransactionValue,
  }) = _CardSchemeSummary;

  /// The backend sends `totalSales` / `fees`; older shapes used
  /// `totalAmount` / `totalFees`.
  num? get amount => totalAmount ?? totalSales;
  num? get feeAmount => totalFees ?? fees;

  factory CardSchemeSummary.fromJson(Map<String, dynamic> json) =>
      _$CardSchemeSummaryFromJson(json);
}

@freezed
abstract class DailyBreakdown with _$DailyBreakdown {
  const factory DailyBreakdown({
    String? date,
    @LenientInt() int? transactionCount,
    @LenientNum() num? totalAmount,
    @LenientNum() num? totalFees,
    @LenientNum() num? netAmount,
  }) = _DailyBreakdown;

  factory DailyBreakdown.fromJson(Map<String, dynamic> json) =>
      _$DailyBreakdownFromJson(json);
}

@freezed
abstract class MerchantSalesReportResponse with _$MerchantSalesReportResponse {
  const factory MerchantSalesReportResponse({
    String? mid,
    String? merchantName,
    String? businessName,
    String? merchantAddress,
    String? merchantPhone,
    String? merchantEmail,
    String? startDate,
    String? endDate,
    String? reportPeriod,
    @LenientNum() num? totalSales,
    @LenientInt() int? totalTransactionCount,
    @LenientNum() num? totalFees,
    @LenientNum() num? netAmount,
    @Default(<CardSchemeSummary>[]) List<CardSchemeSummary> cardSchemeBreakdown,
    @Default(<DailyBreakdown>[]) List<DailyBreakdown> dailyBreakdown,
    PeriodTotals? previousPeriod,
    @Default(<ChannelSummary>[]) List<ChannelSummary> channelBreakdown,
    @Default(<TerminalSummary>[]) List<TerminalSummary> terminalBreakdown,
    CountAmount? refunds,
    CountAmount? chargebacks,
    @LenientNum() num? totalSettled,
    @LenientNum() num? pendingSettlement,
    @LenientInt() int? settlementCount,
    String? generatedAt,
  }) = _MerchantSalesReportResponse;

  factory MerchantSalesReportResponse.fromJson(Map<String, dynamic> json) =>
      _$MerchantSalesReportResponseFromJson(json);
}

@freezed
abstract class SettlementResponse with _$SettlementResponse {
  const factory SettlementResponse({
    String? id,
    String? settlementReference,
    String? batchReference,
    String? mid,
    String? merchantName,
    String? settlementDate,
    @LenientInt() int? transactionCount,
    @LenientNum() num? totalTransactionAmount,
    @LenientNum() num? totalTransactionFees,
    @LenientNum() num? grossAmount,
    @LenientNum() num? settlementFee,
    @LenientNum() num? netAmount,
    String? accountNumber,
    String? accountName,
    String? bankName,
    String? status,
    String? settledAt,
    String? failureReason,
    String? cycle,
  }) = _SettlementResponse;

  factory SettlementResponse.fromJson(Map<String, dynamic> json) =>
      _$SettlementResponseFromJson(json);
}

@freezed
abstract class PageSettlementResponse with _$PageSettlementResponse {
  const factory PageSettlementResponse({
    @Default(<SettlementResponse>[]) List<SettlementResponse> content,
    @LenientInt() int? totalElements,
    @LenientInt() int? totalPages,
    @LenientInt() int? number,
    @LenientInt() int? size,
    @LenientBool() bool? first,
    @LenientBool() bool? last,
  }) = _PageSettlementResponse;

  factory PageSettlementResponse.fromJson(Map<String, dynamic> json) =>
      _$PageSettlementResponseFromJson(json);
}
