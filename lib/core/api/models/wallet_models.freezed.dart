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

 String? get walletId; String? get mid; String? get currency; num? get availableBalance; num? get pendingBalance; String? get status; SettlementAccount? get settlementAccount; SettlementConfig? get settlementConfig; String? get updatedAt;
/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletResponseCopyWith<WalletResponse> get copyWith => _$WalletResponseCopyWithImpl<WalletResponse>(this as WalletResponse, _$identity);

  /// Serializes this WalletResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletResponse&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.pendingBalance, pendingBalance) || other.pendingBalance == pendingBalance)&&(identical(other.status, status) || other.status == status)&&(identical(other.settlementAccount, settlementAccount) || other.settlementAccount == settlementAccount)&&(identical(other.settlementConfig, settlementConfig) || other.settlementConfig == settlementConfig)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,walletId,mid,currency,availableBalance,pendingBalance,status,settlementAccount,settlementConfig,updatedAt);

@override
String toString() {
  return 'WalletResponse(walletId: $walletId, mid: $mid, currency: $currency, availableBalance: $availableBalance, pendingBalance: $pendingBalance, status: $status, settlementAccount: $settlementAccount, settlementConfig: $settlementConfig, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $WalletResponseCopyWith<$Res>  {
  factory $WalletResponseCopyWith(WalletResponse value, $Res Function(WalletResponse) _then) = _$WalletResponseCopyWithImpl;
@useResult
$Res call({
 String? walletId, String? mid, String? currency, num? availableBalance, num? pendingBalance, String? status, SettlementAccount? settlementAccount, SettlementConfig? settlementConfig, String? updatedAt
});


$SettlementAccountCopyWith<$Res>? get settlementAccount;$SettlementConfigCopyWith<$Res>? get settlementConfig;

}
/// @nodoc
class _$WalletResponseCopyWithImpl<$Res>
    implements $WalletResponseCopyWith<$Res> {
  _$WalletResponseCopyWithImpl(this._self, this._then);

  final WalletResponse _self;
  final $Res Function(WalletResponse) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? walletId = freezed,Object? mid = freezed,Object? currency = freezed,Object? availableBalance = freezed,Object? pendingBalance = freezed,Object? status = freezed,Object? settlementAccount = freezed,Object? settlementConfig = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,availableBalance: freezed == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as num?,pendingBalance: freezed == pendingBalance ? _self.pendingBalance : pendingBalance // ignore: cast_nullable_to_non_nullable
as num?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,settlementAccount: freezed == settlementAccount ? _self.settlementAccount : settlementAccount // ignore: cast_nullable_to_non_nullable
as SettlementAccount?,settlementConfig: freezed == settlementConfig ? _self.settlementConfig : settlementConfig // ignore: cast_nullable_to_non_nullable
as SettlementConfig?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettlementAccountCopyWith<$Res>? get settlementAccount {
    if (_self.settlementAccount == null) {
    return null;
  }

  return $SettlementAccountCopyWith<$Res>(_self.settlementAccount!, (value) {
    return _then(_self.copyWith(settlementAccount: value));
  });
}/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettlementConfigCopyWith<$Res>? get settlementConfig {
    if (_self.settlementConfig == null) {
    return null;
  }

  return $SettlementConfigCopyWith<$Res>(_self.settlementConfig!, (value) {
    return _then(_self.copyWith(settlementConfig: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? walletId,  String? mid,  String? currency,  num? availableBalance,  num? pendingBalance,  String? status,  SettlementAccount? settlementAccount,  SettlementConfig? settlementConfig,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
return $default(_that.walletId,_that.mid,_that.currency,_that.availableBalance,_that.pendingBalance,_that.status,_that.settlementAccount,_that.settlementConfig,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? walletId,  String? mid,  String? currency,  num? availableBalance,  num? pendingBalance,  String? status,  SettlementAccount? settlementAccount,  SettlementConfig? settlementConfig,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _WalletResponse():
return $default(_that.walletId,_that.mid,_that.currency,_that.availableBalance,_that.pendingBalance,_that.status,_that.settlementAccount,_that.settlementConfig,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? walletId,  String? mid,  String? currency,  num? availableBalance,  num? pendingBalance,  String? status,  SettlementAccount? settlementAccount,  SettlementConfig? settlementConfig,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletResponse() when $default != null:
return $default(_that.walletId,_that.mid,_that.currency,_that.availableBalance,_that.pendingBalance,_that.status,_that.settlementAccount,_that.settlementConfig,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletResponse implements WalletResponse {
  const _WalletResponse({this.walletId, this.mid, this.currency, this.availableBalance, this.pendingBalance, this.status, this.settlementAccount, this.settlementConfig, this.updatedAt});
  factory _WalletResponse.fromJson(Map<String, dynamic> json) => _$WalletResponseFromJson(json);

@override final  String? walletId;
@override final  String? mid;
@override final  String? currency;
@override final  num? availableBalance;
@override final  num? pendingBalance;
@override final  String? status;
@override final  SettlementAccount? settlementAccount;
@override final  SettlementConfig? settlementConfig;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletResponse&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.pendingBalance, pendingBalance) || other.pendingBalance == pendingBalance)&&(identical(other.status, status) || other.status == status)&&(identical(other.settlementAccount, settlementAccount) || other.settlementAccount == settlementAccount)&&(identical(other.settlementConfig, settlementConfig) || other.settlementConfig == settlementConfig)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,walletId,mid,currency,availableBalance,pendingBalance,status,settlementAccount,settlementConfig,updatedAt);

@override
String toString() {
  return 'WalletResponse(walletId: $walletId, mid: $mid, currency: $currency, availableBalance: $availableBalance, pendingBalance: $pendingBalance, status: $status, settlementAccount: $settlementAccount, settlementConfig: $settlementConfig, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WalletResponseCopyWith<$Res> implements $WalletResponseCopyWith<$Res> {
  factory _$WalletResponseCopyWith(_WalletResponse value, $Res Function(_WalletResponse) _then) = __$WalletResponseCopyWithImpl;
@override @useResult
$Res call({
 String? walletId, String? mid, String? currency, num? availableBalance, num? pendingBalance, String? status, SettlementAccount? settlementAccount, SettlementConfig? settlementConfig, String? updatedAt
});


@override $SettlementAccountCopyWith<$Res>? get settlementAccount;@override $SettlementConfigCopyWith<$Res>? get settlementConfig;

}
/// @nodoc
class __$WalletResponseCopyWithImpl<$Res>
    implements _$WalletResponseCopyWith<$Res> {
  __$WalletResponseCopyWithImpl(this._self, this._then);

  final _WalletResponse _self;
  final $Res Function(_WalletResponse) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? walletId = freezed,Object? mid = freezed,Object? currency = freezed,Object? availableBalance = freezed,Object? pendingBalance = freezed,Object? status = freezed,Object? settlementAccount = freezed,Object? settlementConfig = freezed,Object? updatedAt = freezed,}) {
  return _then(_WalletResponse(
walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,availableBalance: freezed == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as num?,pendingBalance: freezed == pendingBalance ? _self.pendingBalance : pendingBalance // ignore: cast_nullable_to_non_nullable
as num?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,settlementAccount: freezed == settlementAccount ? _self.settlementAccount : settlementAccount // ignore: cast_nullable_to_non_nullable
as SettlementAccount?,settlementConfig: freezed == settlementConfig ? _self.settlementConfig : settlementConfig // ignore: cast_nullable_to_non_nullable
as SettlementConfig?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettlementAccountCopyWith<$Res>? get settlementAccount {
    if (_self.settlementAccount == null) {
    return null;
  }

  return $SettlementAccountCopyWith<$Res>(_self.settlementAccount!, (value) {
    return _then(_self.copyWith(settlementAccount: value));
  });
}/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettlementConfigCopyWith<$Res>? get settlementConfig {
    if (_self.settlementConfig == null) {
    return null;
  }

  return $SettlementConfigCopyWith<$Res>(_self.settlementConfig!, (value) {
    return _then(_self.copyWith(settlementConfig: value));
  });
}
}


/// @nodoc
mixin _$SettlementAccount {

 String? get bankName; String? get accountName; String? get accountNumberMasked; String? get accountNumber;
/// Create a copy of SettlementAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementAccountCopyWith<SettlementAccount> get copyWith => _$SettlementAccountCopyWithImpl<SettlementAccount>(this as SettlementAccount, _$identity);

  /// Serializes this SettlementAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementAccount&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNumberMasked, accountNumberMasked) || other.accountNumberMasked == accountNumberMasked)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bankName,accountName,accountNumberMasked,accountNumber);

@override
String toString() {
  return 'SettlementAccount(bankName: $bankName, accountName: $accountName, accountNumberMasked: $accountNumberMasked, accountNumber: $accountNumber)';
}


}

/// @nodoc
abstract mixin class $SettlementAccountCopyWith<$Res>  {
  factory $SettlementAccountCopyWith(SettlementAccount value, $Res Function(SettlementAccount) _then) = _$SettlementAccountCopyWithImpl;
@useResult
$Res call({
 String? bankName, String? accountName, String? accountNumberMasked, String? accountNumber
});




}
/// @nodoc
class _$SettlementAccountCopyWithImpl<$Res>
    implements $SettlementAccountCopyWith<$Res> {
  _$SettlementAccountCopyWithImpl(this._self, this._then);

  final SettlementAccount _self;
  final $Res Function(SettlementAccount) _then;

/// Create a copy of SettlementAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bankName = freezed,Object? accountName = freezed,Object? accountNumberMasked = freezed,Object? accountNumber = freezed,}) {
  return _then(_self.copyWith(
bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountNumberMasked: freezed == accountNumberMasked ? _self.accountNumberMasked : accountNumberMasked // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementAccount].
extension SettlementAccountPatterns on SettlementAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementAccount value)  $default,){
final _that = this;
switch (_that) {
case _SettlementAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementAccount value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? bankName,  String? accountName,  String? accountNumberMasked,  String? accountNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementAccount() when $default != null:
return $default(_that.bankName,_that.accountName,_that.accountNumberMasked,_that.accountNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? bankName,  String? accountName,  String? accountNumberMasked,  String? accountNumber)  $default,) {final _that = this;
switch (_that) {
case _SettlementAccount():
return $default(_that.bankName,_that.accountName,_that.accountNumberMasked,_that.accountNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? bankName,  String? accountName,  String? accountNumberMasked,  String? accountNumber)?  $default,) {final _that = this;
switch (_that) {
case _SettlementAccount() when $default != null:
return $default(_that.bankName,_that.accountName,_that.accountNumberMasked,_that.accountNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementAccount implements SettlementAccount {
  const _SettlementAccount({this.bankName, this.accountName, this.accountNumberMasked, this.accountNumber});
  factory _SettlementAccount.fromJson(Map<String, dynamic> json) => _$SettlementAccountFromJson(json);

@override final  String? bankName;
@override final  String? accountName;
@override final  String? accountNumberMasked;
@override final  String? accountNumber;

/// Create a copy of SettlementAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementAccountCopyWith<_SettlementAccount> get copyWith => __$SettlementAccountCopyWithImpl<_SettlementAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlementAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementAccount&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNumberMasked, accountNumberMasked) || other.accountNumberMasked == accountNumberMasked)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bankName,accountName,accountNumberMasked,accountNumber);

@override
String toString() {
  return 'SettlementAccount(bankName: $bankName, accountName: $accountName, accountNumberMasked: $accountNumberMasked, accountNumber: $accountNumber)';
}


}

/// @nodoc
abstract mixin class _$SettlementAccountCopyWith<$Res> implements $SettlementAccountCopyWith<$Res> {
  factory _$SettlementAccountCopyWith(_SettlementAccount value, $Res Function(_SettlementAccount) _then) = __$SettlementAccountCopyWithImpl;
@override @useResult
$Res call({
 String? bankName, String? accountName, String? accountNumberMasked, String? accountNumber
});




}
/// @nodoc
class __$SettlementAccountCopyWithImpl<$Res>
    implements _$SettlementAccountCopyWith<$Res> {
  __$SettlementAccountCopyWithImpl(this._self, this._then);

  final _SettlementAccount _self;
  final $Res Function(_SettlementAccount) _then;

/// Create a copy of SettlementAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bankName = freezed,Object? accountName = freezed,Object? accountNumberMasked = freezed,Object? accountNumber = freezed,}) {
  return _then(_SettlementAccount(
bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountNumberMasked: freezed == accountNumberMasked ? _self.accountNumberMasked : accountNumberMasked // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SettlementConfig {

 String? get cycle; bool? get instantEnabled; num? get minimumAmount; String? get nextSettlementDate; num? get nextSettlementAmount;
/// Create a copy of SettlementConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementConfigCopyWith<SettlementConfig> get copyWith => _$SettlementConfigCopyWithImpl<SettlementConfig>(this as SettlementConfig, _$identity);

  /// Serializes this SettlementConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementConfig&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.instantEnabled, instantEnabled) || other.instantEnabled == instantEnabled)&&(identical(other.minimumAmount, minimumAmount) || other.minimumAmount == minimumAmount)&&(identical(other.nextSettlementDate, nextSettlementDate) || other.nextSettlementDate == nextSettlementDate)&&(identical(other.nextSettlementAmount, nextSettlementAmount) || other.nextSettlementAmount == nextSettlementAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cycle,instantEnabled,minimumAmount,nextSettlementDate,nextSettlementAmount);

@override
String toString() {
  return 'SettlementConfig(cycle: $cycle, instantEnabled: $instantEnabled, minimumAmount: $minimumAmount, nextSettlementDate: $nextSettlementDate, nextSettlementAmount: $nextSettlementAmount)';
}


}

/// @nodoc
abstract mixin class $SettlementConfigCopyWith<$Res>  {
  factory $SettlementConfigCopyWith(SettlementConfig value, $Res Function(SettlementConfig) _then) = _$SettlementConfigCopyWithImpl;
@useResult
$Res call({
 String? cycle, bool? instantEnabled, num? minimumAmount, String? nextSettlementDate, num? nextSettlementAmount
});




}
/// @nodoc
class _$SettlementConfigCopyWithImpl<$Res>
    implements $SettlementConfigCopyWith<$Res> {
  _$SettlementConfigCopyWithImpl(this._self, this._then);

  final SettlementConfig _self;
  final $Res Function(SettlementConfig) _then;

/// Create a copy of SettlementConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cycle = freezed,Object? instantEnabled = freezed,Object? minimumAmount = freezed,Object? nextSettlementDate = freezed,Object? nextSettlementAmount = freezed,}) {
  return _then(_self.copyWith(
cycle: freezed == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as String?,instantEnabled: freezed == instantEnabled ? _self.instantEnabled : instantEnabled // ignore: cast_nullable_to_non_nullable
as bool?,minimumAmount: freezed == minimumAmount ? _self.minimumAmount : minimumAmount // ignore: cast_nullable_to_non_nullable
as num?,nextSettlementDate: freezed == nextSettlementDate ? _self.nextSettlementDate : nextSettlementDate // ignore: cast_nullable_to_non_nullable
as String?,nextSettlementAmount: freezed == nextSettlementAmount ? _self.nextSettlementAmount : nextSettlementAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementConfig].
extension SettlementConfigPatterns on SettlementConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementConfig value)  $default,){
final _that = this;
switch (_that) {
case _SettlementConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? cycle,  bool? instantEnabled,  num? minimumAmount,  String? nextSettlementDate,  num? nextSettlementAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementConfig() when $default != null:
return $default(_that.cycle,_that.instantEnabled,_that.minimumAmount,_that.nextSettlementDate,_that.nextSettlementAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? cycle,  bool? instantEnabled,  num? minimumAmount,  String? nextSettlementDate,  num? nextSettlementAmount)  $default,) {final _that = this;
switch (_that) {
case _SettlementConfig():
return $default(_that.cycle,_that.instantEnabled,_that.minimumAmount,_that.nextSettlementDate,_that.nextSettlementAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? cycle,  bool? instantEnabled,  num? minimumAmount,  String? nextSettlementDate,  num? nextSettlementAmount)?  $default,) {final _that = this;
switch (_that) {
case _SettlementConfig() when $default != null:
return $default(_that.cycle,_that.instantEnabled,_that.minimumAmount,_that.nextSettlementDate,_that.nextSettlementAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementConfig implements SettlementConfig {
  const _SettlementConfig({this.cycle, this.instantEnabled, this.minimumAmount, this.nextSettlementDate, this.nextSettlementAmount});
  factory _SettlementConfig.fromJson(Map<String, dynamic> json) => _$SettlementConfigFromJson(json);

@override final  String? cycle;
@override final  bool? instantEnabled;
@override final  num? minimumAmount;
@override final  String? nextSettlementDate;
@override final  num? nextSettlementAmount;

/// Create a copy of SettlementConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementConfigCopyWith<_SettlementConfig> get copyWith => __$SettlementConfigCopyWithImpl<_SettlementConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlementConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementConfig&&(identical(other.cycle, cycle) || other.cycle == cycle)&&(identical(other.instantEnabled, instantEnabled) || other.instantEnabled == instantEnabled)&&(identical(other.minimumAmount, minimumAmount) || other.minimumAmount == minimumAmount)&&(identical(other.nextSettlementDate, nextSettlementDate) || other.nextSettlementDate == nextSettlementDate)&&(identical(other.nextSettlementAmount, nextSettlementAmount) || other.nextSettlementAmount == nextSettlementAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cycle,instantEnabled,minimumAmount,nextSettlementDate,nextSettlementAmount);

@override
String toString() {
  return 'SettlementConfig(cycle: $cycle, instantEnabled: $instantEnabled, minimumAmount: $minimumAmount, nextSettlementDate: $nextSettlementDate, nextSettlementAmount: $nextSettlementAmount)';
}


}

/// @nodoc
abstract mixin class _$SettlementConfigCopyWith<$Res> implements $SettlementConfigCopyWith<$Res> {
  factory _$SettlementConfigCopyWith(_SettlementConfig value, $Res Function(_SettlementConfig) _then) = __$SettlementConfigCopyWithImpl;
@override @useResult
$Res call({
 String? cycle, bool? instantEnabled, num? minimumAmount, String? nextSettlementDate, num? nextSettlementAmount
});




}
/// @nodoc
class __$SettlementConfigCopyWithImpl<$Res>
    implements _$SettlementConfigCopyWith<$Res> {
  __$SettlementConfigCopyWithImpl(this._self, this._then);

  final _SettlementConfig _self;
  final $Res Function(_SettlementConfig) _then;

/// Create a copy of SettlementConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cycle = freezed,Object? instantEnabled = freezed,Object? minimumAmount = freezed,Object? nextSettlementDate = freezed,Object? nextSettlementAmount = freezed,}) {
  return _then(_SettlementConfig(
cycle: freezed == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as String?,instantEnabled: freezed == instantEnabled ? _self.instantEnabled : instantEnabled // ignore: cast_nullable_to_non_nullable
as bool?,minimumAmount: freezed == minimumAmount ? _self.minimumAmount : minimumAmount // ignore: cast_nullable_to_non_nullable
as num?,nextSettlementDate: freezed == nextSettlementDate ? _self.nextSettlementDate : nextSettlementDate // ignore: cast_nullable_to_non_nullable
as String?,nextSettlementAmount: freezed == nextSettlementAmount ? _self.nextSettlementAmount : nextSettlementAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
