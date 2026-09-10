// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletResponse {

 String? get id; String? get walletId; String? get accountNumber; String? get accountName; String? get bankCode; String? get bankName; String? get status; String? get settlementType; bool? get autoSettlement; num? get availableBalance; num? get ledgerBalance; num? get pendingSettlement; bool? get frozen; String? get merchantMid; String? get merchantName; String? get currency; String? get createdAt; String? get updatedAt;
/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletResponseCopyWith<WalletResponse> get copyWith => _$WalletResponseCopyWithImpl<WalletResponse>(this as WalletResponse, _$identity);

  /// Serializes this WalletResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.bankCode, bankCode) || other.bankCode == bankCode)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.status, status) || other.status == status)&&(identical(other.settlementType, settlementType) || other.settlementType == settlementType)&&(identical(other.autoSettlement, autoSettlement) || other.autoSettlement == autoSettlement)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.ledgerBalance, ledgerBalance) || other.ledgerBalance == ledgerBalance)&&(identical(other.pendingSettlement, pendingSettlement) || other.pendingSettlement == pendingSettlement)&&(identical(other.frozen, frozen) || other.frozen == frozen)&&(identical(other.merchantMid, merchantMid) || other.merchantMid == merchantMid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,walletId,accountNumber,accountName,bankCode,bankName,status,settlementType,autoSettlement,availableBalance,ledgerBalance,pendingSettlement,frozen,merchantMid,merchantName,currency,createdAt,updatedAt);

@override
String toString() {
  return 'WalletResponse(id: $id, walletId: $walletId, accountNumber: $accountNumber, accountName: $accountName, bankCode: $bankCode, bankName: $bankName, status: $status, settlementType: $settlementType, autoSettlement: $autoSettlement, availableBalance: $availableBalance, ledgerBalance: $ledgerBalance, pendingSettlement: $pendingSettlement, frozen: $frozen, merchantMid: $merchantMid, merchantName: $merchantName, currency: $currency, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $WalletResponseCopyWith<$Res>  {
  factory $WalletResponseCopyWith(WalletResponse value, $Res Function(WalletResponse) _then) = _$WalletResponseCopyWithImpl;
@useResult
$Res call({
 String? id, String? walletId, String? accountNumber, String? accountName, String? bankCode, String? bankName, String? status, String? settlementType, bool? autoSettlement, num? availableBalance, num? ledgerBalance, num? pendingSettlement, bool? frozen, String? merchantMid, String? merchantName, String? currency, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$WalletResponseCopyWithImpl<$Res>
    implements $WalletResponseCopyWith<$Res> {
  _$WalletResponseCopyWithImpl(this._self, this._then);

  final WalletResponse _self;
  final $Res Function(WalletResponse) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? walletId = freezed,Object? accountNumber = freezed,Object? accountName = freezed,Object? bankCode = freezed,Object? bankName = freezed,Object? status = freezed,Object? settlementType = freezed,Object? autoSettlement = freezed,Object? availableBalance = freezed,Object? ledgerBalance = freezed,Object? pendingSettlement = freezed,Object? frozen = freezed,Object? merchantMid = freezed,Object? merchantName = freezed,Object? currency = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,bankCode: freezed == bankCode ? _self.bankCode : bankCode // ignore: cast_nullable_to_non_nullable
as String?,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,settlementType: freezed == settlementType ? _self.settlementType : settlementType // ignore: cast_nullable_to_non_nullable
as String?,autoSettlement: freezed == autoSettlement ? _self.autoSettlement : autoSettlement // ignore: cast_nullable_to_non_nullable
as bool?,availableBalance: freezed == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as num?,ledgerBalance: freezed == ledgerBalance ? _self.ledgerBalance : ledgerBalance // ignore: cast_nullable_to_non_nullable
as num?,pendingSettlement: freezed == pendingSettlement ? _self.pendingSettlement : pendingSettlement // ignore: cast_nullable_to_non_nullable
as num?,frozen: freezed == frozen ? _self.frozen : frozen // ignore: cast_nullable_to_non_nullable
as bool?,merchantMid: freezed == merchantMid ? _self.merchantMid : merchantMid // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletResponse].
extension WalletResponsePatterns on WalletResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletResponse value)  $default,){
final _that = this;
switch (_that) {
case _WalletResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? walletId,  String? accountNumber,  String? accountName,  String? bankCode,  String? bankName,  String? status,  String? settlementType,  bool? autoSettlement,  num? availableBalance,  num? ledgerBalance,  num? pendingSettlement,  bool? frozen,  String? merchantMid,  String? merchantName,  String? currency,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
return $default(_that.id,_that.walletId,_that.accountNumber,_that.accountName,_that.bankCode,_that.bankName,_that.status,_that.settlementType,_that.autoSettlement,_that.availableBalance,_that.ledgerBalance,_that.pendingSettlement,_that.frozen,_that.merchantMid,_that.merchantName,_that.currency,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? walletId,  String? accountNumber,  String? accountName,  String? bankCode,  String? bankName,  String? status,  String? settlementType,  bool? autoSettlement,  num? availableBalance,  num? ledgerBalance,  num? pendingSettlement,  bool? frozen,  String? merchantMid,  String? merchantName,  String? currency,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _WalletResponse():
return $default(_that.id,_that.walletId,_that.accountNumber,_that.accountName,_that.bankCode,_that.bankName,_that.status,_that.settlementType,_that.autoSettlement,_that.availableBalance,_that.ledgerBalance,_that.pendingSettlement,_that.frozen,_that.merchantMid,_that.merchantName,_that.currency,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? walletId,  String? accountNumber,  String? accountName,  String? bankCode,  String? bankName,  String? status,  String? settlementType,  bool? autoSettlement,  num? availableBalance,  num? ledgerBalance,  num? pendingSettlement,  bool? frozen,  String? merchantMid,  String? merchantName,  String? currency,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
return $default(_that.id,_that.walletId,_that.accountNumber,_that.accountName,_that.bankCode,_that.bankName,_that.status,_that.settlementType,_that.autoSettlement,_that.availableBalance,_that.ledgerBalance,_that.pendingSettlement,_that.frozen,_that.merchantMid,_that.merchantName,_that.currency,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletResponse extends WalletResponse {
  const _WalletResponse({this.id, this.walletId, this.accountNumber, this.accountName, this.bankCode, this.bankName, this.status, this.settlementType, this.autoSettlement, this.availableBalance, this.ledgerBalance, this.pendingSettlement, this.frozen, this.merchantMid, this.merchantName, this.currency, this.createdAt, this.updatedAt}): super._();
  factory _WalletResponse.fromJson(Map<String, dynamic> json) => _$WalletResponseFromJson(json);

@override final  String? id;
@override final  String? walletId;
@override final  String? accountNumber;
@override final  String? accountName;
@override final  String? bankCode;
@override final  String? bankName;
@override final  String? status;
@override final  String? settlementType;
@override final  bool? autoSettlement;
@override final  num? availableBalance;
@override final  num? ledgerBalance;
@override final  num? pendingSettlement;
@override final  bool? frozen;
@override final  String? merchantMid;
@override final  String? merchantName;
@override final  String? currency;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletResponseCopyWith<_WalletResponse> get copyWith => __$WalletResponseCopyWithImpl<_WalletResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.bankCode, bankCode) || other.bankCode == bankCode)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.status, status) || other.status == status)&&(identical(other.settlementType, settlementType) || other.settlementType == settlementType)&&(identical(other.autoSettlement, autoSettlement) || other.autoSettlement == autoSettlement)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.ledgerBalance, ledgerBalance) || other.ledgerBalance == ledgerBalance)&&(identical(other.pendingSettlement, pendingSettlement) || other.pendingSettlement == pendingSettlement)&&(identical(other.frozen, frozen) || other.frozen == frozen)&&(identical(other.merchantMid, merchantMid) || other.merchantMid == merchantMid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,walletId,accountNumber,accountName,bankCode,bankName,status,settlementType,autoSettlement,availableBalance,ledgerBalance,pendingSettlement,frozen,merchantMid,merchantName,currency,createdAt,updatedAt);

@override
String toString() {
  return 'WalletResponse(id: $id, walletId: $walletId, accountNumber: $accountNumber, accountName: $accountName, bankCode: $bankCode, bankName: $bankName, status: $status, settlementType: $settlementType, autoSettlement: $autoSettlement, availableBalance: $availableBalance, ledgerBalance: $ledgerBalance, pendingSettlement: $pendingSettlement, frozen: $frozen, merchantMid: $merchantMid, merchantName: $merchantName, currency: $currency, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WalletResponseCopyWith<$Res> implements $WalletResponseCopyWith<$Res> {
  factory _$WalletResponseCopyWith(_WalletResponse value, $Res Function(_WalletResponse) _then) = __$WalletResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? walletId, String? accountNumber, String? accountName, String? bankCode, String? bankName, String? status, String? settlementType, bool? autoSettlement, num? availableBalance, num? ledgerBalance, num? pendingSettlement, bool? frozen, String? merchantMid, String? merchantName, String? currency, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$WalletResponseCopyWithImpl<$Res>
    implements _$WalletResponseCopyWith<$Res> {
  __$WalletResponseCopyWithImpl(this._self, this._then);

  final _WalletResponse _self;
  final $Res Function(_WalletResponse) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? walletId = freezed,Object? accountNumber = freezed,Object? accountName = freezed,Object? bankCode = freezed,Object? bankName = freezed,Object? status = freezed,Object? settlementType = freezed,Object? autoSettlement = freezed,Object? availableBalance = freezed,Object? ledgerBalance = freezed,Object? pendingSettlement = freezed,Object? frozen = freezed,Object? merchantMid = freezed,Object? merchantName = freezed,Object? currency = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_WalletResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,bankCode: freezed == bankCode ? _self.bankCode : bankCode // ignore: cast_nullable_to_non_nullable
as String?,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,settlementType: freezed == settlementType ? _self.settlementType : settlementType // ignore: cast_nullable_to_non_nullable
as String?,autoSettlement: freezed == autoSettlement ? _self.autoSettlement : autoSettlement // ignore: cast_nullable_to_non_nullable
as bool?,availableBalance: freezed == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as num?,ledgerBalance: freezed == ledgerBalance ? _self.ledgerBalance : ledgerBalance // ignore: cast_nullable_to_non_nullable
as num?,pendingSettlement: freezed == pendingSettlement ? _self.pendingSettlement : pendingSettlement // ignore: cast_nullable_to_non_nullable
as num?,frozen: freezed == frozen ? _self.frozen : frozen // ignore: cast_nullable_to_non_nullable
as bool?,merchantMid: freezed == merchantMid ? _self.merchantMid : merchantMid // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
