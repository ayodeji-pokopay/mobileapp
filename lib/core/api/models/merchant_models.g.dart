// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MerchantSettlementSummary _$MerchantSettlementSummaryFromJson(
  Map<String, dynamic> json,
) => _MerchantSettlementSummary(
  mid: json['mid'] as String?,
  totalSettlements: const LenientInt().fromJson(json['totalSettlements']),
  totalSettledAmount: const LenientNum().fromJson(json['totalSettledAmount']),
  pendingAmount: const LenientNum().fromJson(json['pendingAmount']),
  todayTransactions: const LenientInt().fromJson(json['todayTransactions']),
  todaySales: const LenientNum().fromJson(json['todaySales']),
  yesterdaySales: const LenientNum().fromJson(json['yesterdaySales']),
  yesterdayTransactions: const LenientInt().fromJson(
    json['yesterdayTransactions'],
  ),
  sameWeekdayLastWeekSales: const LenientNum().fromJson(
    json['sameWeekdayLastWeekSales'],
  ),
  monthToDateSales: const LenientNum().fromJson(json['monthToDateSales']),
  todaySettlement: json['todaySettlement'] == null
      ? null
      : TodaySettlement.fromJson(
          json['todaySettlement'] as Map<String, dynamic>,
        ),
  activeTerminals: const LenientInt().fromJson(json['activeTerminals']),
  instantTerminals: const LenientInt().fromJson(json['instantTerminals']),
);

Map<String, dynamic> _$MerchantSettlementSummaryToJson(
  _MerchantSettlementSummary instance,
) => <String, dynamic>{
  'mid': instance.mid,
  'totalSettlements': const LenientInt().toJson(instance.totalSettlements),
  'totalSettledAmount': const LenientNum().toJson(instance.totalSettledAmount),
  'pendingAmount': const LenientNum().toJson(instance.pendingAmount),
  'todayTransactions': const LenientInt().toJson(instance.todayTransactions),
  'todaySales': const LenientNum().toJson(instance.todaySales),
  'yesterdaySales': const LenientNum().toJson(instance.yesterdaySales),
  'yesterdayTransactions': const LenientInt().toJson(
    instance.yesterdayTransactions,
  ),
  'sameWeekdayLastWeekSales': const LenientNum().toJson(
    instance.sameWeekdayLastWeekSales,
  ),
  'monthToDateSales': const LenientNum().toJson(instance.monthToDateSales),
  'todaySettlement': instance.todaySettlement,
  'activeTerminals': const LenientInt().toJson(instance.activeTerminals),
  'instantTerminals': const LenientInt().toJson(instance.instantTerminals),
};

_TodaySettlement _$TodaySettlementFromJson(Map<String, dynamic> json) =>
    _TodaySettlement(
      amount: const LenientNum().fromJson(json['amount']),
      status: json['status'] as String?,
      expectedDate: json['expectedDate'] as String?,
      settledAt: json['settledAt'] as String?,
      failureReason: json['failureReason'] as String?,
    );

Map<String, dynamic> _$TodaySettlementToJson(_TodaySettlement instance) =>
    <String, dynamic>{
      'amount': const LenientNum().toJson(instance.amount),
      'status': instance.status,
      'expectedDate': instance.expectedDate,
      'settledAt': instance.settledAt,
      'failureReason': instance.failureReason,
    };

_PeriodTotals _$PeriodTotalsFromJson(Map<String, dynamic> json) =>
    _PeriodTotals(
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      totalSales: const LenientNum().fromJson(json['totalSales']),
      totalTransactionCount: const LenientInt().fromJson(
        json['totalTransactionCount'],
      ),
      totalFees: const LenientNum().fromJson(json['totalFees']),
      netAmount: const LenientNum().fromJson(json['netAmount']),
    );

Map<String, dynamic> _$PeriodTotalsToJson(_PeriodTotals instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'totalSales': const LenientNum().toJson(instance.totalSales),
      'totalTransactionCount': const LenientInt().toJson(
        instance.totalTransactionCount,
      ),
      'totalFees': const LenientNum().toJson(instance.totalFees),
      'netAmount': const LenientNum().toJson(instance.netAmount),
    };

_ChannelSummary _$ChannelSummaryFromJson(Map<String, dynamic> json) =>
    _ChannelSummary(
      channel: json['channel'] as String?,
      totalAmount: const LenientNum().fromJson(json['totalAmount']),
      transactionCount: const LenientInt().fromJson(json['transactionCount']),
    );

Map<String, dynamic> _$ChannelSummaryToJson(_ChannelSummary instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'totalAmount': const LenientNum().toJson(instance.totalAmount),
      'transactionCount': const LenientInt().toJson(instance.transactionCount),
    };

_TerminalSummary _$TerminalSummaryFromJson(Map<String, dynamic> json) =>
    _TerminalSummary(
      tid: json['tid'] as String?,
      terminalLocation: json['terminalLocation'] as String?,
      totalSales: const LenientNum().fromJson(json['totalSales']),
      transactionCount: const LenientInt().fromJson(json['transactionCount']),
      fees: const LenientNum().fromJson(json['fees']),
    );

Map<String, dynamic> _$TerminalSummaryToJson(_TerminalSummary instance) =>
    <String, dynamic>{
      'tid': instance.tid,
      'terminalLocation': instance.terminalLocation,
      'totalSales': const LenientNum().toJson(instance.totalSales),
      'transactionCount': const LenientInt().toJson(instance.transactionCount),
      'fees': const LenientNum().toJson(instance.fees),
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
      transactionCount: const LenientInt().fromJson(json['transactionCount']),
      totalAmount: const LenientNum().fromJson(json['totalAmount']),
      totalSales: const LenientNum().fromJson(json['totalSales']),
      totalFees: const LenientNum().fromJson(json['totalFees']),
      fees: const LenientNum().fromJson(json['fees']),
      netAmount: const LenientNum().fromJson(json['netAmount']),
      averageTransactionValue: const LenientNum().fromJson(
        json['averageTransactionValue'],
      ),
    );

Map<String, dynamic> _$CardSchemeSummaryToJson(_CardSchemeSummary instance) =>
    <String, dynamic>{
      'cardScheme': instance.cardScheme,
      'transactionCount': const LenientInt().toJson(instance.transactionCount),
      'totalAmount': const LenientNum().toJson(instance.totalAmount),
      'totalSales': const LenientNum().toJson(instance.totalSales),
      'totalFees': const LenientNum().toJson(instance.totalFees),
      'fees': const LenientNum().toJson(instance.fees),
      'netAmount': const LenientNum().toJson(instance.netAmount),
      'averageTransactionValue': const LenientNum().toJson(
        instance.averageTransactionValue,
      ),
    };

_DailyBreakdown _$DailyBreakdownFromJson(Map<String, dynamic> json) =>
    _DailyBreakdown(
      date: json['date'] as String?,
      transactionCount: const LenientInt().fromJson(json['transactionCount']),
      totalAmount: const LenientNum().fromJson(json['totalAmount']),
      totalFees: const LenientNum().fromJson(json['totalFees']),
      netAmount: const LenientNum().fromJson(json['netAmount']),
    );

Map<String, dynamic> _$DailyBreakdownToJson(_DailyBreakdown instance) =>
    <String, dynamic>{
      'date': instance.date,
      'transactionCount': const LenientInt().toJson(instance.transactionCount),
      'totalAmount': const LenientNum().toJson(instance.totalAmount),
      'totalFees': const LenientNum().toJson(instance.totalFees),
      'netAmount': const LenientNum().toJson(instance.netAmount),
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
  totalSales: const LenientNum().fromJson(json['totalSales']),
  totalTransactionCount: const LenientInt().fromJson(
    json['totalTransactionCount'],
  ),
  totalFees: const LenientNum().fromJson(json['totalFees']),
  netAmount: const LenientNum().fromJson(json['netAmount']),
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
  terminalBreakdown:
      (json['terminalBreakdown'] as List<dynamic>?)
          ?.map((e) => TerminalSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TerminalSummary>[],
  refunds: json['refunds'] == null
      ? null
      : CountAmount.fromJson(json['refunds'] as Map<String, dynamic>),
  chargebacks: json['chargebacks'] == null
      ? null
      : CountAmount.fromJson(json['chargebacks'] as Map<String, dynamic>),
  totalSettled: const LenientNum().fromJson(json['totalSettled']),
  pendingSettlement: const LenientNum().fromJson(json['pendingSettlement']),
  settlementCount: const LenientInt().fromJson(json['settlementCount']),
  generatedAt: json['generatedAt'] as String?,
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
  'totalSales': const LenientNum().toJson(instance.totalSales),
  'totalTransactionCount': const LenientInt().toJson(
    instance.totalTransactionCount,
  ),
  'totalFees': const LenientNum().toJson(instance.totalFees),
  'netAmount': const LenientNum().toJson(instance.netAmount),
  'cardSchemeBreakdown': instance.cardSchemeBreakdown,
  'dailyBreakdown': instance.dailyBreakdown,
  'previousPeriod': instance.previousPeriod,
  'channelBreakdown': instance.channelBreakdown,
  'terminalBreakdown': instance.terminalBreakdown,
  'refunds': instance.refunds,
  'chargebacks': instance.chargebacks,
  'totalSettled': const LenientNum().toJson(instance.totalSettled),
  'pendingSettlement': const LenientNum().toJson(instance.pendingSettlement),
  'settlementCount': const LenientInt().toJson(instance.settlementCount),
  'generatedAt': instance.generatedAt,
};

_SettlementResponse _$SettlementResponseFromJson(Map<String, dynamic> json) =>
    _SettlementResponse(
      id: json['id'] as String?,
      settlementReference: json['settlementReference'] as String?,
      batchReference: json['batchReference'] as String?,
      mid: json['mid'] as String?,
      merchantName: json['merchantName'] as String?,
      settlementDate: json['settlementDate'] as String?,
      transactionCount: const LenientInt().fromJson(json['transactionCount']),
      totalTransactionAmount: const LenientNum().fromJson(
        json['totalTransactionAmount'],
      ),
      totalTransactionFees: const LenientNum().fromJson(
        json['totalTransactionFees'],
      ),
      grossAmount: const LenientNum().fromJson(json['grossAmount']),
      settlementFee: const LenientNum().fromJson(json['settlementFee']),
      netAmount: const LenientNum().fromJson(json['netAmount']),
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
      'transactionCount': const LenientInt().toJson(instance.transactionCount),
      'totalTransactionAmount': const LenientNum().toJson(
        instance.totalTransactionAmount,
      ),
      'totalTransactionFees': const LenientNum().toJson(
        instance.totalTransactionFees,
      ),
      'grossAmount': const LenientNum().toJson(instance.grossAmount),
      'settlementFee': const LenientNum().toJson(instance.settlementFee),
      'netAmount': const LenientNum().toJson(instance.netAmount),
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
  totalElements: const LenientInt().fromJson(json['totalElements']),
  totalPages: const LenientInt().fromJson(json['totalPages']),
  number: const LenientInt().fromJson(json['number']),
  size: const LenientInt().fromJson(json['size']),
  first: const LenientBool().fromJson(json['first']),
  last: const LenientBool().fromJson(json['last']),
);

Map<String, dynamic> _$PageSettlementResponseToJson(
  _PageSettlementResponse instance,
) => <String, dynamic>{
  'content': instance.content,
  'totalElements': const LenientInt().toJson(instance.totalElements),
  'totalPages': const LenientInt().toJson(instance.totalPages),
  'number': const LenientInt().toJson(instance.number),
  'size': const LenientInt().toJson(instance.size),
  'first': const LenientBool().toJson(instance.first),
  'last': const LenientBool().toJson(instance.last),
};
