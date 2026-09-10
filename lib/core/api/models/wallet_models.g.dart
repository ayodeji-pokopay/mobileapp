// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletResponse _$WalletResponseFromJson(Map<String, dynamic> json) =>
    _WalletResponse(
      id: json['id'] as String?,
      walletId: json['walletId'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountName: json['accountName'] as String?,
      bankCode: json['bankCode'] as String?,
      bankName: json['bankName'] as String?,
      status: json['status'] as String?,
      settlementType: json['settlementType'] as String?,
      autoSettlement: json['autoSettlement'] as bool?,
      availableBalance: json['availableBalance'] as num?,
      ledgerBalance: json['ledgerBalance'] as num?,
      pendingSettlement: json['pendingSettlement'] as num?,
      frozen: json['frozen'] as bool?,
      merchantMid: json['merchantMid'] as String?,
      merchantName: json['merchantName'] as String?,
      currency: json['currency'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$WalletResponseToJson(_WalletResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'walletId': instance.walletId,
      'accountNumber': instance.accountNumber,
      'accountName': instance.accountName,
      'bankCode': instance.bankCode,
      'bankName': instance.bankName,
      'status': instance.status,
      'settlementType': instance.settlementType,
      'autoSettlement': instance.autoSettlement,
      'availableBalance': instance.availableBalance,
      'ledgerBalance': instance.ledgerBalance,
      'pendingSettlement': instance.pendingSettlement,
      'frozen': instance.frozen,
      'merchantMid': instance.merchantMid,
      'merchantName': instance.merchantName,
      'currency': instance.currency,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
