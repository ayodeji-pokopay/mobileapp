// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionResponse {

 String? get id; String? get transactionRef; String? get tid; String? get mid; String? get merchantEmail; String? get storeName; String? get transactionType; String? get panMasked; String? get cardScheme; String? get cardBank; String? get cardBrand; String? get cardType; String? get cardCountryCode; num? get amount; num? get feeAmount; String? get currencyCode; String? get status; String? get responseCode; String? get responseCodeDescription; String? get authCode; String? get processorHost; int? get durationMs; String? get errorMessage; String? get initiatedAt; String? get completedAt; String? get settlementReference; String? get settlementStatus; String? get originalReference; String? get receiptUrl;
/// Create a copy of TransactionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionResponseCopyWith<TransactionResponse> get copyWith => _$TransactionResponseCopyWithImpl<TransactionResponse>(this as TransactionResponse, _$identity);

  /// Serializes this TransactionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionRef, transactionRef) || other.transactionRef == transactionRef)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantEmail, merchantEmail) || other.merchantEmail == merchantEmail)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.panMasked, panMasked) || other.panMasked == panMasked)&&(identical(other.cardScheme, cardScheme) || other.cardScheme == cardScheme)&&(identical(other.cardBank, cardBank) || other.cardBank == cardBank)&&(identical(other.cardBrand, cardBrand) || other.cardBrand == cardBrand)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.cardCountryCode, cardCountryCode) || other.cardCountryCode == cardCountryCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.feeAmount, feeAmount) || other.feeAmount == feeAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.responseCode, responseCode) || other.responseCode == responseCode)&&(identical(other.responseCodeDescription, responseCodeDescription) || other.responseCodeDescription == responseCodeDescription)&&(identical(other.authCode, authCode) || other.authCode == authCode)&&(identical(other.processorHost, processorHost) || other.processorHost == processorHost)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.initiatedAt, initiatedAt) || other.initiatedAt == initiatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.settlementReference, settlementReference) || other.settlementReference == settlementReference)&&(identical(other.settlementStatus, settlementStatus) || other.settlementStatus == settlementStatus)&&(identical(other.originalReference, originalReference) || other.originalReference == originalReference)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,transactionRef,tid,mid,merchantEmail,storeName,transactionType,panMasked,cardScheme,cardBank,cardBrand,cardType,cardCountryCode,amount,feeAmount,currencyCode,status,responseCode,responseCodeDescription,authCode,processorHost,durationMs,errorMessage,initiatedAt,completedAt,settlementReference,settlementStatus,originalReference,receiptUrl]);

@override
String toString() {
  return 'TransactionResponse(id: $id, transactionRef: $transactionRef, tid: $tid, mid: $mid, merchantEmail: $merchantEmail, storeName: $storeName, transactionType: $transactionType, panMasked: $panMasked, cardScheme: $cardScheme, cardBank: $cardBank, cardBrand: $cardBrand, cardType: $cardType, cardCountryCode: $cardCountryCode, amount: $amount, feeAmount: $feeAmount, currencyCode: $currencyCode, status: $status, responseCode: $responseCode, responseCodeDescription: $responseCodeDescription, authCode: $authCode, processorHost: $processorHost, durationMs: $durationMs, errorMessage: $errorMessage, initiatedAt: $initiatedAt, completedAt: $completedAt, settlementReference: $settlementReference, settlementStatus: $settlementStatus, originalReference: $originalReference, receiptUrl: $receiptUrl)';
}


}

/// @nodoc
abstract mixin class $TransactionResponseCopyWith<$Res>  {
  factory $TransactionResponseCopyWith(TransactionResponse value, $Res Function(TransactionResponse) _then) = _$TransactionResponseCopyWithImpl;
@useResult
$Res call({
 String? id, String? transactionRef, String? tid, String? mid, String? merchantEmail, String? storeName, String? transactionType, String? panMasked, String? cardScheme, String? cardBank, String? cardBrand, String? cardType, String? cardCountryCode, num? amount, num? feeAmount, String? currencyCode, String? status, String? responseCode, String? responseCodeDescription, String? authCode, String? processorHost, int? durationMs, String? errorMessage, String? initiatedAt, String? completedAt, String? settlementReference, String? settlementStatus, String? originalReference, String? receiptUrl
});




}
/// @nodoc
class _$TransactionResponseCopyWithImpl<$Res>
    implements $TransactionResponseCopyWith<$Res> {
  _$TransactionResponseCopyWithImpl(this._self, this._then);

  final TransactionResponse _self;
  final $Res Function(TransactionResponse) _then;

/// Create a copy of TransactionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? transactionRef = freezed,Object? tid = freezed,Object? mid = freezed,Object? merchantEmail = freezed,Object? storeName = freezed,Object? transactionType = freezed,Object? panMasked = freezed,Object? cardScheme = freezed,Object? cardBank = freezed,Object? cardBrand = freezed,Object? cardType = freezed,Object? cardCountryCode = freezed,Object? amount = freezed,Object? feeAmount = freezed,Object? currencyCode = freezed,Object? status = freezed,Object? responseCode = freezed,Object? responseCodeDescription = freezed,Object? authCode = freezed,Object? processorHost = freezed,Object? durationMs = freezed,Object? errorMessage = freezed,Object? initiatedAt = freezed,Object? completedAt = freezed,Object? settlementReference = freezed,Object? settlementStatus = freezed,Object? originalReference = freezed,Object? receiptUrl = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,transactionRef: freezed == transactionRef ? _self.transactionRef : transactionRef // ignore: cast_nullable_to_non_nullable
as String?,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,merchantEmail: freezed == merchantEmail ? _self.merchantEmail : merchantEmail // ignore: cast_nullable_to_non_nullable
as String?,storeName: freezed == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String?,transactionType: freezed == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as String?,panMasked: freezed == panMasked ? _self.panMasked : panMasked // ignore: cast_nullable_to_non_nullable
as String?,cardScheme: freezed == cardScheme ? _self.cardScheme : cardScheme // ignore: cast_nullable_to_non_nullable
as String?,cardBank: freezed == cardBank ? _self.cardBank : cardBank // ignore: cast_nullable_to_non_nullable
as String?,cardBrand: freezed == cardBrand ? _self.cardBrand : cardBrand // ignore: cast_nullable_to_non_nullable
as String?,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,cardCountryCode: freezed == cardCountryCode ? _self.cardCountryCode : cardCountryCode // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,feeAmount: freezed == feeAmount ? _self.feeAmount : feeAmount // ignore: cast_nullable_to_non_nullable
as num?,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,responseCode: freezed == responseCode ? _self.responseCode : responseCode // ignore: cast_nullable_to_non_nullable
as String?,responseCodeDescription: freezed == responseCodeDescription ? _self.responseCodeDescription : responseCodeDescription // ignore: cast_nullable_to_non_nullable
as String?,authCode: freezed == authCode ? _self.authCode : authCode // ignore: cast_nullable_to_non_nullable
as String?,processorHost: freezed == processorHost ? _self.processorHost : processorHost // ignore: cast_nullable_to_non_nullable
as String?,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,initiatedAt: freezed == initiatedAt ? _self.initiatedAt : initiatedAt // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,settlementReference: freezed == settlementReference ? _self.settlementReference : settlementReference // ignore: cast_nullable_to_non_nullable
as String?,settlementStatus: freezed == settlementStatus ? _self.settlementStatus : settlementStatus // ignore: cast_nullable_to_non_nullable
as String?,originalReference: freezed == originalReference ? _self.originalReference : originalReference // ignore: cast_nullable_to_non_nullable
as String?,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionResponse].
extension TransactionResponsePatterns on TransactionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionResponse value)  $default,){
final _that = this;
switch (_that) {
case _TransactionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? transactionRef,  String? tid,  String? mid,  String? merchantEmail,  String? storeName,  String? transactionType,  String? panMasked,  String? cardScheme,  String? cardBank,  String? cardBrand,  String? cardType,  String? cardCountryCode,  num? amount,  num? feeAmount,  String? currencyCode,  String? status,  String? responseCode,  String? responseCodeDescription,  String? authCode,  String? processorHost,  int? durationMs,  String? errorMessage,  String? initiatedAt,  String? completedAt,  String? settlementReference,  String? settlementStatus,  String? originalReference,  String? receiptUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionResponse() when $default != null:
return $default(_that.id,_that.transactionRef,_that.tid,_that.mid,_that.merchantEmail,_that.storeName,_that.transactionType,_that.panMasked,_that.cardScheme,_that.cardBank,_that.cardBrand,_that.cardType,_that.cardCountryCode,_that.amount,_that.feeAmount,_that.currencyCode,_that.status,_that.responseCode,_that.responseCodeDescription,_that.authCode,_that.processorHost,_that.durationMs,_that.errorMessage,_that.initiatedAt,_that.completedAt,_that.settlementReference,_that.settlementStatus,_that.originalReference,_that.receiptUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? transactionRef,  String? tid,  String? mid,  String? merchantEmail,  String? storeName,  String? transactionType,  String? panMasked,  String? cardScheme,  String? cardBank,  String? cardBrand,  String? cardType,  String? cardCountryCode,  num? amount,  num? feeAmount,  String? currencyCode,  String? status,  String? responseCode,  String? responseCodeDescription,  String? authCode,  String? processorHost,  int? durationMs,  String? errorMessage,  String? initiatedAt,  String? completedAt,  String? settlementReference,  String? settlementStatus,  String? originalReference,  String? receiptUrl)  $default,) {final _that = this;
switch (_that) {
case _TransactionResponse():
return $default(_that.id,_that.transactionRef,_that.tid,_that.mid,_that.merchantEmail,_that.storeName,_that.transactionType,_that.panMasked,_that.cardScheme,_that.cardBank,_that.cardBrand,_that.cardType,_that.cardCountryCode,_that.amount,_that.feeAmount,_that.currencyCode,_that.status,_that.responseCode,_that.responseCodeDescription,_that.authCode,_that.processorHost,_that.durationMs,_that.errorMessage,_that.initiatedAt,_that.completedAt,_that.settlementReference,_that.settlementStatus,_that.originalReference,_that.receiptUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? transactionRef,  String? tid,  String? mid,  String? merchantEmail,  String? storeName,  String? transactionType,  String? panMasked,  String? cardScheme,  String? cardBank,  String? cardBrand,  String? cardType,  String? cardCountryCode,  num? amount,  num? feeAmount,  String? currencyCode,  String? status,  String? responseCode,  String? responseCodeDescription,  String? authCode,  String? processorHost,  int? durationMs,  String? errorMessage,  String? initiatedAt,  String? completedAt,  String? settlementReference,  String? settlementStatus,  String? originalReference,  String? receiptUrl)?  $default,) {final _that = this;
switch (_that) {
case _TransactionResponse() when $default != null:
return $default(_that.id,_that.transactionRef,_that.tid,_that.mid,_that.merchantEmail,_that.storeName,_that.transactionType,_that.panMasked,_that.cardScheme,_that.cardBank,_that.cardBrand,_that.cardType,_that.cardCountryCode,_that.amount,_that.feeAmount,_that.currencyCode,_that.status,_that.responseCode,_that.responseCodeDescription,_that.authCode,_that.processorHost,_that.durationMs,_that.errorMessage,_that.initiatedAt,_that.completedAt,_that.settlementReference,_that.settlementStatus,_that.originalReference,_that.receiptUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionResponse extends TransactionResponse {
  const _TransactionResponse({this.id, this.transactionRef, this.tid, this.mid, this.merchantEmail, this.storeName, this.transactionType, this.panMasked, this.cardScheme, this.cardBank, this.cardBrand, this.cardType, this.cardCountryCode, this.amount, this.feeAmount, this.currencyCode, this.status, this.responseCode, this.responseCodeDescription, this.authCode, this.processorHost, this.durationMs, this.errorMessage, this.initiatedAt, this.completedAt, this.settlementReference, this.settlementStatus, this.originalReference, this.receiptUrl}): super._();
  factory _TransactionResponse.fromJson(Map<String, dynamic> json) => _$TransactionResponseFromJson(json);

@override final  String? id;
@override final  String? transactionRef;
@override final  String? tid;
@override final  String? mid;
@override final  String? merchantEmail;
@override final  String? storeName;
@override final  String? transactionType;
@override final  String? panMasked;
@override final  String? cardScheme;
@override final  String? cardBank;
@override final  String? cardBrand;
@override final  String? cardType;
@override final  String? cardCountryCode;
@override final  num? amount;
@override final  num? feeAmount;
@override final  String? currencyCode;
@override final  String? status;
@override final  String? responseCode;
@override final  String? responseCodeDescription;
@override final  String? authCode;
@override final  String? processorHost;
@override final  int? durationMs;
@override final  String? errorMessage;
@override final  String? initiatedAt;
@override final  String? completedAt;
@override final  String? settlementReference;
@override final  String? settlementStatus;
@override final  String? originalReference;
@override final  String? receiptUrl;

/// Create a copy of TransactionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionResponseCopyWith<_TransactionResponse> get copyWith => __$TransactionResponseCopyWithImpl<_TransactionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionRef, transactionRef) || other.transactionRef == transactionRef)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantEmail, merchantEmail) || other.merchantEmail == merchantEmail)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.panMasked, panMasked) || other.panMasked == panMasked)&&(identical(other.cardScheme, cardScheme) || other.cardScheme == cardScheme)&&(identical(other.cardBank, cardBank) || other.cardBank == cardBank)&&(identical(other.cardBrand, cardBrand) || other.cardBrand == cardBrand)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.cardCountryCode, cardCountryCode) || other.cardCountryCode == cardCountryCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.feeAmount, feeAmount) || other.feeAmount == feeAmount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.responseCode, responseCode) || other.responseCode == responseCode)&&(identical(other.responseCodeDescription, responseCodeDescription) || other.responseCodeDescription == responseCodeDescription)&&(identical(other.authCode, authCode) || other.authCode == authCode)&&(identical(other.processorHost, processorHost) || other.processorHost == processorHost)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.initiatedAt, initiatedAt) || other.initiatedAt == initiatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.settlementReference, settlementReference) || other.settlementReference == settlementReference)&&(identical(other.settlementStatus, settlementStatus) || other.settlementStatus == settlementStatus)&&(identical(other.originalReference, originalReference) || other.originalReference == originalReference)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,transactionRef,tid,mid,merchantEmail,storeName,transactionType,panMasked,cardScheme,cardBank,cardBrand,cardType,cardCountryCode,amount,feeAmount,currencyCode,status,responseCode,responseCodeDescription,authCode,processorHost,durationMs,errorMessage,initiatedAt,completedAt,settlementReference,settlementStatus,originalReference,receiptUrl]);

@override
String toString() {
  return 'TransactionResponse(id: $id, transactionRef: $transactionRef, tid: $tid, mid: $mid, merchantEmail: $merchantEmail, storeName: $storeName, transactionType: $transactionType, panMasked: $panMasked, cardScheme: $cardScheme, cardBank: $cardBank, cardBrand: $cardBrand, cardType: $cardType, cardCountryCode: $cardCountryCode, amount: $amount, feeAmount: $feeAmount, currencyCode: $currencyCode, status: $status, responseCode: $responseCode, responseCodeDescription: $responseCodeDescription, authCode: $authCode, processorHost: $processorHost, durationMs: $durationMs, errorMessage: $errorMessage, initiatedAt: $initiatedAt, completedAt: $completedAt, settlementReference: $settlementReference, settlementStatus: $settlementStatus, originalReference: $originalReference, receiptUrl: $receiptUrl)';
}


}

/// @nodoc
abstract mixin class _$TransactionResponseCopyWith<$Res> implements $TransactionResponseCopyWith<$Res> {
  factory _$TransactionResponseCopyWith(_TransactionResponse value, $Res Function(_TransactionResponse) _then) = __$TransactionResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? transactionRef, String? tid, String? mid, String? merchantEmail, String? storeName, String? transactionType, String? panMasked, String? cardScheme, String? cardBank, String? cardBrand, String? cardType, String? cardCountryCode, num? amount, num? feeAmount, String? currencyCode, String? status, String? responseCode, String? responseCodeDescription, String? authCode, String? processorHost, int? durationMs, String? errorMessage, String? initiatedAt, String? completedAt, String? settlementReference, String? settlementStatus, String? originalReference, String? receiptUrl
});




}
/// @nodoc
class __$TransactionResponseCopyWithImpl<$Res>
    implements _$TransactionResponseCopyWith<$Res> {
  __$TransactionResponseCopyWithImpl(this._self, this._then);

  final _TransactionResponse _self;
  final $Res Function(_TransactionResponse) _then;

/// Create a copy of TransactionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? transactionRef = freezed,Object? tid = freezed,Object? mid = freezed,Object? merchantEmail = freezed,Object? storeName = freezed,Object? transactionType = freezed,Object? panMasked = freezed,Object? cardScheme = freezed,Object? cardBank = freezed,Object? cardBrand = freezed,Object? cardType = freezed,Object? cardCountryCode = freezed,Object? amount = freezed,Object? feeAmount = freezed,Object? currencyCode = freezed,Object? status = freezed,Object? responseCode = freezed,Object? responseCodeDescription = freezed,Object? authCode = freezed,Object? processorHost = freezed,Object? durationMs = freezed,Object? errorMessage = freezed,Object? initiatedAt = freezed,Object? completedAt = freezed,Object? settlementReference = freezed,Object? settlementStatus = freezed,Object? originalReference = freezed,Object? receiptUrl = freezed,}) {
  return _then(_TransactionResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,transactionRef: freezed == transactionRef ? _self.transactionRef : transactionRef // ignore: cast_nullable_to_non_nullable
as String?,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,merchantEmail: freezed == merchantEmail ? _self.merchantEmail : merchantEmail // ignore: cast_nullable_to_non_nullable
as String?,storeName: freezed == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String?,transactionType: freezed == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as String?,panMasked: freezed == panMasked ? _self.panMasked : panMasked // ignore: cast_nullable_to_non_nullable
as String?,cardScheme: freezed == cardScheme ? _self.cardScheme : cardScheme // ignore: cast_nullable_to_non_nullable
as String?,cardBank: freezed == cardBank ? _self.cardBank : cardBank // ignore: cast_nullable_to_non_nullable
as String?,cardBrand: freezed == cardBrand ? _self.cardBrand : cardBrand // ignore: cast_nullable_to_non_nullable
as String?,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,cardCountryCode: freezed == cardCountryCode ? _self.cardCountryCode : cardCountryCode // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,feeAmount: freezed == feeAmount ? _self.feeAmount : feeAmount // ignore: cast_nullable_to_non_nullable
as num?,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,responseCode: freezed == responseCode ? _self.responseCode : responseCode // ignore: cast_nullable_to_non_nullable
as String?,responseCodeDescription: freezed == responseCodeDescription ? _self.responseCodeDescription : responseCodeDescription // ignore: cast_nullable_to_non_nullable
as String?,authCode: freezed == authCode ? _self.authCode : authCode // ignore: cast_nullable_to_non_nullable
as String?,processorHost: freezed == processorHost ? _self.processorHost : processorHost // ignore: cast_nullable_to_non_nullable
as String?,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,initiatedAt: freezed == initiatedAt ? _self.initiatedAt : initiatedAt // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,settlementReference: freezed == settlementReference ? _self.settlementReference : settlementReference // ignore: cast_nullable_to_non_nullable
as String?,settlementStatus: freezed == settlementStatus ? _self.settlementStatus : settlementStatus // ignore: cast_nullable_to_non_nullable
as String?,originalReference: freezed == originalReference ? _self.originalReference : originalReference // ignore: cast_nullable_to_non_nullable
as String?,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PageTransactionResponse {

 List<TransactionResponse> get content; int? get totalElements; int? get totalPages; int? get number; int? get size; bool? get first; bool? get last;
/// Create a copy of PageTransactionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageTransactionResponseCopyWith<PageTransactionResponse> get copyWith => _$PageTransactionResponseCopyWithImpl<PageTransactionResponse>(this as PageTransactionResponse, _$identity);

  /// Serializes this PageTransactionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageTransactionResponse&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.number, number) || other.number == number)&&(identical(other.size, size) || other.size == size)&&(identical(other.first, first) || other.first == first)&&(identical(other.last, last) || other.last == last));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(content),totalElements,totalPages,number,size,first,last);

@override
String toString() {
  return 'PageTransactionResponse(content: $content, totalElements: $totalElements, totalPages: $totalPages, number: $number, size: $size, first: $first, last: $last)';
}


}

/// @nodoc
abstract mixin class $PageTransactionResponseCopyWith<$Res>  {
  factory $PageTransactionResponseCopyWith(PageTransactionResponse value, $Res Function(PageTransactionResponse) _then) = _$PageTransactionResponseCopyWithImpl;
@useResult
$Res call({
 List<TransactionResponse> content, int? totalElements, int? totalPages, int? number, int? size, bool? first, bool? last
});




}
/// @nodoc
class _$PageTransactionResponseCopyWithImpl<$Res>
    implements $PageTransactionResponseCopyWith<$Res> {
  _$PageTransactionResponseCopyWithImpl(this._self, this._then);

  final PageTransactionResponse _self;
  final $Res Function(PageTransactionResponse) _then;

/// Create a copy of PageTransactionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? totalElements = freezed,Object? totalPages = freezed,Object? number = freezed,Object? size = freezed,Object? first = freezed,Object? last = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<TransactionResponse>,totalElements: freezed == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int?,totalPages: freezed == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int?,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,first: freezed == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as bool?,last: freezed == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [PageTransactionResponse].
extension PageTransactionResponsePatterns on PageTransactionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageTransactionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageTransactionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageTransactionResponse value)  $default,){
final _that = this;
switch (_that) {
case _PageTransactionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageTransactionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PageTransactionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TransactionResponse> content,  int? totalElements,  int? totalPages,  int? number,  int? size,  bool? first,  bool? last)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageTransactionResponse() when $default != null:
return $default(_that.content,_that.totalElements,_that.totalPages,_that.number,_that.size,_that.first,_that.last);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TransactionResponse> content,  int? totalElements,  int? totalPages,  int? number,  int? size,  bool? first,  bool? last)  $default,) {final _that = this;
switch (_that) {
case _PageTransactionResponse():
return $default(_that.content,_that.totalElements,_that.totalPages,_that.number,_that.size,_that.first,_that.last);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TransactionResponse> content,  int? totalElements,  int? totalPages,  int? number,  int? size,  bool? first,  bool? last)?  $default,) {final _that = this;
switch (_that) {
case _PageTransactionResponse() when $default != null:
return $default(_that.content,_that.totalElements,_that.totalPages,_that.number,_that.size,_that.first,_that.last);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageTransactionResponse implements PageTransactionResponse {
  const _PageTransactionResponse({final  List<TransactionResponse> content = const <TransactionResponse>[], this.totalElements, this.totalPages, this.number, this.size, this.first, this.last}): _content = content;
  factory _PageTransactionResponse.fromJson(Map<String, dynamic> json) => _$PageTransactionResponseFromJson(json);

 final  List<TransactionResponse> _content;
@override@JsonKey() List<TransactionResponse> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

@override final  int? totalElements;
@override final  int? totalPages;
@override final  int? number;
@override final  int? size;
@override final  bool? first;
@override final  bool? last;

/// Create a copy of PageTransactionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageTransactionResponseCopyWith<_PageTransactionResponse> get copyWith => __$PageTransactionResponseCopyWithImpl<_PageTransactionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageTransactionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageTransactionResponse&&const DeepCollectionEquality().equals(other._content, _content)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.number, number) || other.number == number)&&(identical(other.size, size) || other.size == size)&&(identical(other.first, first) || other.first == first)&&(identical(other.last, last) || other.last == last));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_content),totalElements,totalPages,number,size,first,last);

@override
String toString() {
  return 'PageTransactionResponse(content: $content, totalElements: $totalElements, totalPages: $totalPages, number: $number, size: $size, first: $first, last: $last)';
}


}

/// @nodoc
abstract mixin class _$PageTransactionResponseCopyWith<$Res> implements $PageTransactionResponseCopyWith<$Res> {
  factory _$PageTransactionResponseCopyWith(_PageTransactionResponse value, $Res Function(_PageTransactionResponse) _then) = __$PageTransactionResponseCopyWithImpl;
@override @useResult
$Res call({
 List<TransactionResponse> content, int? totalElements, int? totalPages, int? number, int? size, bool? first, bool? last
});




}
/// @nodoc
class __$PageTransactionResponseCopyWithImpl<$Res>
    implements _$PageTransactionResponseCopyWith<$Res> {
  __$PageTransactionResponseCopyWithImpl(this._self, this._then);

  final _PageTransactionResponse _self;
  final $Res Function(_PageTransactionResponse) _then;

/// Create a copy of PageTransactionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? totalElements = freezed,Object? totalPages = freezed,Object? number = freezed,Object? size = freezed,Object? first = freezed,Object? last = freezed,}) {
  return _then(_PageTransactionResponse(
content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<TransactionResponse>,totalElements: freezed == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int?,totalPages: freezed == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int?,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,first: freezed == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as bool?,last: freezed == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
