// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    _TransactionResponse(
      reference: json['reference'] as String?,
      rrn: json['rrn'] as String?,
      stan: json['stan'] as String?,
      authCode: json['authCode'] as String?,
      mid: json['mid'] as String?,
      tid: json['tid'] as String?,
      storeName: json['storeName'] as String?,
      terminalSerial: json['terminalSerial'] as String?,
      merchantAddress: json['merchantAddress'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      responseCode: json['responseCode'] as String?,
      amount: json['amount'] as num?,
      fee: json['fee'] as num?,
      netAmount: json['netAmount'] as num?,
      currency: json['currency'] as String?,
      cardScheme: json['cardScheme'] as String?,
      cardType: json['cardType'] as String?,
      maskedPan: json['maskedPan'] as String?,
      channel: json['channel'] as String?,
      transactionDate: json['transactionDate'] as String?,
      settlementReference: json['settlementReference'] as String?,
      settlementStatus: json['settlementStatus'] as String?,
      originalReference: json['originalReference'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
    );

Map<String, dynamic> _$TransactionResponseToJson(
  _TransactionResponse instance,
) => <String, dynamic>{
  'reference': instance.reference,
  'rrn': instance.rrn,
  'stan': instance.stan,
  'authCode': instance.authCode,
  'mid': instance.mid,
  'tid': instance.tid,
  'storeName': instance.storeName,
  'terminalSerial': instance.terminalSerial,
  'merchantAddress': instance.merchantAddress,
  'type': instance.type,
  'status': instance.status,
  'responseCode': instance.responseCode,
  'amount': instance.amount,
  'fee': instance.fee,
  'netAmount': instance.netAmount,
  'currency': instance.currency,
  'cardScheme': instance.cardScheme,
  'cardType': instance.cardType,
  'maskedPan': instance.maskedPan,
  'channel': instance.channel,
  'transactionDate': instance.transactionDate,
  'settlementReference': instance.settlementReference,
  'settlementStatus': instance.settlementStatus,
  'originalReference': instance.originalReference,
  'receiptUrl': instance.receiptUrl,
};

_PageTransactionResponse _$PageTransactionResponseFromJson(
  Map<String, dynamic> json,
) => _PageTransactionResponse(
  content:
      (json['content'] as List<dynamic>?)
          ?.map((e) => TransactionResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TransactionResponse>[],
  totalElements: (json['totalElements'] as num?)?.toInt(),
  totalPages: (json['totalPages'] as num?)?.toInt(),
  number: (json['number'] as num?)?.toInt(),
  size: (json['size'] as num?)?.toInt(),
  first: json['first'] as bool?,
  last: json['last'] as bool?,
);

Map<String, dynamic> _$PageTransactionResponseToJson(
  _PageTransactionResponse instance,
) => <String, dynamic>{
  'content': instance.content,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'number': instance.number,
  'size': instance.size,
  'first': instance.first,
  'last': instance.last,
};
