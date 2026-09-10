// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletResponse _$WalletResponseFromJson(Map<String, dynamic> json) =>
    _WalletResponse(
      walletId: json['walletId'] as String?,
      mid: json['mid'] as String?,
      currency: json['currency'] as String?,
      availableBalance: json['availableBalance'] as num?,
      pendingBalance: json['pendingBalance'] as num?,
      status: json['status'] as String?,
      settlementAccount: json['settlementAccount'] == null
          ? null
          : SettlementAccount.fromJson(
              json['settlementAccount'] as Map<String, dynamic>,
            ),
      settlementConfig: json['settlementConfig'] == null
          ? null
          : SettlementConfig.fromJson(
              json['settlementConfig'] as Map<String, dynamic>,
            ),
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$WalletResponseToJson(_WalletResponse instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'mid': instance.mid,
      'currency': instance.currency,
      'availableBalance': instance.availableBalance,
      'pendingBalance': instance.pendingBalance,
      'status': instance.status,
      'settlementAccount': instance.settlementAccount,
      'settlementConfig': instance.settlementConfig,
      'updatedAt': instance.updatedAt,
    };

_SettlementAccount _$SettlementAccountFromJson(Map<String, dynamic> json) =>
    _SettlementAccount(
      bankName: json['bankName'] as String?,
      accountName: json['accountName'] as String?,
      accountNumberMasked: json['accountNumberMasked'] as String?,
      accountNumber: json['accountNumber'] as String?,
    );

Map<String, dynamic> _$SettlementAccountToJson(_SettlementAccount instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'accountName': instance.accountName,
      'accountNumberMasked': instance.accountNumberMasked,
      'accountNumber': instance.accountNumber,
    };

_SettlementConfig _$SettlementConfigFromJson(Map<String, dynamic> json) =>
    _SettlementConfig(
      cycle: json['cycle'] as String?,
      instantEnabled: json['instantEnabled'] as bool?,
      minimumAmount: json['minimumAmount'] as num?,
      nextSettlementDate: json['nextSettlementDate'] as String?,
      nextSettlementAmount: json['nextSettlementAmount'] as num?,
    );

Map<String, dynamic> _$SettlementConfigToJson(_SettlementConfig instance) =>
    <String, dynamic>{
      'cycle': instance.cycle,
      'instantEnabled': instance.instantEnabled,
      'minimumAmount': instance.minimumAmount,
      'nextSettlementDate': instance.nextSettlementDate,
      'nextSettlementAmount': instance.nextSettlementAmount,
    };
