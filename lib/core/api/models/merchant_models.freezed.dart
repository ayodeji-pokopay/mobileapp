// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merchant_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MerchantSettlementSummary {

 String? get mid; int? get totalSettlements; num? get totalSettledAmount; num? get pendingAmount; int? get todayTransactions; num? get todaySales;
/// Create a copy of MerchantSettlementSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MerchantSettlementSummaryCopyWith<MerchantSettlementSummary> get copyWith => _$MerchantSettlementSummaryCopyWithImpl<MerchantSettlementSummary>(this as MerchantSettlementSummary, _$identity);

  /// Serializes this MerchantSettlementSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MerchantSettlementSummary&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.totalSettlements, totalSettlements) || other.totalSettlements == totalSettlements)&&(identical(other.totalSettledAmount, totalSettledAmount) || other.totalSettledAmount == totalSettledAmount)&&(identical(other.pendingAmount, pendingAmount) || other.pendingAmount == pendingAmount)&&(identical(other.todayTransactions, todayTransactions) || other.todayTransactions == todayTransactions)&&(identical(other.todaySales, todaySales) || other.todaySales == todaySales));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,totalSettlements,totalSettledAmount,pendingAmount,todayTransactions,todaySales);

@override
String toString() {
  return 'MerchantSettlementSummary(mid: $mid, totalSettlements: $totalSettlements, totalSettledAmount: $totalSettledAmount, pendingAmount: $pendingAmount, todayTransactions: $todayTransactions, todaySales: $todaySales)';
}


}

/// @nodoc
abstract mixin class $MerchantSettlementSummaryCopyWith<$Res>  {
  factory $MerchantSettlementSummaryCopyWith(MerchantSettlementSummary value, $Res Function(MerchantSettlementSummary) _then) = _$MerchantSettlementSummaryCopyWithImpl;
@useResult
$Res call({
 String? mid, int? totalSettlements, num? totalSettledAmount, num? pendingAmount, int? todayTransactions, num? todaySales
});




}
/// @nodoc
class _$MerchantSettlementSummaryCopyWithImpl<$Res>
    implements $MerchantSettlementSummaryCopyWith<$Res> {
  _$MerchantSettlementSummaryCopyWithImpl(this._self, this._then);

  final MerchantSettlementSummary _self;
  final $Res Function(MerchantSettlementSummary) _then;

/// Create a copy of MerchantSettlementSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = freezed,Object? totalSettlements = freezed,Object? totalSettledAmount = freezed,Object? pendingAmount = freezed,Object? todayTransactions = freezed,Object? todaySales = freezed,}) {
  return _then(_self.copyWith(
mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,totalSettlements: freezed == totalSettlements ? _self.totalSettlements : totalSettlements // ignore: cast_nullable_to_non_nullable
as int?,totalSettledAmount: freezed == totalSettledAmount ? _self.totalSettledAmount : totalSettledAmount // ignore: cast_nullable_to_non_nullable
as num?,pendingAmount: freezed == pendingAmount ? _self.pendingAmount : pendingAmount // ignore: cast_nullable_to_non_nullable
as num?,todayTransactions: freezed == todayTransactions ? _self.todayTransactions : todayTransactions // ignore: cast_nullable_to_non_nullable
as int?,todaySales: freezed == todaySales ? _self.todaySales : todaySales // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [MerchantSettlementSummary].
extension MerchantSettlementSummaryPatterns on MerchantSettlementSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MerchantSettlementSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MerchantSettlementSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MerchantSettlementSummary value)  $default,){
final _that = this;
switch (_that) {
case _MerchantSettlementSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MerchantSettlementSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MerchantSettlementSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? mid,  int? totalSettlements,  num? totalSettledAmount,  num? pendingAmount,  int? todayTransactions,  num? todaySales)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MerchantSettlementSummary() when $default != null:
return $default(_that.mid,_that.totalSettlements,_that.totalSettledAmount,_that.pendingAmount,_that.todayTransactions,_that.todaySales);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? mid,  int? totalSettlements,  num? totalSettledAmount,  num? pendingAmount,  int? todayTransactions,  num? todaySales)  $default,) {final _that = this;
switch (_that) {
case _MerchantSettlementSummary():
return $default(_that.mid,_that.totalSettlements,_that.totalSettledAmount,_that.pendingAmount,_that.todayTransactions,_that.todaySales);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? mid,  int? totalSettlements,  num? totalSettledAmount,  num? pendingAmount,  int? todayTransactions,  num? todaySales)?  $default,) {final _that = this;
switch (_that) {
case _MerchantSettlementSummary() when $default != null:
return $default(_that.mid,_that.totalSettlements,_that.totalSettledAmount,_that.pendingAmount,_that.todayTransactions,_that.todaySales);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MerchantSettlementSummary implements MerchantSettlementSummary {
  const _MerchantSettlementSummary({this.mid, this.totalSettlements, this.totalSettledAmount, this.pendingAmount, this.todayTransactions, this.todaySales});
  factory _MerchantSettlementSummary.fromJson(Map<String, dynamic> json) => _$MerchantSettlementSummaryFromJson(json);

@override final  String? mid;
@override final  int? totalSettlements;
@override final  num? totalSettledAmount;
@override final  num? pendingAmount;
@override final  int? todayTransactions;
@override final  num? todaySales;

/// Create a copy of MerchantSettlementSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MerchantSettlementSummaryCopyWith<_MerchantSettlementSummary> get copyWith => __$MerchantSettlementSummaryCopyWithImpl<_MerchantSettlementSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MerchantSettlementSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MerchantSettlementSummary&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.totalSettlements, totalSettlements) || other.totalSettlements == totalSettlements)&&(identical(other.totalSettledAmount, totalSettledAmount) || other.totalSettledAmount == totalSettledAmount)&&(identical(other.pendingAmount, pendingAmount) || other.pendingAmount == pendingAmount)&&(identical(other.todayTransactions, todayTransactions) || other.todayTransactions == todayTransactions)&&(identical(other.todaySales, todaySales) || other.todaySales == todaySales));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,totalSettlements,totalSettledAmount,pendingAmount,todayTransactions,todaySales);

@override
String toString() {
  return 'MerchantSettlementSummary(mid: $mid, totalSettlements: $totalSettlements, totalSettledAmount: $totalSettledAmount, pendingAmount: $pendingAmount, todayTransactions: $todayTransactions, todaySales: $todaySales)';
}


}

/// @nodoc
abstract mixin class _$MerchantSettlementSummaryCopyWith<$Res> implements $MerchantSettlementSummaryCopyWith<$Res> {
  factory _$MerchantSettlementSummaryCopyWith(_MerchantSettlementSummary value, $Res Function(_MerchantSettlementSummary) _then) = __$MerchantSettlementSummaryCopyWithImpl;
@override @useResult
$Res call({
 String? mid, int? totalSettlements, num? totalSettledAmount, num? pendingAmount, int? todayTransactions, num? todaySales
});




}
/// @nodoc
class __$MerchantSettlementSummaryCopyWithImpl<$Res>
    implements _$MerchantSettlementSummaryCopyWith<$Res> {
  __$MerchantSettlementSummaryCopyWithImpl(this._self, this._then);

  final _MerchantSettlementSummary _self;
  final $Res Function(_MerchantSettlementSummary) _then;

/// Create a copy of MerchantSettlementSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = freezed,Object? totalSettlements = freezed,Object? totalSettledAmount = freezed,Object? pendingAmount = freezed,Object? todayTransactions = freezed,Object? todaySales = freezed,}) {
  return _then(_MerchantSettlementSummary(
mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,totalSettlements: freezed == totalSettlements ? _self.totalSettlements : totalSettlements // ignore: cast_nullable_to_non_nullable
as int?,totalSettledAmount: freezed == totalSettledAmount ? _self.totalSettledAmount : totalSettledAmount // ignore: cast_nullable_to_non_nullable
as num?,pendingAmount: freezed == pendingAmount ? _self.pendingAmount : pendingAmount // ignore: cast_nullable_to_non_nullable
as num?,todayTransactions: freezed == todayTransactions ? _self.todayTransactions : todayTransactions // ignore: cast_nullable_to_non_nullable
as int?,todaySales: freezed == todaySales ? _self.todaySales : todaySales // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}


/// @nodoc
mixin _$CardSchemeSummary {

 String? get cardScheme; int? get transactionCount; num? get totalAmount; num? get totalFees; num? get netAmount;
/// Create a copy of CardSchemeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardSchemeSummaryCopyWith<CardSchemeSummary> get copyWith => _$CardSchemeSummaryCopyWithImpl<CardSchemeSummary>(this as CardSchemeSummary, _$identity);

  /// Serializes this CardSchemeSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardSchemeSummary&&(identical(other.cardScheme, cardScheme) || other.cardScheme == cardScheme)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardScheme,transactionCount,totalAmount,totalFees,netAmount);

@override
String toString() {
  return 'CardSchemeSummary(cardScheme: $cardScheme, transactionCount: $transactionCount, totalAmount: $totalAmount, totalFees: $totalFees, netAmount: $netAmount)';
}


}

/// @nodoc
abstract mixin class $CardSchemeSummaryCopyWith<$Res>  {
  factory $CardSchemeSummaryCopyWith(CardSchemeSummary value, $Res Function(CardSchemeSummary) _then) = _$CardSchemeSummaryCopyWithImpl;
@useResult
$Res call({
 String? cardScheme, int? transactionCount, num? totalAmount, num? totalFees, num? netAmount
});




}
/// @nodoc
class _$CardSchemeSummaryCopyWithImpl<$Res>
    implements $CardSchemeSummaryCopyWith<$Res> {
  _$CardSchemeSummaryCopyWithImpl(this._self, this._then);

  final CardSchemeSummary _self;
  final $Res Function(CardSchemeSummary) _then;

/// Create a copy of CardSchemeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardScheme = freezed,Object? transactionCount = freezed,Object? totalAmount = freezed,Object? totalFees = freezed,Object? netAmount = freezed,}) {
  return _then(_self.copyWith(
cardScheme: freezed == cardScheme ? _self.cardScheme : cardScheme // ignore: cast_nullable_to_non_nullable
as String?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num?,totalFees: freezed == totalFees ? _self.totalFees : totalFees // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [CardSchemeSummary].
extension CardSchemeSummaryPatterns on CardSchemeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardSchemeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardSchemeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardSchemeSummary value)  $default,){
final _that = this;
switch (_that) {
case _CardSchemeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardSchemeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CardSchemeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? cardScheme,  int? transactionCount,  num? totalAmount,  num? totalFees,  num? netAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardSchemeSummary() when $default != null:
return $default(_that.cardScheme,_that.transactionCount,_that.totalAmount,_that.totalFees,_that.netAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? cardScheme,  int? transactionCount,  num? totalAmount,  num? totalFees,  num? netAmount)  $default,) {final _that = this;
switch (_that) {
case _CardSchemeSummary():
return $default(_that.cardScheme,_that.transactionCount,_that.totalAmount,_that.totalFees,_that.netAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? cardScheme,  int? transactionCount,  num? totalAmount,  num? totalFees,  num? netAmount)?  $default,) {final _that = this;
switch (_that) {
case _CardSchemeSummary() when $default != null:
return $default(_that.cardScheme,_that.transactionCount,_that.totalAmount,_that.totalFees,_that.netAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CardSchemeSummary implements CardSchemeSummary {
  const _CardSchemeSummary({this.cardScheme, this.transactionCount, this.totalAmount, this.totalFees, this.netAmount});
  factory _CardSchemeSummary.fromJson(Map<String, dynamic> json) => _$CardSchemeSummaryFromJson(json);

@override final  String? cardScheme;
@override final  int? transactionCount;
@override final  num? totalAmount;
@override final  num? totalFees;
@override final  num? netAmount;

/// Create a copy of CardSchemeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardSchemeSummaryCopyWith<_CardSchemeSummary> get copyWith => __$CardSchemeSummaryCopyWithImpl<_CardSchemeSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardSchemeSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardSchemeSummary&&(identical(other.cardScheme, cardScheme) || other.cardScheme == cardScheme)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardScheme,transactionCount,totalAmount,totalFees,netAmount);

@override
String toString() {
  return 'CardSchemeSummary(cardScheme: $cardScheme, transactionCount: $transactionCount, totalAmount: $totalAmount, totalFees: $totalFees, netAmount: $netAmount)';
}


}

/// @nodoc
abstract mixin class _$CardSchemeSummaryCopyWith<$Res> implements $CardSchemeSummaryCopyWith<$Res> {
  factory _$CardSchemeSummaryCopyWith(_CardSchemeSummary value, $Res Function(_CardSchemeSummary) _then) = __$CardSchemeSummaryCopyWithImpl;
@override @useResult
$Res call({
 String? cardScheme, int? transactionCount, num? totalAmount, num? totalFees, num? netAmount
});




}
/// @nodoc
class __$CardSchemeSummaryCopyWithImpl<$Res>
    implements _$CardSchemeSummaryCopyWith<$Res> {
  __$CardSchemeSummaryCopyWithImpl(this._self, this._then);

  final _CardSchemeSummary _self;
  final $Res Function(_CardSchemeSummary) _then;

/// Create a copy of CardSchemeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardScheme = freezed,Object? transactionCount = freezed,Object? totalAmount = freezed,Object? totalFees = freezed,Object? netAmount = freezed,}) {
  return _then(_CardSchemeSummary(
cardScheme: freezed == cardScheme ? _self.cardScheme : cardScheme // ignore: cast_nullable_to_non_nullable
as String?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num?,totalFees: freezed == totalFees ? _self.totalFees : totalFees // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}


/// @nodoc
mixin _$DailyBreakdown {

 String? get date; int? get transactionCount; num? get totalAmount; num? get totalFees; num? get netAmount;
/// Create a copy of DailyBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyBreakdownCopyWith<DailyBreakdown> get copyWith => _$DailyBreakdownCopyWithImpl<DailyBreakdown>(this as DailyBreakdown, _$identity);

  /// Serializes this DailyBreakdown to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyBreakdown&&(identical(other.date, date) || other.date == date)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,transactionCount,totalAmount,totalFees,netAmount);

@override
String toString() {
  return 'DailyBreakdown(date: $date, transactionCount: $transactionCount, totalAmount: $totalAmount, totalFees: $totalFees, netAmount: $netAmount)';
}


}

/// @nodoc
abstract mixin class $DailyBreakdownCopyWith<$Res>  {
  factory $DailyBreakdownCopyWith(DailyBreakdown value, $Res Function(DailyBreakdown) _then) = _$DailyBreakdownCopyWithImpl;
@useResult
$Res call({
 String? date, int? transactionCount, num? totalAmount, num? totalFees, num? netAmount
});




}
/// @nodoc
class _$DailyBreakdownCopyWithImpl<$Res>
    implements $DailyBreakdownCopyWith<$Res> {
  _$DailyBreakdownCopyWithImpl(this._self, this._then);

  final DailyBreakdown _self;
  final $Res Function(DailyBreakdown) _then;

/// Create a copy of DailyBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? transactionCount = freezed,Object? totalAmount = freezed,Object? totalFees = freezed,Object? netAmount = freezed,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num?,totalFees: freezed == totalFees ? _self.totalFees : totalFees // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyBreakdown].
extension DailyBreakdownPatterns on DailyBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _DailyBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _DailyBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? date,  int? transactionCount,  num? totalAmount,  num? totalFees,  num? netAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyBreakdown() when $default != null:
return $default(_that.date,_that.transactionCount,_that.totalAmount,_that.totalFees,_that.netAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? date,  int? transactionCount,  num? totalAmount,  num? totalFees,  num? netAmount)  $default,) {final _that = this;
switch (_that) {
case _DailyBreakdown():
return $default(_that.date,_that.transactionCount,_that.totalAmount,_that.totalFees,_that.netAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? date,  int? transactionCount,  num? totalAmount,  num? totalFees,  num? netAmount)?  $default,) {final _that = this;
switch (_that) {
case _DailyBreakdown() when $default != null:
return $default(_that.date,_that.transactionCount,_that.totalAmount,_that.totalFees,_that.netAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyBreakdown implements DailyBreakdown {
  const _DailyBreakdown({this.date, this.transactionCount, this.totalAmount, this.totalFees, this.netAmount});
  factory _DailyBreakdown.fromJson(Map<String, dynamic> json) => _$DailyBreakdownFromJson(json);

@override final  String? date;
@override final  int? transactionCount;
@override final  num? totalAmount;
@override final  num? totalFees;
@override final  num? netAmount;

/// Create a copy of DailyBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyBreakdownCopyWith<_DailyBreakdown> get copyWith => __$DailyBreakdownCopyWithImpl<_DailyBreakdown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyBreakdownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyBreakdown&&(identical(other.date, date) || other.date == date)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,transactionCount,totalAmount,totalFees,netAmount);

@override
String toString() {
  return 'DailyBreakdown(date: $date, transactionCount: $transactionCount, totalAmount: $totalAmount, totalFees: $totalFees, netAmount: $netAmount)';
}


}

/// @nodoc
abstract mixin class _$DailyBreakdownCopyWith<$Res> implements $DailyBreakdownCopyWith<$Res> {
  factory _$DailyBreakdownCopyWith(_DailyBreakdown value, $Res Function(_DailyBreakdown) _then) = __$DailyBreakdownCopyWithImpl;
@override @useResult
$Res call({
 String? date, int? transactionCount, num? totalAmount, num? totalFees, num? netAmount
});




}
/// @nodoc
class __$DailyBreakdownCopyWithImpl<$Res>
    implements _$DailyBreakdownCopyWith<$Res> {
  __$DailyBreakdownCopyWithImpl(this._self, this._then);

  final _DailyBreakdown _self;
  final $Res Function(_DailyBreakdown) _then;

/// Create a copy of DailyBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? transactionCount = freezed,Object? totalAmount = freezed,Object? totalFees = freezed,Object? netAmount = freezed,}) {
  return _then(_DailyBreakdown(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num?,totalFees: freezed == totalFees ? _self.totalFees : totalFees // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}


/// @nodoc
mixin _$MerchantSalesReportResponse {

 String? get mid; String? get merchantName; String? get businessName; String? get merchantAddress; String? get merchantPhone; String? get merchantEmail; String? get startDate; String? get endDate; String? get reportPeriod; num? get totalSales; int? get totalTransactionCount; num? get totalFees; num? get netAmount; List<CardSchemeSummary> get cardSchemeBreakdown; List<DailyBreakdown> get dailyBreakdown;
/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MerchantSalesReportResponseCopyWith<MerchantSalesReportResponse> get copyWith => _$MerchantSalesReportResponseCopyWithImpl<MerchantSalesReportResponse>(this as MerchantSalesReportResponse, _$identity);

  /// Serializes this MerchantSalesReportResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MerchantSalesReportResponse&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.merchantAddress, merchantAddress) || other.merchantAddress == merchantAddress)&&(identical(other.merchantPhone, merchantPhone) || other.merchantPhone == merchantPhone)&&(identical(other.merchantEmail, merchantEmail) || other.merchantEmail == merchantEmail)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.reportPeriod, reportPeriod) || other.reportPeriod == reportPeriod)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalTransactionCount, totalTransactionCount) || other.totalTransactionCount == totalTransactionCount)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&const DeepCollectionEquality().equals(other.cardSchemeBreakdown, cardSchemeBreakdown)&&const DeepCollectionEquality().equals(other.dailyBreakdown, dailyBreakdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,merchantName,businessName,merchantAddress,merchantPhone,merchantEmail,startDate,endDate,reportPeriod,totalSales,totalTransactionCount,totalFees,netAmount,const DeepCollectionEquality().hash(cardSchemeBreakdown),const DeepCollectionEquality().hash(dailyBreakdown));

@override
String toString() {
  return 'MerchantSalesReportResponse(mid: $mid, merchantName: $merchantName, businessName: $businessName, merchantAddress: $merchantAddress, merchantPhone: $merchantPhone, merchantEmail: $merchantEmail, startDate: $startDate, endDate: $endDate, reportPeriod: $reportPeriod, totalSales: $totalSales, totalTransactionCount: $totalTransactionCount, totalFees: $totalFees, netAmount: $netAmount, cardSchemeBreakdown: $cardSchemeBreakdown, dailyBreakdown: $dailyBreakdown)';
}


}

/// @nodoc
abstract mixin class $MerchantSalesReportResponseCopyWith<$Res>  {
  factory $MerchantSalesReportResponseCopyWith(MerchantSalesReportResponse value, $Res Function(MerchantSalesReportResponse) _then) = _$MerchantSalesReportResponseCopyWithImpl;
@useResult
$Res call({
 String? mid, String? merchantName, String? businessName, String? merchantAddress, String? merchantPhone, String? merchantEmail, String? startDate, String? endDate, String? reportPeriod, num? totalSales, int? totalTransactionCount, num? totalFees, num? netAmount, List<CardSchemeSummary> cardSchemeBreakdown, List<DailyBreakdown> dailyBreakdown
});




}
/// @nodoc
class _$MerchantSalesReportResponseCopyWithImpl<$Res>
    implements $MerchantSalesReportResponseCopyWith<$Res> {
  _$MerchantSalesReportResponseCopyWithImpl(this._self, this._then);

  final MerchantSalesReportResponse _self;
  final $Res Function(MerchantSalesReportResponse) _then;

/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = freezed,Object? merchantName = freezed,Object? businessName = freezed,Object? merchantAddress = freezed,Object? merchantPhone = freezed,Object? merchantEmail = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? reportPeriod = freezed,Object? totalSales = freezed,Object? totalTransactionCount = freezed,Object? totalFees = freezed,Object? netAmount = freezed,Object? cardSchemeBreakdown = null,Object? dailyBreakdown = null,}) {
  return _then(_self.copyWith(
mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,businessName: freezed == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String?,merchantAddress: freezed == merchantAddress ? _self.merchantAddress : merchantAddress // ignore: cast_nullable_to_non_nullable
as String?,merchantPhone: freezed == merchantPhone ? _self.merchantPhone : merchantPhone // ignore: cast_nullable_to_non_nullable
as String?,merchantEmail: freezed == merchantEmail ? _self.merchantEmail : merchantEmail // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,reportPeriod: freezed == reportPeriod ? _self.reportPeriod : reportPeriod // ignore: cast_nullable_to_non_nullable
as String?,totalSales: freezed == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as num?,totalTransactionCount: freezed == totalTransactionCount ? _self.totalTransactionCount : totalTransactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalFees: freezed == totalFees ? _self.totalFees : totalFees // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,cardSchemeBreakdown: null == cardSchemeBreakdown ? _self.cardSchemeBreakdown : cardSchemeBreakdown // ignore: cast_nullable_to_non_nullable
as List<CardSchemeSummary>,dailyBreakdown: null == dailyBreakdown ? _self.dailyBreakdown : dailyBreakdown // ignore: cast_nullable_to_non_nullable
as List<DailyBreakdown>,
  ));
}

}


/// Adds pattern-matching-related methods to [MerchantSalesReportResponse].
extension MerchantSalesReportResponsePatterns on MerchantSalesReportResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MerchantSalesReportResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MerchantSalesReportResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MerchantSalesReportResponse value)  $default,){
final _that = this;
switch (_that) {
case _MerchantSalesReportResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MerchantSalesReportResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MerchantSalesReportResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? mid,  String? merchantName,  String? businessName,  String? merchantAddress,  String? merchantPhone,  String? merchantEmail,  String? startDate,  String? endDate,  String? reportPeriod,  num? totalSales,  int? totalTransactionCount,  num? totalFees,  num? netAmount,  List<CardSchemeSummary> cardSchemeBreakdown,  List<DailyBreakdown> dailyBreakdown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MerchantSalesReportResponse() when $default != null:
return $default(_that.mid,_that.merchantName,_that.businessName,_that.merchantAddress,_that.merchantPhone,_that.merchantEmail,_that.startDate,_that.endDate,_that.reportPeriod,_that.totalSales,_that.totalTransactionCount,_that.totalFees,_that.netAmount,_that.cardSchemeBreakdown,_that.dailyBreakdown);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? mid,  String? merchantName,  String? businessName,  String? merchantAddress,  String? merchantPhone,  String? merchantEmail,  String? startDate,  String? endDate,  String? reportPeriod,  num? totalSales,  int? totalTransactionCount,  num? totalFees,  num? netAmount,  List<CardSchemeSummary> cardSchemeBreakdown,  List<DailyBreakdown> dailyBreakdown)  $default,) {final _that = this;
switch (_that) {
case _MerchantSalesReportResponse():
return $default(_that.mid,_that.merchantName,_that.businessName,_that.merchantAddress,_that.merchantPhone,_that.merchantEmail,_that.startDate,_that.endDate,_that.reportPeriod,_that.totalSales,_that.totalTransactionCount,_that.totalFees,_that.netAmount,_that.cardSchemeBreakdown,_that.dailyBreakdown);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? mid,  String? merchantName,  String? businessName,  String? merchantAddress,  String? merchantPhone,  String? merchantEmail,  String? startDate,  String? endDate,  String? reportPeriod,  num? totalSales,  int? totalTransactionCount,  num? totalFees,  num? netAmount,  List<CardSchemeSummary> cardSchemeBreakdown,  List<DailyBreakdown> dailyBreakdown)?  $default,) {final _that = this;
switch (_that) {
case _MerchantSalesReportResponse() when $default != null:
return $default(_that.mid,_that.merchantName,_that.businessName,_that.merchantAddress,_that.merchantPhone,_that.merchantEmail,_that.startDate,_that.endDate,_that.reportPeriod,_that.totalSales,_that.totalTransactionCount,_that.totalFees,_that.netAmount,_that.cardSchemeBreakdown,_that.dailyBreakdown);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MerchantSalesReportResponse implements MerchantSalesReportResponse {
  const _MerchantSalesReportResponse({this.mid, this.merchantName, this.businessName, this.merchantAddress, this.merchantPhone, this.merchantEmail, this.startDate, this.endDate, this.reportPeriod, this.totalSales, this.totalTransactionCount, this.totalFees, this.netAmount, final  List<CardSchemeSummary> cardSchemeBreakdown = const <CardSchemeSummary>[], final  List<DailyBreakdown> dailyBreakdown = const <DailyBreakdown>[]}): _cardSchemeBreakdown = cardSchemeBreakdown,_dailyBreakdown = dailyBreakdown;
  factory _MerchantSalesReportResponse.fromJson(Map<String, dynamic> json) => _$MerchantSalesReportResponseFromJson(json);

@override final  String? mid;
@override final  String? merchantName;
@override final  String? businessName;
@override final  String? merchantAddress;
@override final  String? merchantPhone;
@override final  String? merchantEmail;
@override final  String? startDate;
@override final  String? endDate;
@override final  String? reportPeriod;
@override final  num? totalSales;
@override final  int? totalTransactionCount;
@override final  num? totalFees;
@override final  num? netAmount;
 final  List<CardSchemeSummary> _cardSchemeBreakdown;
@override@JsonKey() List<CardSchemeSummary> get cardSchemeBreakdown {
  if (_cardSchemeBreakdown is EqualUnmodifiableListView) return _cardSchemeBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cardSchemeBreakdown);
}

 final  List<DailyBreakdown> _dailyBreakdown;
@override@JsonKey() List<DailyBreakdown> get dailyBreakdown {
  if (_dailyBreakdown is EqualUnmodifiableListView) return _dailyBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyBreakdown);
}


/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MerchantSalesReportResponseCopyWith<_MerchantSalesReportResponse> get copyWith => __$MerchantSalesReportResponseCopyWithImpl<_MerchantSalesReportResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MerchantSalesReportResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MerchantSalesReportResponse&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.merchantAddress, merchantAddress) || other.merchantAddress == merchantAddress)&&(identical(other.merchantPhone, merchantPhone) || other.merchantPhone == merchantPhone)&&(identical(other.merchantEmail, merchantEmail) || other.merchantEmail == merchantEmail)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.reportPeriod, reportPeriod) || other.reportPeriod == reportPeriod)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalTransactionCount, totalTransactionCount) || other.totalTransactionCount == totalTransactionCount)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&const DeepCollectionEquality().equals(other._cardSchemeBreakdown, _cardSchemeBreakdown)&&const DeepCollectionEquality().equals(other._dailyBreakdown, _dailyBreakdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,merchantName,businessName,merchantAddress,merchantPhone,merchantEmail,startDate,endDate,reportPeriod,totalSales,totalTransactionCount,totalFees,netAmount,const DeepCollectionEquality().hash(_cardSchemeBreakdown),const DeepCollectionEquality().hash(_dailyBreakdown));

@override
String toString() {
  return 'MerchantSalesReportResponse(mid: $mid, merchantName: $merchantName, businessName: $businessName, merchantAddress: $merchantAddress, merchantPhone: $merchantPhone, merchantEmail: $merchantEmail, startDate: $startDate, endDate: $endDate, reportPeriod: $reportPeriod, totalSales: $totalSales, totalTransactionCount: $totalTransactionCount, totalFees: $totalFees, netAmount: $netAmount, cardSchemeBreakdown: $cardSchemeBreakdown, dailyBreakdown: $dailyBreakdown)';
}


}

/// @nodoc
abstract mixin class _$MerchantSalesReportResponseCopyWith<$Res> implements $MerchantSalesReportResponseCopyWith<$Res> {
  factory _$MerchantSalesReportResponseCopyWith(_MerchantSalesReportResponse value, $Res Function(_MerchantSalesReportResponse) _then) = __$MerchantSalesReportResponseCopyWithImpl;
@override @useResult
$Res call({
 String? mid, String? merchantName, String? businessName, String? merchantAddress, String? merchantPhone, String? merchantEmail, String? startDate, String? endDate, String? reportPeriod, num? totalSales, int? totalTransactionCount, num? totalFees, num? netAmount, List<CardSchemeSummary> cardSchemeBreakdown, List<DailyBreakdown> dailyBreakdown
});




}
/// @nodoc
class __$MerchantSalesReportResponseCopyWithImpl<$Res>
    implements _$MerchantSalesReportResponseCopyWith<$Res> {
  __$MerchantSalesReportResponseCopyWithImpl(this._self, this._then);

  final _MerchantSalesReportResponse _self;
  final $Res Function(_MerchantSalesReportResponse) _then;

/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = freezed,Object? merchantName = freezed,Object? businessName = freezed,Object? merchantAddress = freezed,Object? merchantPhone = freezed,Object? merchantEmail = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? reportPeriod = freezed,Object? totalSales = freezed,Object? totalTransactionCount = freezed,Object? totalFees = freezed,Object? netAmount = freezed,Object? cardSchemeBreakdown = null,Object? dailyBreakdown = null,}) {
  return _then(_MerchantSalesReportResponse(
mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,businessName: freezed == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String?,merchantAddress: freezed == merchantAddress ? _self.merchantAddress : merchantAddress // ignore: cast_nullable_to_non_nullable
as String?,merchantPhone: freezed == merchantPhone ? _self.merchantPhone : merchantPhone // ignore: cast_nullable_to_non_nullable
as String?,merchantEmail: freezed == merchantEmail ? _self.merchantEmail : merchantEmail // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,reportPeriod: freezed == reportPeriod ? _self.reportPeriod : reportPeriod // ignore: cast_nullable_to_non_nullable
as String?,totalSales: freezed == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as num?,totalTransactionCount: freezed == totalTransactionCount ? _self.totalTransactionCount : totalTransactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalFees: freezed == totalFees ? _self.totalFees : totalFees // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,cardSchemeBreakdown: null == cardSchemeBreakdown ? _self._cardSchemeBreakdown : cardSchemeBreakdown // ignore: cast_nullable_to_non_nullable
as List<CardSchemeSummary>,dailyBreakdown: null == dailyBreakdown ? _self._dailyBreakdown : dailyBreakdown // ignore: cast_nullable_to_non_nullable
as List<DailyBreakdown>,
  ));
}


}


/// @nodoc
mixin _$SettlementResponse {

 String? get id; String? get settlementReference; String? get batchReference; String? get mid; String? get merchantName; String? get settlementDate; int? get transactionCount; num? get totalTransactionAmount; num? get totalTransactionFees; num? get grossAmount; num? get settlementFee; num? get netAmount; String? get accountNumber; String? get accountName; String? get bankName; String? get status;
/// Create a copy of SettlementResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementResponseCopyWith<SettlementResponse> get copyWith => _$SettlementResponseCopyWithImpl<SettlementResponse>(this as SettlementResponse, _$identity);

  /// Serializes this SettlementResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.settlementReference, settlementReference) || other.settlementReference == settlementReference)&&(identical(other.batchReference, batchReference) || other.batchReference == batchReference)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.settlementDate, settlementDate) || other.settlementDate == settlementDate)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalTransactionAmount, totalTransactionAmount) || other.totalTransactionAmount == totalTransactionAmount)&&(identical(other.totalTransactionFees, totalTransactionFees) || other.totalTransactionFees == totalTransactionFees)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.settlementFee, settlementFee) || other.settlementFee == settlementFee)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,settlementReference,batchReference,mid,merchantName,settlementDate,transactionCount,totalTransactionAmount,totalTransactionFees,grossAmount,settlementFee,netAmount,accountNumber,accountName,bankName,status);

@override
String toString() {
  return 'SettlementResponse(id: $id, settlementReference: $settlementReference, batchReference: $batchReference, mid: $mid, merchantName: $merchantName, settlementDate: $settlementDate, transactionCount: $transactionCount, totalTransactionAmount: $totalTransactionAmount, totalTransactionFees: $totalTransactionFees, grossAmount: $grossAmount, settlementFee: $settlementFee, netAmount: $netAmount, accountNumber: $accountNumber, accountName: $accountName, bankName: $bankName, status: $status)';
}


}

/// @nodoc
abstract mixin class $SettlementResponseCopyWith<$Res>  {
  factory $SettlementResponseCopyWith(SettlementResponse value, $Res Function(SettlementResponse) _then) = _$SettlementResponseCopyWithImpl;
@useResult
$Res call({
 String? id, String? settlementReference, String? batchReference, String? mid, String? merchantName, String? settlementDate, int? transactionCount, num? totalTransactionAmount, num? totalTransactionFees, num? grossAmount, num? settlementFee, num? netAmount, String? accountNumber, String? accountName, String? bankName, String? status
});




}
/// @nodoc
class _$SettlementResponseCopyWithImpl<$Res>
    implements $SettlementResponseCopyWith<$Res> {
  _$SettlementResponseCopyWithImpl(this._self, this._then);

  final SettlementResponse _self;
  final $Res Function(SettlementResponse) _then;

/// Create a copy of SettlementResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? settlementReference = freezed,Object? batchReference = freezed,Object? mid = freezed,Object? merchantName = freezed,Object? settlementDate = freezed,Object? transactionCount = freezed,Object? totalTransactionAmount = freezed,Object? totalTransactionFees = freezed,Object? grossAmount = freezed,Object? settlementFee = freezed,Object? netAmount = freezed,Object? accountNumber = freezed,Object? accountName = freezed,Object? bankName = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,settlementReference: freezed == settlementReference ? _self.settlementReference : settlementReference // ignore: cast_nullable_to_non_nullable
as String?,batchReference: freezed == batchReference ? _self.batchReference : batchReference // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,settlementDate: freezed == settlementDate ? _self.settlementDate : settlementDate // ignore: cast_nullable_to_non_nullable
as String?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalTransactionAmount: freezed == totalTransactionAmount ? _self.totalTransactionAmount : totalTransactionAmount // ignore: cast_nullable_to_non_nullable
as num?,totalTransactionFees: freezed == totalTransactionFees ? _self.totalTransactionFees : totalTransactionFees // ignore: cast_nullable_to_non_nullable
as num?,grossAmount: freezed == grossAmount ? _self.grossAmount : grossAmount // ignore: cast_nullable_to_non_nullable
as num?,settlementFee: freezed == settlementFee ? _self.settlementFee : settlementFee // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementResponse].
extension SettlementResponsePatterns on SettlementResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementResponse value)  $default,){
final _that = this;
switch (_that) {
case _SettlementResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? settlementReference,  String? batchReference,  String? mid,  String? merchantName,  String? settlementDate,  int? transactionCount,  num? totalTransactionAmount,  num? totalTransactionFees,  num? grossAmount,  num? settlementFee,  num? netAmount,  String? accountNumber,  String? accountName,  String? bankName,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementResponse() when $default != null:
return $default(_that.id,_that.settlementReference,_that.batchReference,_that.mid,_that.merchantName,_that.settlementDate,_that.transactionCount,_that.totalTransactionAmount,_that.totalTransactionFees,_that.grossAmount,_that.settlementFee,_that.netAmount,_that.accountNumber,_that.accountName,_that.bankName,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? settlementReference,  String? batchReference,  String? mid,  String? merchantName,  String? settlementDate,  int? transactionCount,  num? totalTransactionAmount,  num? totalTransactionFees,  num? grossAmount,  num? settlementFee,  num? netAmount,  String? accountNumber,  String? accountName,  String? bankName,  String? status)  $default,) {final _that = this;
switch (_that) {
case _SettlementResponse():
return $default(_that.id,_that.settlementReference,_that.batchReference,_that.mid,_that.merchantName,_that.settlementDate,_that.transactionCount,_that.totalTransactionAmount,_that.totalTransactionFees,_that.grossAmount,_that.settlementFee,_that.netAmount,_that.accountNumber,_that.accountName,_that.bankName,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? settlementReference,  String? batchReference,  String? mid,  String? merchantName,  String? settlementDate,  int? transactionCount,  num? totalTransactionAmount,  num? totalTransactionFees,  num? grossAmount,  num? settlementFee,  num? netAmount,  String? accountNumber,  String? accountName,  String? bankName,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _SettlementResponse() when $default != null:
return $default(_that.id,_that.settlementReference,_that.batchReference,_that.mid,_that.merchantName,_that.settlementDate,_that.transactionCount,_that.totalTransactionAmount,_that.totalTransactionFees,_that.grossAmount,_that.settlementFee,_that.netAmount,_that.accountNumber,_that.accountName,_that.bankName,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementResponse implements SettlementResponse {
  const _SettlementResponse({this.id, this.settlementReference, this.batchReference, this.mid, this.merchantName, this.settlementDate, this.transactionCount, this.totalTransactionAmount, this.totalTransactionFees, this.grossAmount, this.settlementFee, this.netAmount, this.accountNumber, this.accountName, this.bankName, this.status});
  factory _SettlementResponse.fromJson(Map<String, dynamic> json) => _$SettlementResponseFromJson(json);

@override final  String? id;
@override final  String? settlementReference;
@override final  String? batchReference;
@override final  String? mid;
@override final  String? merchantName;
@override final  String? settlementDate;
@override final  int? transactionCount;
@override final  num? totalTransactionAmount;
@override final  num? totalTransactionFees;
@override final  num? grossAmount;
@override final  num? settlementFee;
@override final  num? netAmount;
@override final  String? accountNumber;
@override final  String? accountName;
@override final  String? bankName;
@override final  String? status;

/// Create a copy of SettlementResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementResponseCopyWith<_SettlementResponse> get copyWith => __$SettlementResponseCopyWithImpl<_SettlementResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlementResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.settlementReference, settlementReference) || other.settlementReference == settlementReference)&&(identical(other.batchReference, batchReference) || other.batchReference == batchReference)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.settlementDate, settlementDate) || other.settlementDate == settlementDate)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalTransactionAmount, totalTransactionAmount) || other.totalTransactionAmount == totalTransactionAmount)&&(identical(other.totalTransactionFees, totalTransactionFees) || other.totalTransactionFees == totalTransactionFees)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.settlementFee, settlementFee) || other.settlementFee == settlementFee)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,settlementReference,batchReference,mid,merchantName,settlementDate,transactionCount,totalTransactionAmount,totalTransactionFees,grossAmount,settlementFee,netAmount,accountNumber,accountName,bankName,status);

@override
String toString() {
  return 'SettlementResponse(id: $id, settlementReference: $settlementReference, batchReference: $batchReference, mid: $mid, merchantName: $merchantName, settlementDate: $settlementDate, transactionCount: $transactionCount, totalTransactionAmount: $totalTransactionAmount, totalTransactionFees: $totalTransactionFees, grossAmount: $grossAmount, settlementFee: $settlementFee, netAmount: $netAmount, accountNumber: $accountNumber, accountName: $accountName, bankName: $bankName, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SettlementResponseCopyWith<$Res> implements $SettlementResponseCopyWith<$Res> {
  factory _$SettlementResponseCopyWith(_SettlementResponse value, $Res Function(_SettlementResponse) _then) = __$SettlementResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? settlementReference, String? batchReference, String? mid, String? merchantName, String? settlementDate, int? transactionCount, num? totalTransactionAmount, num? totalTransactionFees, num? grossAmount, num? settlementFee, num? netAmount, String? accountNumber, String? accountName, String? bankName, String? status
});




}
/// @nodoc
class __$SettlementResponseCopyWithImpl<$Res>
    implements _$SettlementResponseCopyWith<$Res> {
  __$SettlementResponseCopyWithImpl(this._self, this._then);

  final _SettlementResponse _self;
  final $Res Function(_SettlementResponse) _then;

/// Create a copy of SettlementResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? settlementReference = freezed,Object? batchReference = freezed,Object? mid = freezed,Object? merchantName = freezed,Object? settlementDate = freezed,Object? transactionCount = freezed,Object? totalTransactionAmount = freezed,Object? totalTransactionFees = freezed,Object? grossAmount = freezed,Object? settlementFee = freezed,Object? netAmount = freezed,Object? accountNumber = freezed,Object? accountName = freezed,Object? bankName = freezed,Object? status = freezed,}) {
  return _then(_SettlementResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,settlementReference: freezed == settlementReference ? _self.settlementReference : settlementReference // ignore: cast_nullable_to_non_nullable
as String?,batchReference: freezed == batchReference ? _self.batchReference : batchReference // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,settlementDate: freezed == settlementDate ? _self.settlementDate : settlementDate // ignore: cast_nullable_to_non_nullable
as String?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalTransactionAmount: freezed == totalTransactionAmount ? _self.totalTransactionAmount : totalTransactionAmount // ignore: cast_nullable_to_non_nullable
as num?,totalTransactionFees: freezed == totalTransactionFees ? _self.totalTransactionFees : totalTransactionFees // ignore: cast_nullable_to_non_nullable
as num?,grossAmount: freezed == grossAmount ? _self.grossAmount : grossAmount // ignore: cast_nullable_to_non_nullable
as num?,settlementFee: freezed == settlementFee ? _self.settlementFee : settlementFee // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PageSettlementResponse {

 List<SettlementResponse> get content; int? get totalElements; int? get totalPages; int? get number; int? get size; bool? get first; bool? get last;
/// Create a copy of PageSettlementResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageSettlementResponseCopyWith<PageSettlementResponse> get copyWith => _$PageSettlementResponseCopyWithImpl<PageSettlementResponse>(this as PageSettlementResponse, _$identity);

  /// Serializes this PageSettlementResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageSettlementResponse&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.number, number) || other.number == number)&&(identical(other.size, size) || other.size == size)&&(identical(other.first, first) || other.first == first)&&(identical(other.last, last) || other.last == last));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(content),totalElements,totalPages,number,size,first,last);

@override
String toString() {
  return 'PageSettlementResponse(content: $content, totalElements: $totalElements, totalPages: $totalPages, number: $number, size: $size, first: $first, last: $last)';
}


}

/// @nodoc
abstract mixin class $PageSettlementResponseCopyWith<$Res>  {
  factory $PageSettlementResponseCopyWith(PageSettlementResponse value, $Res Function(PageSettlementResponse) _then) = _$PageSettlementResponseCopyWithImpl;
@useResult
$Res call({
 List<SettlementResponse> content, int? totalElements, int? totalPages, int? number, int? size, bool? first, bool? last
});




}
/// @nodoc
class _$PageSettlementResponseCopyWithImpl<$Res>
    implements $PageSettlementResponseCopyWith<$Res> {
  _$PageSettlementResponseCopyWithImpl(this._self, this._then);

  final PageSettlementResponse _self;
  final $Res Function(PageSettlementResponse) _then;

/// Create a copy of PageSettlementResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? totalElements = freezed,Object? totalPages = freezed,Object? number = freezed,Object? size = freezed,Object? first = freezed,Object? last = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<SettlementResponse>,totalElements: freezed == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int?,totalPages: freezed == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int?,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,first: freezed == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as bool?,last: freezed == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [PageSettlementResponse].
extension PageSettlementResponsePatterns on PageSettlementResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageSettlementResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageSettlementResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageSettlementResponse value)  $default,){
final _that = this;
switch (_that) {
case _PageSettlementResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageSettlementResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PageSettlementResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SettlementResponse> content,  int? totalElements,  int? totalPages,  int? number,  int? size,  bool? first,  bool? last)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageSettlementResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SettlementResponse> content,  int? totalElements,  int? totalPages,  int? number,  int? size,  bool? first,  bool? last)  $default,) {final _that = this;
switch (_that) {
case _PageSettlementResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SettlementResponse> content,  int? totalElements,  int? totalPages,  int? number,  int? size,  bool? first,  bool? last)?  $default,) {final _that = this;
switch (_that) {
case _PageSettlementResponse() when $default != null:
return $default(_that.content,_that.totalElements,_that.totalPages,_that.number,_that.size,_that.first,_that.last);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageSettlementResponse implements PageSettlementResponse {
  const _PageSettlementResponse({final  List<SettlementResponse> content = const <SettlementResponse>[], this.totalElements, this.totalPages, this.number, this.size, this.first, this.last}): _content = content;
  factory _PageSettlementResponse.fromJson(Map<String, dynamic> json) => _$PageSettlementResponseFromJson(json);

 final  List<SettlementResponse> _content;
@override@JsonKey() List<SettlementResponse> get content {
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

/// Create a copy of PageSettlementResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageSettlementResponseCopyWith<_PageSettlementResponse> get copyWith => __$PageSettlementResponseCopyWithImpl<_PageSettlementResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageSettlementResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageSettlementResponse&&const DeepCollectionEquality().equals(other._content, _content)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.number, number) || other.number == number)&&(identical(other.size, size) || other.size == size)&&(identical(other.first, first) || other.first == first)&&(identical(other.last, last) || other.last == last));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_content),totalElements,totalPages,number,size,first,last);

@override
String toString() {
  return 'PageSettlementResponse(content: $content, totalElements: $totalElements, totalPages: $totalPages, number: $number, size: $size, first: $first, last: $last)';
}


}

/// @nodoc
abstract mixin class _$PageSettlementResponseCopyWith<$Res> implements $PageSettlementResponseCopyWith<$Res> {
  factory _$PageSettlementResponseCopyWith(_PageSettlementResponse value, $Res Function(_PageSettlementResponse) _then) = __$PageSettlementResponseCopyWithImpl;
@override @useResult
$Res call({
 List<SettlementResponse> content, int? totalElements, int? totalPages, int? number, int? size, bool? first, bool? last
});




}
/// @nodoc
class __$PageSettlementResponseCopyWithImpl<$Res>
    implements _$PageSettlementResponseCopyWith<$Res> {
  __$PageSettlementResponseCopyWithImpl(this._self, this._then);

  final _PageSettlementResponse _self;
  final $Res Function(_PageSettlementResponse) _then;

/// Create a copy of PageSettlementResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? totalElements = freezed,Object? totalPages = freezed,Object? number = freezed,Object? size = freezed,Object? first = freezed,Object? last = freezed,}) {
  return _then(_PageSettlementResponse(
content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<SettlementResponse>,totalElements: freezed == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
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
