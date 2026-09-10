// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    _TransactionResponse(
      id: json['id'] as String?,
      transactionRef: json['transactionRef'] as String?,
      tid: json['tid'] as String?,
      mid: json['mid'] as String?,
      merchantEmail: json['merchantEmail'] as String?,
      storeName: json['storeName'] as String?,
      transactionType: json['transactionType'] as String?,
      panMasked: json['panMasked'] as String?,
      cardScheme: json['cardScheme'] as String?,
      cardBank: json['cardBank'] as String?,
      cardBrand: json['cardBrand'] as String?,
      cardType: json['cardType'] as String?,
      cardCountryCode: json['cardCountryCode'] as String?,
      amount: json['amount'] as num?,
      feeAmount: json['feeAmount'] as num?,
      currencyCode: json['currencyCode'] as String?,
      status: json['status'] as String?,
      responseCode: json['responseCode'] as String?,
      responseCodeDescription: json['responseCodeDescription'] as String?,
      authCode: json['authCode'] as String?,
      processorHost: json['processorHost'] as String?,
      durationMs: (json['durationMs'] as num?)?.toInt(),
      errorMessage: json['errorMessage'] as String?,
      initiatedAt: json['initiatedAt'] as String?,
      completedAt: json['completedAt'] as String?,
      settlementReference: json['settlementReference'] as String?,
      settlementStatus: json['settlementStatus'] as String?,
      originalReference: json['originalReference'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
    );

Map<String, dynamic> _$TransactionResponseToJson(
  _TransactionResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'transactionRef': instance.transactionRef,
  'tid': instance.tid,
  'mid': instance.mid,
  'merchantEmail': instance.merchantEmail,
  'storeName': instance.storeName,
  'transactionType': instance.transactionType,
  'panMasked': instance.panMasked,
  'cardScheme': instance.cardScheme,
  'cardBank': instance.cardBank,
  'cardBrand': instance.cardBrand,
  'cardType': instance.cardType,
  'cardCountryCode': instance.cardCountryCode,
  'amount': instance.amount,
  'feeAmount': instance.feeAmount,
  'currencyCode': instance.currencyCode,
  'status': instance.status,
  'responseCode': instance.responseCode,
  'responseCodeDescription': instance.responseCodeDescription,
  'authCode': instance.authCode,
  'processorHost': instance.processorHost,
  'durationMs': instance.durationMs,
  'errorMessage': instance.errorMessage,
  'initiatedAt': instance.initiatedAt,
  'completedAt': instance.completedAt,
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
