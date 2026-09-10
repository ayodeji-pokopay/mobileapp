import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_models.freezed.dart';
part 'wallet_models.g.dart';

@freezed
abstract class WalletResponse with _$WalletResponse {
  const factory WalletResponse({
    String? walletId,
    String? mid,
    String? currency,
    num? availableBalance,
    num? pendingBalance,
    String? status,
    SettlementAccount? settlementAccount,
    SettlementConfig? settlementConfig,
    String? updatedAt,
  }) = _WalletResponse;

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);
}

@freezed
abstract class SettlementAccount with _$SettlementAccount {
  const factory SettlementAccount({
    String? bankName,
    String? accountName,
    String? accountNumberMasked,
    String? accountNumber,
  }) = _SettlementAccount;

  factory SettlementAccount.fromJson(Map<String, dynamic> json) =>
      _$SettlementAccountFromJson(json);
}

@freezed
abstract class SettlementConfig with _$SettlementConfig {
  const factory SettlementConfig({
    String? cycle,
    bool? instantEnabled,
    num? minimumAmount,
    String? nextSettlementDate,
    num? nextSettlementAmount,
  }) = _SettlementConfig;

  factory SettlementConfig.fromJson(Map<String, dynamic> json) =>
      _$SettlementConfigFromJson(json);
}
