import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_models.freezed.dart';
part 'wallet_models.g.dart';

/// `GET /wallets/mid/{mid}` as the backend actually returns it: a flat
/// object with balances in **kobo** (minor units), unlike every other
/// endpoint which uses naira. Use [availableNaira] / [pendingNaira].
@freezed
abstract class WalletResponse with _$WalletResponse {
  const WalletResponse._();

  const factory WalletResponse({
    String? id,
    String? walletId,
    String? accountNumber,
    String? accountName,
    String? bankCode,
    String? bankName,
    String? status,
    String? settlementType,
    bool? autoSettlement,
    num? availableBalance,
    num? ledgerBalance,
    num? pendingSettlement,
    bool? frozen,
    String? merchantMid,
    String? merchantName,
    String? currency,
    String? createdAt,
    String? updatedAt,
  }) = _WalletResponse;

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);

  /// Wallet balances arrive in minor units (kobo). Flip this off once the
  /// backend aligns the wallet endpoint with the naira convention.
  static const balancesInMinorUnits = true;

  static num? _toNaira(num? v) =>
      v == null ? null : (balancesInMinorUnits ? v / 100 : v);

  num? get availableNaira => _toNaira(availableBalance);
  num? get ledgerNaira => _toNaira(ledgerBalance);
  num? get pendingNaira => _toNaira(pendingSettlement);
  bool get isFrozen =>
      frozen == true || (status ?? '').toUpperCase() == 'FROZEN';

  /// "T_PLUS_0" → "T0", "T_PLUS_1" → "T1", passthrough otherwise.
  String? get cycle {
    final t = settlementType?.toUpperCase();
    if (t == null) return null;
    final m = RegExp(r'^T_?PLUS_?(\d)$').firstMatch(t);
    return m == null ? t : 'T${m.group(1)}';
  }
}
