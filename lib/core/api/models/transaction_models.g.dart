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
      amount: const LenientNum().fromJson(json['amount']),
      feeAmount: const LenientNum().fromJson(json['feeAmount']),
      currencyCode: json['currencyCode'] as String?,
      status: json['status'] as String?,
      responseCode: json['responseCode'] as String?,
      responseCodeDescription: json['responseCodeDescription'] as String?,
      authCode: json['authCode'] as String?,
      processorHost: json['processorHost'] as String?,
      durationMs: const LenientInt().fromJson(json['durationMs']),
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
  'amount': const LenientNum().toJson(instance.amount),
  'feeAmount': const LenientNum().toJson(instance.feeAmount),
  'currencyCode': instance.currencyCode,
  'status': instance.status,
  'responseCode': instance.responseCode,
  'responseCodeDescription': instance.responseCodeDescription,
  'authCode': instance.authCode,
  'processorHost': instance.processorHost,
  'durationMs': const LenientInt().toJson(instance.durationMs),
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
  totalElements: const LenientInt().fromJson(json['totalElements']),
  totalPages: const LenientInt().fromJson(json['totalPages']),
  number: const LenientInt().fromJson(json['number']),
  size: const LenientInt().fromJson(json['size']),
  first: const LenientBool().fromJson(json['first']),
  last: const LenientBool().fromJson(json['last']),
);

Map<String, dynamic> _$PageTransactionResponseToJson(
  _PageTransactionResponse instance,
) => <String, dynamic>{
  'content': instance.content,
  'totalElements': const LenientInt().toJson(instance.totalElements),
  'totalPages': const LenientInt().toJson(instance.totalPages),
  'number': const LenientInt().toJson(instance.number),
  'size': const LenientInt().toJson(instance.size),
  'first': const LenientBool().toJson(instance.first),
  'last': const LenientBool().toJson(instance.last),
};
