import 'package:freezed_annotation/freezed_annotation.dart';

part 'merchant_models.freezed.dart';
part 'merchant_models.g.dart';

@freezed
abstract class MerchantSettlementSummary with _$MerchantSettlementSummary {
  const factory MerchantSettlementSummary({
    String? mid,
    int? totalSettlements,
    num? totalSettledAmount,
    num? pendingAmount,
    int? todayTransactions,
    num? todaySales,
    num? yesterdaySales,
    int? yesterdayTransactions,
    num? monthToDateSales,
    TodaySettlement? todaySettlement,
    int? activeTerminals,
    int? instantTerminals,
  }) = _MerchantSettlementSummary;

  factory MerchantSettlementSummary.fromJson(Map<String, dynamic> json) =>
      _$MerchantSettlementSummaryFromJson(json);
}

@freezed
abstract class TodaySettlement with _$TodaySettlement {
  const factory TodaySettlement({
    num? amount,
    String? status,
    String? expectedDate,
  }) = _TodaySettlement;

  factory TodaySettlement.fromJson(Map<String, dynamic> json) =>
      _$TodaySettlementFromJson(json);
}

@freezed
abstract class PeriodTotals with _$PeriodTotals {
  const factory PeriodTotals({
    String? startDate,
    String? endDate,
    num? totalSales,
    int? totalTransactionCount,
    num? totalFees,
    num? netAmount,
  }) = _PeriodTotals;

  factory PeriodTotals.fromJson(Map<String, dynamic> json) =>
      _$PeriodTotalsFromJson(json);
}

@freezed
abstract class ChannelSummary with _$ChannelSummary {
  const factory ChannelSummary({
    String? channel,
    num? totalAmount,
    int? transactionCount,
  }) = _ChannelSummary;

  factory ChannelSummary.fromJson(Map<String, dynamic> json) =>
      _$ChannelSummaryFromJson(json);
}

@freezed
abstract class TerminalSummary with _$TerminalSummary {
  const factory TerminalSummary({
    String? tid,
    String? terminalLocation,
    num? totalSales,
    int? transactionCount,
    num? fees,
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
    int? transactionCount,
    num? totalAmount,
    num? totalSales,
    num? totalFees,
    num? fees,
    num? netAmount,
    num? averageTransactionValue,
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
    int? transactionCount,
    num? totalAmount,
    num? totalFees,
    num? netAmount,
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
    num? totalSales,
    int? totalTransactionCount,
    num? totalFees,
    num? netAmount,
    @Default(<CardSchemeSummary>[]) List<CardSchemeSummary> cardSchemeBreakdown,
    @Default(<DailyBreakdown>[]) List<DailyBreakdown> dailyBreakdown,
    PeriodTotals? previousPeriod,
    @Default(<ChannelSummary>[]) List<ChannelSummary> channelBreakdown,
    @Default(<TerminalSummary>[]) List<TerminalSummary> terminalBreakdown,
    CountAmount? refunds,
    CountAmount? chargebacks,
    num? totalSettled,
    num? pendingSettlement,
    int? settlementCount,
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
    int? transactionCount,
    num? totalTransactionAmount,
    num? totalTransactionFees,
    num? grossAmount,
    num? settlementFee,
    num? netAmount,
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
    int? totalElements,
    int? totalPages,
    int? number,
    int? size,
    bool? first,
    bool? last,
  }) = _PageSettlementResponse;

  factory PageSettlementResponse.fromJson(Map<String, dynamic> json) =>
      _$PageSettlementResponseFromJson(json);
}
