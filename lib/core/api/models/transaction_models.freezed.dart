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

 String? get reference; String? get rrn; String? get stan; String? get authCode; String? get mid; String? get tid; String? get storeName; String? get terminalSerial; String? get merchantAddress; String? get type; String? get status; String? get responseCode; num? get amount; num? get fee; num? get netAmount; String? get currency; String? get cardScheme; String? get cardType; String? get maskedPan; String? get channel; String? get transactionDate; String? get settlementReference; String? get settlementStatus; String? get originalReference; String? get receiptUrl;
/// Create a copy of TransactionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionResponseCopyWith<TransactionResponse> get copyWith => _$TransactionResponseCopyWithImpl<TransactionResponse>(this as TransactionResponse, _$identity);

  /// Serializes this TransactionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionResponse&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.rrn, rrn) || other.rrn == rrn)&&(identical(other.stan, stan) || other.stan == stan)&&(identical(other.authCode, authCode) || other.authCode == authCode)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.terminalSerial, terminalSerial) || other.terminalSerial == terminalSerial)&&(identical(other.merchantAddress, merchantAddress) || other.merchantAddress == merchantAddress)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.responseCode, responseCode) || other.responseCode == responseCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.cardScheme, cardScheme) || other.cardScheme == cardScheme)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.maskedPan, maskedPan) || other.maskedPan == maskedPan)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.settlementReference, settlementReference) || other.settlementReference == settlementReference)&&(identical(other.settlementStatus, settlementStatus) || other.settlementStatus == settlementStatus)&&(identical(other.originalReference, originalReference) || other.originalReference == originalReference)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,reference,rrn,stan,authCode,mid,tid,storeName,terminalSerial,merchantAddress,type,status,responseCode,amount,fee,netAmount,currency,cardScheme,cardType,maskedPan,channel,transactionDate,settlementReference,settlementStatus,originalReference,receiptUrl]);

@override
String toString() {
  return 'TransactionResponse(reference: $reference, rrn: $rrn, stan: $stan, authCode: $authCode, mid: $mid, tid: $tid, storeName: $storeName, terminalSerial: $terminalSerial, merchantAddress: $merchantAddress, type: $type, status: $status, responseCode: $responseCode, amount: $amount, fee: $fee, netAmount: $netAmount, currency: $currency, cardScheme: $cardScheme, cardType: $cardType, maskedPan: $maskedPan, channel: $channel, transactionDate: $transactionDate, settlementReference: $settlementReference, settlementStatus: $settlementStatus, originalReference: $originalReference, receiptUrl: $receiptUrl)';
}


}

/// @nodoc
abstract mixin class $TransactionResponseCopyWith<$Res>  {
  factory $TransactionResponseCopyWith(TransactionResponse value, $Res Function(TransactionResponse) _then) = _$TransactionResponseCopyWithImpl;
@useResult
$Res call({
 String? reference, String? rrn, String? stan, String? authCode, String? mid, String? tid, String? storeName, String? terminalSerial, String? merchantAddress, String? type, String? status, String? responseCode, num? amount, num? fee, num? netAmount, String? currency, String? cardScheme, String? cardType, String? maskedPan, String? channel, String? transactionDate, String? settlementReference, String? settlementStatus, String? originalReference, String? receiptUrl
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
@pragma('vm:prefer-inline') @override $Res call({Object? reference = freezed,Object? rrn = freezed,Object? stan = freezed,Object? authCode = freezed,Object? mid = freezed,Object? tid = freezed,Object? storeName = freezed,Object? terminalSerial = freezed,Object? merchantAddress = freezed,Object? type = freezed,Object? status = freezed,Object? responseCode = freezed,Object? amount = freezed,Object? fee = freezed,Object? netAmount = freezed,Object? currency = freezed,Object? cardScheme = freezed,Object? cardType = freezed,Object? maskedPan = freezed,Object? channel = freezed,Object? transactionDate = freezed,Object? settlementReference = freezed,Object? settlementStatus = freezed,Object? originalReference = freezed,Object? receiptUrl = freezed,}) {
  return _then(_self.copyWith(
reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,rrn: freezed == rrn ? _self.rrn : rrn // ignore: cast_nullable_to_non_nullable
as String?,stan: freezed == stan ? _self.stan : stan // ignore: cast_nullable_to_non_nullable
as String?,authCode: freezed == authCode ? _self.authCode : authCode // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,storeName: freezed == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String?,terminalSerial: freezed == terminalSerial ? _self.terminalSerial : terminalSerial // ignore: cast_nullable_to_non_nullable
as String?,merchantAddress: freezed == merchantAddress ? _self.merchantAddress : merchantAddress // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,responseCode: freezed == responseCode ? _self.responseCode : responseCode // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,fee: freezed == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,cardScheme: freezed == cardScheme ? _self.cardScheme : cardScheme // ignore: cast_nullable_to_non_nullable
as String?,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,maskedPan: freezed == maskedPan ? _self.maskedPan : maskedPan // ignore: cast_nullable_to_non_nullable
as String?,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,transactionDate: freezed == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? reference,  String? rrn,  String? stan,  String? authCode,  String? mid,  String? tid,  String? storeName,  String? terminalSerial,  String? merchantAddress,  String? type,  String? status,  String? responseCode,  num? amount,  num? fee,  num? netAmount,  String? currency,  String? cardScheme,  String? cardType,  String? maskedPan,  String? channel,  String? transactionDate,  String? settlementReference,  String? settlementStatus,  String? originalReference,  String? receiptUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionResponse() when $default != null:
return $default(_that.reference,_that.rrn,_that.stan,_that.authCode,_that.mid,_that.tid,_that.storeName,_that.terminalSerial,_that.merchantAddress,_that.type,_that.status,_that.responseCode,_that.amount,_that.fee,_that.netAmount,_that.currency,_that.cardScheme,_that.cardType,_that.maskedPan,_that.channel,_that.transactionDate,_that.settlementReference,_that.settlementStatus,_that.originalReference,_that.receiptUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? reference,  String? rrn,  String? stan,  String? authCode,  String? mid,  String? tid,  String? storeName,  String? terminalSerial,  String? merchantAddress,  String? type,  String? status,  String? responseCode,  num? amount,  num? fee,  num? netAmount,  String? currency,  String? cardScheme,  String? cardType,  String? maskedPan,  String? channel,  String? transactionDate,  String? settlementReference,  String? settlementStatus,  String? originalReference,  String? receiptUrl)  $default,) {final _that = this;
switch (_that) {
case _TransactionResponse():
return $default(_that.reference,_that.rrn,_that.stan,_that.authCode,_that.mid,_that.tid,_that.storeName,_that.terminalSerial,_that.merchantAddress,_that.type,_that.status,_that.responseCode,_that.amount,_that.fee,_that.netAmount,_that.currency,_that.cardScheme,_that.cardType,_that.maskedPan,_that.channel,_that.transactionDate,_that.settlementReference,_that.settlementStatus,_that.originalReference,_that.receiptUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? reference,  String? rrn,  String? stan,  String? authCode,  String? mid,  String? tid,  String? storeName,  String? terminalSerial,  String? merchantAddress,  String? type,  String? status,  String? responseCode,  num? amount,  num? fee,  num? netAmount,  String? currency,  String? cardScheme,  String? cardType,  String? maskedPan,  String? channel,  String? transactionDate,  String? settlementReference,  String? settlementStatus,  String? originalReference,  String? receiptUrl)?  $default,) {final _that = this;
switch (_that) {
case _TransactionResponse() when $default != null:
return $default(_that.reference,_that.rrn,_that.stan,_that.authCode,_that.mid,_that.tid,_that.storeName,_that.terminalSerial,_that.merchantAddress,_that.type,_that.status,_that.responseCode,_that.amount,_that.fee,_that.netAmount,_that.currency,_that.cardScheme,_that.cardType,_that.maskedPan,_that.channel,_that.transactionDate,_that.settlementReference,_that.settlementStatus,_that.originalReference,_that.receiptUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionResponse implements TransactionResponse {
  const _TransactionResponse({this.reference, this.rrn, this.stan, this.authCode, this.mid, this.tid, this.storeName, this.terminalSerial, this.merchantAddress, this.type, this.status, this.responseCode, this.amount, this.fee, this.netAmount, this.currency, this.cardScheme, this.cardType, this.maskedPan, this.channel, this.transactionDate, this.settlementReference, this.settlementStatus, this.originalReference, this.receiptUrl});
  factory _TransactionResponse.fromJson(Map<String, dynamic> json) => _$TransactionResponseFromJson(json);

@override final  String? reference;
@override final  String? rrn;
@override final  String? stan;
@override final  String? authCode;
@override final  String? mid;
@override final  String? tid;
@override final  String? storeName;
@override final  String? terminalSerial;
@override final  String? merchantAddress;
@override final  String? type;
@override final  String? status;
@override final  String? responseCode;
@override final  num? amount;
@override final  num? fee;
@override final  num? netAmount;
@override final  String? currency;
@override final  String? cardScheme;
@override final  String? cardType;
@override final  String? maskedPan;
@override final  String? channel;
@override final  String? transactionDate;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionResponse&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.rrn, rrn) || other.rrn == rrn)&&(identical(other.stan, stan) || other.stan == stan)&&(identical(other.authCode, authCode) || other.authCode == authCode)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.terminalSerial, terminalSerial) || other.terminalSerial == terminalSerial)&&(identical(other.merchantAddress, merchantAddress) || other.merchantAddress == merchantAddress)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.responseCode, responseCode) || other.responseCode == responseCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.cardScheme, cardScheme) || other.cardScheme == cardScheme)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.maskedPan, maskedPan) || other.maskedPan == maskedPan)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.settlementReference, settlementReference) || other.settlementReference == settlementReference)&&(identical(other.settlementStatus, settlementStatus) || other.settlementStatus == settlementStatus)&&(identical(other.originalReference, originalReference) || other.originalReference == originalReference)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,reference,rrn,stan,authCode,mid,tid,storeName,terminalSerial,merchantAddress,type,status,responseCode,amount,fee,netAmount,currency,cardScheme,cardType,maskedPan,channel,transactionDate,settlementReference,settlementStatus,originalReference,receiptUrl]);

@override
String toString() {
  return 'TransactionResponse(reference: $reference, rrn: $rrn, stan: $stan, authCode: $authCode, mid: $mid, tid: $tid, storeName: $storeName, terminalSerial: $terminalSerial, merchantAddress: $merchantAddress, type: $type, status: $status, responseCode: $responseCode, amount: $amount, fee: $fee, netAmount: $netAmount, currency: $currency, cardScheme: $cardScheme, cardType: $cardType, maskedPan: $maskedPan, channel: $channel, transactionDate: $transactionDate, settlementReference: $settlementReference, settlementStatus: $settlementStatus, originalReference: $originalReference, receiptUrl: $receiptUrl)';
}


}

/// @nodoc
abstract mixin class _$TransactionResponseCopyWith<$Res> implements $TransactionResponseCopyWith<$Res> {
  factory _$TransactionResponseCopyWith(_TransactionResponse value, $Res Function(_TransactionResponse) _then) = __$TransactionResponseCopyWithImpl;
@override @useResult
$Res call({
 String? reference, String? rrn, String? stan, String? authCode, String? mid, String? tid, String? storeName, String? terminalSerial, String? merchantAddress, String? type, String? status, String? responseCode, num? amount, num? fee, num? netAmount, String? currency, String? cardScheme, String? cardType, String? maskedPan, String? channel, String? transactionDate, String? settlementReference, String? settlementStatus, String? originalReference, String? receiptUrl
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
@override @pragma('vm:prefer-inline') $Res call({Object? reference = freezed,Object? rrn = freezed,Object? stan = freezed,Object? authCode = freezed,Object? mid = freezed,Object? tid = freezed,Object? storeName = freezed,Object? terminalSerial = freezed,Object? merchantAddress = freezed,Object? type = freezed,Object? status = freezed,Object? responseCode = freezed,Object? amount = freezed,Object? fee = freezed,Object? netAmount = freezed,Object? currency = freezed,Object? cardScheme = freezed,Object? cardType = freezed,Object? maskedPan = freezed,Object? channel = freezed,Object? transactionDate = freezed,Object? settlementReference = freezed,Object? settlementStatus = freezed,Object? originalReference = freezed,Object? receiptUrl = freezed,}) {
  return _then(_TransactionResponse(
reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,rrn: freezed == rrn ? _self.rrn : rrn // ignore: cast_nullable_to_non_nullable
as String?,stan: freezed == stan ? _self.stan : stan // ignore: cast_nullable_to_non_nullable
as String?,authCode: freezed == authCode ? _self.authCode : authCode // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,storeName: freezed == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String?,terminalSerial: freezed == terminalSerial ? _self.terminalSerial : terminalSerial // ignore: cast_nullable_to_non_nullable
as String?,merchantAddress: freezed == merchantAddress ? _self.merchantAddress : merchantAddress // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,responseCode: freezed == responseCode ? _self.responseCode : responseCode // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,fee: freezed == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,cardScheme: freezed == cardScheme ? _self.cardScheme : cardScheme // ignore: cast_nullable_to_non_nullable
as String?,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,maskedPan: freezed == maskedPan ? _self.maskedPan : maskedPan // ignore: cast_nullable_to_non_nullable
as String?,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,transactionDate: freezed == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
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
