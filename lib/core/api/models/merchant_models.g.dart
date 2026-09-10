// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MerchantSettlementSummary _$MerchantSettlementSummaryFromJson(
  Map<String, dynamic> json,
) => _MerchantSettlementSummary(
  mid: json['mid'] as String?,
  totalSettlements: (json['totalSettlements'] as num?)?.toInt(),
  totalSettledAmount: json['totalSettledAmount'] as num?,
  pendingAmount: json['pendingAmount'] as num?,
  todayTransactions: (json['todayTransactions'] as num?)?.toInt(),
  todaySales: json['todaySales'] as num?,
  yesterdaySales: json['yesterdaySales'] as num?,
  yesterdayTransactions: (json['yesterdayTransactions'] as num?)?.toInt(),
  monthToDateSales: json['monthToDateSales'] as num?,
  todaySettlement: json['todaySettlement'] == null
      ? null
      : TodaySettlement.fromJson(
          json['todaySettlement'] as Map<String, dynamic>,
        ),
  activeTerminals: (json['activeTerminals'] as num?)?.toInt(),
  instantTerminals: (json['instantTerminals'] as num?)?.toInt(),
);

Map<String, dynamic> _$MerchantSettlementSummaryToJson(
  _MerchantSettlementSummary instance,
) => <String, dynamic>{
  'mid': instance.mid,
  'totalSettlements': instance.totalSettlements,
  'totalSettledAmount': instance.totalSettledAmount,
  'pendingAmount': instance.pendingAmount,
  'todayTransactions': instance.todayTransactions,
  'todaySales': instance.todaySales,
  'yesterdaySales': instance.yesterdaySales,
  'yesterdayTransactions': instance.yesterdayTransactions,
  'monthToDateSales': instance.monthToDateSales,
  'todaySettlement': instance.todaySettlement,
  'activeTerminals': instance.activeTerminals,
  'instantTerminals': instance.instantTerminals,
};

_TodaySettlement _$TodaySettlementFromJson(Map<String, dynamic> json) =>
    _TodaySettlement(
      amount: json['amount'] as num?,
      status: json['status'] as String?,
      expectedDate: json['expectedDate'] as String?,
    );

Map<String, dynamic> _$TodaySettlementToJson(_TodaySettlement instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'status': instance.status,
      'expectedDate': instance.expectedDate,
    };

_PeriodTotals _$PeriodTotalsFromJson(Map<String, dynamic> json) =>
    _PeriodTotals(
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      totalSales: json['totalSales'] as num?,
      totalTransactionCount: (json['totalTransactionCount'] as num?)?.toInt(),
      totalFees: json['totalFees'] as num?,
      netAmount: json['netAmount'] as num?,
    );

Map<String, dynamic> _$PeriodTotalsToJson(_PeriodTotals instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'totalSales': instance.totalSales,
      'totalTransactionCount': instance.totalTransactionCount,
      'totalFees': instance.totalFees,
      'netAmount': instance.netAmount,
    };

_ChannelSummary _$ChannelSummaryFromJson(Map<String, dynamic> json) =>
    _ChannelSummary(
      channel: json['channel'] as String?,
      totalAmount: json['totalAmount'] as num?,
      transactionCount: (json['transactionCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChannelSummaryToJson(_ChannelSummary instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'totalAmount': instance.totalAmount,
      'transactionCount': instance.transactionCount,
    };

_CountAmount _$CountAmountFromJson(Map<String, dynamic> json) => _CountAmount(
  count: (json['count'] as num?)?.toInt(),
  amount: json['amount'] as num?,
);

Map<String, dynamic> _$CountAmountToJson(_CountAmount instance) =>
    <String, dynamic>{'count': instance.count, 'amount': instance.amount};

_CardSchemeSummary _$CardSchemeSummaryFromJson(Map<String, dynamic> json) =>
    _CardSchemeSummary(
      cardScheme: json['cardScheme'] as String?,
      transactionCount: (json['transactionCount'] as num?)?.toInt(),
      totalAmount: json['totalAmount'] as num?,
      totalFees: json['totalFees'] as num?,
      netAmount: json['netAmount'] as num?,
    );

Map<String, dynamic> _$CardSchemeSummaryToJson(_CardSchemeSummary instance) =>
    <String, dynamic>{
      'cardScheme': instance.cardScheme,
      'transactionCount': instance.transactionCount,
      'totalAmount': instance.totalAmount,
      'totalFees': instance.totalFees,
      'netAmount': instance.netAmount,
    };

_DailyBreakdown _$DailyBreakdownFromJson(Map<String, dynamic> json) =>
    _DailyBreakdown(
      date: json['date'] as String?,
      transactionCount: (json['transactionCount'] as num?)?.toInt(),
      totalAmount: json['totalAmount'] as num?,
      totalFees: json['totalFees'] as num?,
      netAmount: json['netAmount'] as num?,
    );

Map<String, dynamic> _$DailyBreakdownToJson(_DailyBreakdown instance) =>
    <String, dynamic>{
      'date': instance.date,
      'transactionCount': instance.transactionCount,
      'totalAmount': instance.totalAmount,
      'totalFees': instance.totalFees,
      'netAmount': instance.netAmount,
    };

_MerchantSalesReportResponse _$MerchantSalesReportResponseFromJson(
  Map<String, dynamic> json,
) => _MerchantSalesReportResponse(
  mid: json['mid'] as String?,
  merchantName: json['merchantName'] as String?,
  businessName: json['businessName'] as String?,
  merchantAddress: json['merchantAddress'] as String?,
  merchantPhone: json['merchantPhone'] as String?,
  merchantEmail: json['merchantEmail'] as String?,
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  reportPeriod: json['reportPeriod'] as String?,
  totalSales: json['totalSales'] as num?,
  totalTransactionCount: (json['totalTransactionCount'] as num?)?.toInt(),
  totalFees: json['totalFees'] as num?,
  netAmount: json['netAmount'] as num?,
  cardSchemeBreakdown:
      (json['cardSchemeBreakdown'] as List<dynamic>?)
          ?.map((e) => CardSchemeSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CardSchemeSummary>[],
  dailyBreakdown:
      (json['dailyBreakdown'] as List<dynamic>?)
          ?.map((e) => DailyBreakdown.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DailyBreakdown>[],
  previousPeriod: json['previousPeriod'] == null
      ? null
      : PeriodTotals.fromJson(json['previousPeriod'] as Map<String, dynamic>),
  channelBreakdown:
      (json['channelBreakdown'] as List<dynamic>?)
          ?.map((e) => ChannelSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChannelSummary>[],
  refunds: json['refunds'] == null
      ? null
      : CountAmount.fromJson(json['refunds'] as Map<String, dynamic>),
  chargebacks: json['chargebacks'] == null
      ? null
      : CountAmount.fromJson(json['chargebacks'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MerchantSalesReportResponseToJson(
  _MerchantSalesReportResponse instance,
) => <String, dynamic>{
  'mid': instance.mid,
  'merchantName': instance.merchantName,
  'businessName': instance.businessName,
  'merchantAddress': instance.merchantAddress,
  'merchantPhone': instance.merchantPhone,
  'merchantEmail': instance.merchantEmail,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'reportPeriod': instance.reportPeriod,
  'totalSales': instance.totalSales,
  'totalTransactionCount': instance.totalTransactionCount,
  'totalFees': instance.totalFees,
  'netAmount': instance.netAmount,
  'cardSchemeBreakdown': instance.cardSchemeBreakdown,
  'dailyBreakdown': instance.dailyBreakdown,
  'previousPeriod': instance.previousPeriod,
  'channelBreakdown': instance.channelBreakdown,
  'refunds': instance.refunds,
  'chargebacks': instance.chargebacks,
};

_SettlementResponse _$SettlementResponseFromJson(Map<String, dynamic> json) =>
    _SettlementResponse(
      id: json['id'] as String?,
      settlementReference: json['settlementReference'] as String?,
      batchReference: json['batchReference'] as String?,
      mid: json['mid'] as String?,
      merchantName: json['merchantName'] as String?,
      settlementDate: json['settlementDate'] as String?,
      transactionCount: (json['transactionCount'] as num?)?.toInt(),
      totalTransactionAmount: json['totalTransactionAmount'] as num?,
      totalTransactionFees: json['totalTransactionFees'] as num?,
      grossAmount: json['grossAmount'] as num?,
      settlementFee: json['settlementFee'] as num?,
      netAmount: json['netAmount'] as num?,
      accountNumber: json['accountNumber'] as String?,
      accountName: json['accountName'] as String?,
      bankName: json['bankName'] as String?,
      status: json['status'] as String?,
      settledAt: json['settledAt'] as String?,
      failureReason: json['failureReason'] as String?,
      cycle: json['cycle'] as String?,
    );

Map<String, dynamic> _$SettlementResponseToJson(_SettlementResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'settlementReference': instance.settlementReference,
      'batchReference': instance.batchReference,
      'mid': instance.mid,
      'merchantName': instance.merchantName,
      'settlementDate': instance.settlementDate,
      'transactionCount': instance.transactionCount,
      'totalTransactionAmount': instance.totalTransactionAmount,
      'totalTransactionFees': instance.totalTransactionFees,
      'grossAmount': instance.grossAmount,
      'settlementFee': instance.settlementFee,
      'netAmount': instance.netAmount,
      'accountNumber': instance.accountNumber,
      'accountName': instance.accountName,
      'bankName': instance.bankName,
      'status': instance.status,
      'settledAt': instance.settledAt,
      'failureReason': instance.failureReason,
      'cycle': instance.cycle,
    };

_PageSettlementResponse _$PageSettlementResponseFromJson(
  Map<String, dynamic> json,
) => _PageSettlementResponse(
  content:
      (json['content'] as List<dynamic>?)
          ?.map((e) => SettlementResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SettlementResponse>[],
  totalElements: (json['totalElements'] as num?)?.toInt(),
  totalPages: (json['totalPages'] as num?)?.toInt(),
  number: (json['number'] as num?)?.toInt(),
  size: (json['size'] as num?)?.toInt(),
  first: json['first'] as bool?,
  last: json['last'] as bool?,
);

Map<String, dynamic> _$PageSettlementResponseToJson(
  _PageSettlementResponse instance,
) => <String, dynamic>{
  'content': instance.content,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'number': instance.number,
  'size': instance.size,
  'first': instance.first,
  'last': instance.last,
};
