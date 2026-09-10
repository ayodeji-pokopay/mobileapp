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

 String? get mid; int? get totalSettlements; num? get totalSettledAmount; num? get pendingAmount; int? get todayTransactions; num? get todaySales; num? get yesterdaySales; int? get yesterdayTransactions; num? get monthToDateSales; TodaySettlement? get todaySettlement; int? get activeTerminals; int? get instantTerminals;
/// Create a copy of MerchantSettlementSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MerchantSettlementSummaryCopyWith<MerchantSettlementSummary> get copyWith => _$MerchantSettlementSummaryCopyWithImpl<MerchantSettlementSummary>(this as MerchantSettlementSummary, _$identity);

  /// Serializes this MerchantSettlementSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MerchantSettlementSummary&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.totalSettlements, totalSettlements) || other.totalSettlements == totalSettlements)&&(identical(other.totalSettledAmount, totalSettledAmount) || other.totalSettledAmount == totalSettledAmount)&&(identical(other.pendingAmount, pendingAmount) || other.pendingAmount == pendingAmount)&&(identical(other.todayTransactions, todayTransactions) || other.todayTransactions == todayTransactions)&&(identical(other.todaySales, todaySales) || other.todaySales == todaySales)&&(identical(other.yesterdaySales, yesterdaySales) || other.yesterdaySales == yesterdaySales)&&(identical(other.yesterdayTransactions, yesterdayTransactions) || other.yesterdayTransactions == yesterdayTransactions)&&(identical(other.monthToDateSales, monthToDateSales) || other.monthToDateSales == monthToDateSales)&&(identical(other.todaySettlement, todaySettlement) || other.todaySettlement == todaySettlement)&&(identical(other.activeTerminals, activeTerminals) || other.activeTerminals == activeTerminals)&&(identical(other.instantTerminals, instantTerminals) || other.instantTerminals == instantTerminals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,totalSettlements,totalSettledAmount,pendingAmount,todayTransactions,todaySales,yesterdaySales,yesterdayTransactions,monthToDateSales,todaySettlement,activeTerminals,instantTerminals);

@override
String toString() {
  return 'MerchantSettlementSummary(mid: $mid, totalSettlements: $totalSettlements, totalSettledAmount: $totalSettledAmount, pendingAmount: $pendingAmount, todayTransactions: $todayTransactions, todaySales: $todaySales, yesterdaySales: $yesterdaySales, yesterdayTransactions: $yesterdayTransactions, monthToDateSales: $monthToDateSales, todaySettlement: $todaySettlement, activeTerminals: $activeTerminals, instantTerminals: $instantTerminals)';
}


}

/// @nodoc
abstract mixin class $MerchantSettlementSummaryCopyWith<$Res>  {
  factory $MerchantSettlementSummaryCopyWith(MerchantSettlementSummary value, $Res Function(MerchantSettlementSummary) _then) = _$MerchantSettlementSummaryCopyWithImpl;
@useResult
$Res call({
 String? mid, int? totalSettlements, num? totalSettledAmount, num? pendingAmount, int? todayTransactions, num? todaySales, num? yesterdaySales, int? yesterdayTransactions, num? monthToDateSales, TodaySettlement? todaySettlement, int? activeTerminals, int? instantTerminals
});


$TodaySettlementCopyWith<$Res>? get todaySettlement;

}
/// @nodoc
class _$MerchantSettlementSummaryCopyWithImpl<$Res>
    implements $MerchantSettlementSummaryCopyWith<$Res> {
  _$MerchantSettlementSummaryCopyWithImpl(this._self, this._then);

  final MerchantSettlementSummary _self;
  final $Res Function(MerchantSettlementSummary) _then;

/// Create a copy of MerchantSettlementSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = freezed,Object? totalSettlements = freezed,Object? totalSettledAmount = freezed,Object? pendingAmount = freezed,Object? todayTransactions = freezed,Object? todaySales = freezed,Object? yesterdaySales = freezed,Object? yesterdayTransactions = freezed,Object? monthToDateSales = freezed,Object? todaySettlement = freezed,Object? activeTerminals = freezed,Object? instantTerminals = freezed,}) {
  return _then(_self.copyWith(
mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,totalSettlements: freezed == totalSettlements ? _self.totalSettlements : totalSettlements // ignore: cast_nullable_to_non_nullable
as int?,totalSettledAmount: freezed == totalSettledAmount ? _self.totalSettledAmount : totalSettledAmount // ignore: cast_nullable_to_non_nullable
as num?,pendingAmount: freezed == pendingAmount ? _self.pendingAmount : pendingAmount // ignore: cast_nullable_to_non_nullable
as num?,todayTransactions: freezed == todayTransactions ? _self.todayTransactions : todayTransactions // ignore: cast_nullable_to_non_nullable
as int?,todaySales: freezed == todaySales ? _self.todaySales : todaySales // ignore: cast_nullable_to_non_nullable
as num?,yesterdaySales: freezed == yesterdaySales ? _self.yesterdaySales : yesterdaySales // ignore: cast_nullable_to_non_nullable
as num?,yesterdayTransactions: freezed == yesterdayTransactions ? _self.yesterdayTransactions : yesterdayTransactions // ignore: cast_nullable_to_non_nullable
as int?,monthToDateSales: freezed == monthToDateSales ? _self.monthToDateSales : monthToDateSales // ignore: cast_nullable_to_non_nullable
as num?,todaySettlement: freezed == todaySettlement ? _self.todaySettlement : todaySettlement // ignore: cast_nullable_to_non_nullable
as TodaySettlement?,activeTerminals: freezed == activeTerminals ? _self.activeTerminals : activeTerminals // ignore: cast_nullable_to_non_nullable
as int?,instantTerminals: freezed == instantTerminals ? _self.instantTerminals : instantTerminals // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of MerchantSettlementSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodaySettlementCopyWith<$Res>? get todaySettlement {
    if (_self.todaySettlement == null) {
    return null;
  }

  return $TodaySettlementCopyWith<$Res>(_self.todaySettlement!, (value) {
    return _then(_self.copyWith(todaySettlement: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? mid,  int? totalSettlements,  num? totalSettledAmount,  num? pendingAmount,  int? todayTransactions,  num? todaySales,  num? yesterdaySales,  int? yesterdayTransactions,  num? monthToDateSales,  TodaySettlement? todaySettlement,  int? activeTerminals,  int? instantTerminals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MerchantSettlementSummary() when $default != null:
return $default(_that.mid,_that.totalSettlements,_that.totalSettledAmount,_that.pendingAmount,_that.todayTransactions,_that.todaySales,_that.yesterdaySales,_that.yesterdayTransactions,_that.monthToDateSales,_that.todaySettlement,_that.activeTerminals,_that.instantTerminals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? mid,  int? totalSettlements,  num? totalSettledAmount,  num? pendingAmount,  int? todayTransactions,  num? todaySales,  num? yesterdaySales,  int? yesterdayTransactions,  num? monthToDateSales,  TodaySettlement? todaySettlement,  int? activeTerminals,  int? instantTerminals)  $default,) {final _that = this;
switch (_that) {
case _MerchantSettlementSummary():
return $default(_that.mid,_that.totalSettlements,_that.totalSettledAmount,_that.pendingAmount,_that.todayTransactions,_that.todaySales,_that.yesterdaySales,_that.yesterdayTransactions,_that.monthToDateSales,_that.todaySettlement,_that.activeTerminals,_that.instantTerminals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? mid,  int? totalSettlements,  num? totalSettledAmount,  num? pendingAmount,  int? todayTransactions,  num? todaySales,  num? yesterdaySales,  int? yesterdayTransactions,  num? monthToDateSales,  TodaySettlement? todaySettlement,  int? activeTerminals,  int? instantTerminals)?  $default,) {final _that = this;
switch (_that) {
case _MerchantSettlementSummary() when $default != null:
return $default(_that.mid,_that.totalSettlements,_that.totalSettledAmount,_that.pendingAmount,_that.todayTransactions,_that.todaySales,_that.yesterdaySales,_that.yesterdayTransactions,_that.monthToDateSales,_that.todaySettlement,_that.activeTerminals,_that.instantTerminals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MerchantSettlementSummary implements MerchantSettlementSummary {
  const _MerchantSettlementSummary({this.mid, this.totalSettlements, this.totalSettledAmount, this.pendingAmount, this.todayTransactions, this.todaySales, this.yesterdaySales, this.yesterdayTransactions, this.monthToDateSales, this.todaySettlement, this.activeTerminals, this.instantTerminals});
  factory _MerchantSettlementSummary.fromJson(Map<String, dynamic> json) => _$MerchantSettlementSummaryFromJson(json);

@override final  String? mid;
@override final  int? totalSettlements;
@override final  num? totalSettledAmount;
@override final  num? pendingAmount;
@override final  int? todayTransactions;
@override final  num? todaySales;
@override final  num? yesterdaySales;
@override final  int? yesterdayTransactions;
@override final  num? monthToDateSales;
@override final  TodaySettlement? todaySettlement;
@override final  int? activeTerminals;
@override final  int? instantTerminals;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MerchantSettlementSummary&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.totalSettlements, totalSettlements) || other.totalSettlements == totalSettlements)&&(identical(other.totalSettledAmount, totalSettledAmount) || other.totalSettledAmount == totalSettledAmount)&&(identical(other.pendingAmount, pendingAmount) || other.pendingAmount == pendingAmount)&&(identical(other.todayTransactions, todayTransactions) || other.todayTransactions == todayTransactions)&&(identical(other.todaySales, todaySales) || other.todaySales == todaySales)&&(identical(other.yesterdaySales, yesterdaySales) || other.yesterdaySales == yesterdaySales)&&(identical(other.yesterdayTransactions, yesterdayTransactions) || other.yesterdayTransactions == yesterdayTransactions)&&(identical(other.monthToDateSales, monthToDateSales) || other.monthToDateSales == monthToDateSales)&&(identical(other.todaySettlement, todaySettlement) || other.todaySettlement == todaySettlement)&&(identical(other.activeTerminals, activeTerminals) || other.activeTerminals == activeTerminals)&&(identical(other.instantTerminals, instantTerminals) || other.instantTerminals == instantTerminals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mid,totalSettlements,totalSettledAmount,pendingAmount,todayTransactions,todaySales,yesterdaySales,yesterdayTransactions,monthToDateSales,todaySettlement,activeTerminals,instantTerminals);

@override
String toString() {
  return 'MerchantSettlementSummary(mid: $mid, totalSettlements: $totalSettlements, totalSettledAmount: $totalSettledAmount, pendingAmount: $pendingAmount, todayTransactions: $todayTransactions, todaySales: $todaySales, yesterdaySales: $yesterdaySales, yesterdayTransactions: $yesterdayTransactions, monthToDateSales: $monthToDateSales, todaySettlement: $todaySettlement, activeTerminals: $activeTerminals, instantTerminals: $instantTerminals)';
}


}

/// @nodoc
abstract mixin class _$MerchantSettlementSummaryCopyWith<$Res> implements $MerchantSettlementSummaryCopyWith<$Res> {
  factory _$MerchantSettlementSummaryCopyWith(_MerchantSettlementSummary value, $Res Function(_MerchantSettlementSummary) _then) = __$MerchantSettlementSummaryCopyWithImpl;
@override @useResult
$Res call({
 String? mid, int? totalSettlements, num? totalSettledAmount, num? pendingAmount, int? todayTransactions, num? todaySales, num? yesterdaySales, int? yesterdayTransactions, num? monthToDateSales, TodaySettlement? todaySettlement, int? activeTerminals, int? instantTerminals
});


@override $TodaySettlementCopyWith<$Res>? get todaySettlement;

}
/// @nodoc
class __$MerchantSettlementSummaryCopyWithImpl<$Res>
    implements _$MerchantSettlementSummaryCopyWith<$Res> {
  __$MerchantSettlementSummaryCopyWithImpl(this._self, this._then);

  final _MerchantSettlementSummary _self;
  final $Res Function(_MerchantSettlementSummary) _then;

/// Create a copy of MerchantSettlementSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = freezed,Object? totalSettlements = freezed,Object? totalSettledAmount = freezed,Object? pendingAmount = freezed,Object? todayTransactions = freezed,Object? todaySales = freezed,Object? yesterdaySales = freezed,Object? yesterdayTransactions = freezed,Object? monthToDateSales = freezed,Object? todaySettlement = freezed,Object? activeTerminals = freezed,Object? instantTerminals = freezed,}) {
  return _then(_MerchantSettlementSummary(
mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,totalSettlements: freezed == totalSettlements ? _self.totalSettlements : totalSettlements // ignore: cast_nullable_to_non_nullable
as int?,totalSettledAmount: freezed == totalSettledAmount ? _self.totalSettledAmount : totalSettledAmount // ignore: cast_nullable_to_non_nullable
as num?,pendingAmount: freezed == pendingAmount ? _self.pendingAmount : pendingAmount // ignore: cast_nullable_to_non_nullable
as num?,todayTransactions: freezed == todayTransactions ? _self.todayTransactions : todayTransactions // ignore: cast_nullable_to_non_nullable
as int?,todaySales: freezed == todaySales ? _self.todaySales : todaySales // ignore: cast_nullable_to_non_nullable
as num?,yesterdaySales: freezed == yesterdaySales ? _self.yesterdaySales : yesterdaySales // ignore: cast_nullable_to_non_nullable
as num?,yesterdayTransactions: freezed == yesterdayTransactions ? _self.yesterdayTransactions : yesterdayTransactions // ignore: cast_nullable_to_non_nullable
as int?,monthToDateSales: freezed == monthToDateSales ? _self.monthToDateSales : monthToDateSales // ignore: cast_nullable_to_non_nullable
as num?,todaySettlement: freezed == todaySettlement ? _self.todaySettlement : todaySettlement // ignore: cast_nullable_to_non_nullable
as TodaySettlement?,activeTerminals: freezed == activeTerminals ? _self.activeTerminals : activeTerminals // ignore: cast_nullable_to_non_nullable
as int?,instantTerminals: freezed == instantTerminals ? _self.instantTerminals : instantTerminals // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of MerchantSettlementSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodaySettlementCopyWith<$Res>? get todaySettlement {
    if (_self.todaySettlement == null) {
    return null;
  }

  return $TodaySettlementCopyWith<$Res>(_self.todaySettlement!, (value) {
    return _then(_self.copyWith(todaySettlement: value));
  });
}
}


/// @nodoc
mixin _$TodaySettlement {

 num? get amount; String? get status; String? get expectedDate;
/// Create a copy of TodaySettlement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodaySettlementCopyWith<TodaySettlement> get copyWith => _$TodaySettlementCopyWithImpl<TodaySettlement>(this as TodaySettlement, _$identity);

  /// Serializes this TodaySettlement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodaySettlement&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.expectedDate, expectedDate) || other.expectedDate == expectedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,status,expectedDate);

@override
String toString() {
  return 'TodaySettlement(amount: $amount, status: $status, expectedDate: $expectedDate)';
}


}

/// @nodoc
abstract mixin class $TodaySettlementCopyWith<$Res>  {
  factory $TodaySettlementCopyWith(TodaySettlement value, $Res Function(TodaySettlement) _then) = _$TodaySettlementCopyWithImpl;
@useResult
$Res call({
 num? amount, String? status, String? expectedDate
});




}
/// @nodoc
class _$TodaySettlementCopyWithImpl<$Res>
    implements $TodaySettlementCopyWith<$Res> {
  _$TodaySettlementCopyWithImpl(this._self, this._then);

  final TodaySettlement _self;
  final $Res Function(TodaySettlement) _then;

/// Create a copy of TodaySettlement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = freezed,Object? status = freezed,Object? expectedDate = freezed,}) {
  return _then(_self.copyWith(
amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,expectedDate: freezed == expectedDate ? _self.expectedDate : expectedDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodaySettlement].
extension TodaySettlementPatterns on TodaySettlement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodaySettlement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodaySettlement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodaySettlement value)  $default,){
final _that = this;
switch (_that) {
case _TodaySettlement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodaySettlement value)?  $default,){
final _that = this;
switch (_that) {
case _TodaySettlement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num? amount,  String? status,  String? expectedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodaySettlement() when $default != null:
return $default(_that.amount,_that.status,_that.expectedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num? amount,  String? status,  String? expectedDate)  $default,) {final _that = this;
switch (_that) {
case _TodaySettlement():
return $default(_that.amount,_that.status,_that.expectedDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num? amount,  String? status,  String? expectedDate)?  $default,) {final _that = this;
switch (_that) {
case _TodaySettlement() when $default != null:
return $default(_that.amount,_that.status,_that.expectedDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodaySettlement implements TodaySettlement {
  const _TodaySettlement({this.amount, this.status, this.expectedDate});
  factory _TodaySettlement.fromJson(Map<String, dynamic> json) => _$TodaySettlementFromJson(json);

@override final  num? amount;
@override final  String? status;
@override final  String? expectedDate;

/// Create a copy of TodaySettlement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodaySettlementCopyWith<_TodaySettlement> get copyWith => __$TodaySettlementCopyWithImpl<_TodaySettlement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodaySettlementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodaySettlement&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.expectedDate, expectedDate) || other.expectedDate == expectedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,status,expectedDate);

@override
String toString() {
  return 'TodaySettlement(amount: $amount, status: $status, expectedDate: $expectedDate)';
}


}

/// @nodoc
abstract mixin class _$TodaySettlementCopyWith<$Res> implements $TodaySettlementCopyWith<$Res> {
  factory _$TodaySettlementCopyWith(_TodaySettlement value, $Res Function(_TodaySettlement) _then) = __$TodaySettlementCopyWithImpl;
@override @useResult
$Res call({
 num? amount, String? status, String? expectedDate
});




}
/// @nodoc
class __$TodaySettlementCopyWithImpl<$Res>
    implements _$TodaySettlementCopyWith<$Res> {
  __$TodaySettlementCopyWithImpl(this._self, this._then);

  final _TodaySettlement _self;
  final $Res Function(_TodaySettlement) _then;

/// Create a copy of TodaySettlement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = freezed,Object? status = freezed,Object? expectedDate = freezed,}) {
  return _then(_TodaySettlement(
amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,expectedDate: freezed == expectedDate ? _self.expectedDate : expectedDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PeriodTotals {

 String? get startDate; String? get endDate; num? get totalSales; int? get totalTransactionCount; num? get totalFees; num? get netAmount;
/// Create a copy of PeriodTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodTotalsCopyWith<PeriodTotals> get copyWith => _$PeriodTotalsCopyWithImpl<PeriodTotals>(this as PeriodTotals, _$identity);

  /// Serializes this PeriodTotals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodTotals&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalTransactionCount, totalTransactionCount) || other.totalTransactionCount == totalTransactionCount)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,totalSales,totalTransactionCount,totalFees,netAmount);

@override
String toString() {
  return 'PeriodTotals(startDate: $startDate, endDate: $endDate, totalSales: $totalSales, totalTransactionCount: $totalTransactionCount, totalFees: $totalFees, netAmount: $netAmount)';
}


}

/// @nodoc
abstract mixin class $PeriodTotalsCopyWith<$Res>  {
  factory $PeriodTotalsCopyWith(PeriodTotals value, $Res Function(PeriodTotals) _then) = _$PeriodTotalsCopyWithImpl;
@useResult
$Res call({
 String? startDate, String? endDate, num? totalSales, int? totalTransactionCount, num? totalFees, num? netAmount
});




}
/// @nodoc
class _$PeriodTotalsCopyWithImpl<$Res>
    implements $PeriodTotalsCopyWith<$Res> {
  _$PeriodTotalsCopyWithImpl(this._self, this._then);

  final PeriodTotals _self;
  final $Res Function(PeriodTotals) _then;

/// Create a copy of PeriodTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startDate = freezed,Object? endDate = freezed,Object? totalSales = freezed,Object? totalTransactionCount = freezed,Object? totalFees = freezed,Object? netAmount = freezed,}) {
  return _then(_self.copyWith(
startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,totalSales: freezed == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as num?,totalTransactionCount: freezed == totalTransactionCount ? _self.totalTransactionCount : totalTransactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalFees: freezed == totalFees ? _self.totalFees : totalFees // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodTotals].
extension PeriodTotalsPatterns on PeriodTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodTotals value)  $default,){
final _that = this;
switch (_that) {
case _PeriodTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodTotals value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? startDate,  String? endDate,  num? totalSales,  int? totalTransactionCount,  num? totalFees,  num? netAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodTotals() when $default != null:
return $default(_that.startDate,_that.endDate,_that.totalSales,_that.totalTransactionCount,_that.totalFees,_that.netAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? startDate,  String? endDate,  num? totalSales,  int? totalTransactionCount,  num? totalFees,  num? netAmount)  $default,) {final _that = this;
switch (_that) {
case _PeriodTotals():
return $default(_that.startDate,_that.endDate,_that.totalSales,_that.totalTransactionCount,_that.totalFees,_that.netAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? startDate,  String? endDate,  num? totalSales,  int? totalTransactionCount,  num? totalFees,  num? netAmount)?  $default,) {final _that = this;
switch (_that) {
case _PeriodTotals() when $default != null:
return $default(_that.startDate,_that.endDate,_that.totalSales,_that.totalTransactionCount,_that.totalFees,_that.netAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PeriodTotals implements PeriodTotals {
  const _PeriodTotals({this.startDate, this.endDate, this.totalSales, this.totalTransactionCount, this.totalFees, this.netAmount});
  factory _PeriodTotals.fromJson(Map<String, dynamic> json) => _$PeriodTotalsFromJson(json);

@override final  String? startDate;
@override final  String? endDate;
@override final  num? totalSales;
@override final  int? totalTransactionCount;
@override final  num? totalFees;
@override final  num? netAmount;

/// Create a copy of PeriodTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodTotalsCopyWith<_PeriodTotals> get copyWith => __$PeriodTotalsCopyWithImpl<_PeriodTotals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeriodTotalsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodTotals&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalTransactionCount, totalTransactionCount) || other.totalTransactionCount == totalTransactionCount)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,totalSales,totalTransactionCount,totalFees,netAmount);

@override
String toString() {
  return 'PeriodTotals(startDate: $startDate, endDate: $endDate, totalSales: $totalSales, totalTransactionCount: $totalTransactionCount, totalFees: $totalFees, netAmount: $netAmount)';
}


}

/// @nodoc
abstract mixin class _$PeriodTotalsCopyWith<$Res> implements $PeriodTotalsCopyWith<$Res> {
  factory _$PeriodTotalsCopyWith(_PeriodTotals value, $Res Function(_PeriodTotals) _then) = __$PeriodTotalsCopyWithImpl;
@override @useResult
$Res call({
 String? startDate, String? endDate, num? totalSales, int? totalTransactionCount, num? totalFees, num? netAmount
});




}
/// @nodoc
class __$PeriodTotalsCopyWithImpl<$Res>
    implements _$PeriodTotalsCopyWith<$Res> {
  __$PeriodTotalsCopyWithImpl(this._self, this._then);

  final _PeriodTotals _self;
  final $Res Function(_PeriodTotals) _then;

/// Create a copy of PeriodTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startDate = freezed,Object? endDate = freezed,Object? totalSales = freezed,Object? totalTransactionCount = freezed,Object? totalFees = freezed,Object? netAmount = freezed,}) {
  return _then(_PeriodTotals(
startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,totalSales: freezed == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as num?,totalTransactionCount: freezed == totalTransactionCount ? _self.totalTransactionCount : totalTransactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalFees: freezed == totalFees ? _self.totalFees : totalFees // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}


/// @nodoc
mixin _$ChannelSummary {

 String? get channel; num? get totalAmount; int? get transactionCount;
/// Create a copy of ChannelSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChannelSummaryCopyWith<ChannelSummary> get copyWith => _$ChannelSummaryCopyWithImpl<ChannelSummary>(this as ChannelSummary, _$identity);

  /// Serializes this ChannelSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChannelSummary&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,channel,totalAmount,transactionCount);

@override
String toString() {
  return 'ChannelSummary(channel: $channel, totalAmount: $totalAmount, transactionCount: $transactionCount)';
}


}

/// @nodoc
abstract mixin class $ChannelSummaryCopyWith<$Res>  {
  factory $ChannelSummaryCopyWith(ChannelSummary value, $Res Function(ChannelSummary) _then) = _$ChannelSummaryCopyWithImpl;
@useResult
$Res call({
 String? channel, num? totalAmount, int? transactionCount
});




}
/// @nodoc
class _$ChannelSummaryCopyWithImpl<$Res>
    implements $ChannelSummaryCopyWith<$Res> {
  _$ChannelSummaryCopyWithImpl(this._self, this._then);

  final ChannelSummary _self;
  final $Res Function(ChannelSummary) _then;

/// Create a copy of ChannelSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? channel = freezed,Object? totalAmount = freezed,Object? transactionCount = freezed,}) {
  return _then(_self.copyWith(
channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChannelSummary].
extension ChannelSummaryPatterns on ChannelSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChannelSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChannelSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChannelSummary value)  $default,){
final _that = this;
switch (_that) {
case _ChannelSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChannelSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ChannelSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? channel,  num? totalAmount,  int? transactionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChannelSummary() when $default != null:
return $default(_that.channel,_that.totalAmount,_that.transactionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? channel,  num? totalAmount,  int? transactionCount)  $default,) {final _that = this;
switch (_that) {
case _ChannelSummary():
return $default(_that.channel,_that.totalAmount,_that.transactionCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? channel,  num? totalAmount,  int? transactionCount)?  $default,) {final _that = this;
switch (_that) {
case _ChannelSummary() when $default != null:
return $default(_that.channel,_that.totalAmount,_that.transactionCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChannelSummary implements ChannelSummary {
  const _ChannelSummary({this.channel, this.totalAmount, this.transactionCount});
  factory _ChannelSummary.fromJson(Map<String, dynamic> json) => _$ChannelSummaryFromJson(json);

@override final  String? channel;
@override final  num? totalAmount;
@override final  int? transactionCount;

/// Create a copy of ChannelSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChannelSummaryCopyWith<_ChannelSummary> get copyWith => __$ChannelSummaryCopyWithImpl<_ChannelSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChannelSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChannelSummary&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,channel,totalAmount,transactionCount);

@override
String toString() {
  return 'ChannelSummary(channel: $channel, totalAmount: $totalAmount, transactionCount: $transactionCount)';
}


}

/// @nodoc
abstract mixin class _$ChannelSummaryCopyWith<$Res> implements $ChannelSummaryCopyWith<$Res> {
  factory _$ChannelSummaryCopyWith(_ChannelSummary value, $Res Function(_ChannelSummary) _then) = __$ChannelSummaryCopyWithImpl;
@override @useResult
$Res call({
 String? channel, num? totalAmount, int? transactionCount
});




}
/// @nodoc
class __$ChannelSummaryCopyWithImpl<$Res>
    implements _$ChannelSummaryCopyWith<$Res> {
  __$ChannelSummaryCopyWithImpl(this._self, this._then);

  final _ChannelSummary _self;
  final $Res Function(_ChannelSummary) _then;

/// Create a copy of ChannelSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? channel = freezed,Object? totalAmount = freezed,Object? transactionCount = freezed,}) {
  return _then(_ChannelSummary(
channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TerminalSummary {

 String? get tid; String? get terminalLocation; num? get totalSales; int? get transactionCount; num? get fees;
/// Create a copy of TerminalSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TerminalSummaryCopyWith<TerminalSummary> get copyWith => _$TerminalSummaryCopyWithImpl<TerminalSummary>(this as TerminalSummary, _$identity);

  /// Serializes this TerminalSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TerminalSummary&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.terminalLocation, terminalLocation) || other.terminalLocation == terminalLocation)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.fees, fees) || other.fees == fees));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tid,terminalLocation,totalSales,transactionCount,fees);

@override
String toString() {
  return 'TerminalSummary(tid: $tid, terminalLocation: $terminalLocation, totalSales: $totalSales, transactionCount: $transactionCount, fees: $fees)';
}


}

/// @nodoc
abstract mixin class $TerminalSummaryCopyWith<$Res>  {
  factory $TerminalSummaryCopyWith(TerminalSummary value, $Res Function(TerminalSummary) _then) = _$TerminalSummaryCopyWithImpl;
@useResult
$Res call({
 String? tid, String? terminalLocation, num? totalSales, int? transactionCount, num? fees
});




}
/// @nodoc
class _$TerminalSummaryCopyWithImpl<$Res>
    implements $TerminalSummaryCopyWith<$Res> {
  _$TerminalSummaryCopyWithImpl(this._self, this._then);

  final TerminalSummary _self;
  final $Res Function(TerminalSummary) _then;

/// Create a copy of TerminalSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tid = freezed,Object? terminalLocation = freezed,Object? totalSales = freezed,Object? transactionCount = freezed,Object? fees = freezed,}) {
  return _then(_self.copyWith(
tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,terminalLocation: freezed == terminalLocation ? _self.terminalLocation : terminalLocation // ignore: cast_nullable_to_non_nullable
as String?,totalSales: freezed == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as num?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,fees: freezed == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [TerminalSummary].
extension TerminalSummaryPatterns on TerminalSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TerminalSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TerminalSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TerminalSummary value)  $default,){
final _that = this;
switch (_that) {
case _TerminalSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TerminalSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TerminalSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? tid,  String? terminalLocation,  num? totalSales,  int? transactionCount,  num? fees)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TerminalSummary() when $default != null:
return $default(_that.tid,_that.terminalLocation,_that.totalSales,_that.transactionCount,_that.fees);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? tid,  String? terminalLocation,  num? totalSales,  int? transactionCount,  num? fees)  $default,) {final _that = this;
switch (_that) {
case _TerminalSummary():
return $default(_that.tid,_that.terminalLocation,_that.totalSales,_that.transactionCount,_that.fees);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? tid,  String? terminalLocation,  num? totalSales,  int? transactionCount,  num? fees)?  $default,) {final _that = this;
switch (_that) {
case _TerminalSummary() when $default != null:
return $default(_that.tid,_that.terminalLocation,_that.totalSales,_that.transactionCount,_that.fees);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TerminalSummary implements TerminalSummary {
  const _TerminalSummary({this.tid, this.terminalLocation, this.totalSales, this.transactionCount, this.fees});
  factory _TerminalSummary.fromJson(Map<String, dynamic> json) => _$TerminalSummaryFromJson(json);

@override final  String? tid;
@override final  String? terminalLocation;
@override final  num? totalSales;
@override final  int? transactionCount;
@override final  num? fees;

/// Create a copy of TerminalSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TerminalSummaryCopyWith<_TerminalSummary> get copyWith => __$TerminalSummaryCopyWithImpl<_TerminalSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TerminalSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TerminalSummary&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.terminalLocation, terminalLocation) || other.terminalLocation == terminalLocation)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.fees, fees) || other.fees == fees));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tid,terminalLocation,totalSales,transactionCount,fees);

@override
String toString() {
  return 'TerminalSummary(tid: $tid, terminalLocation: $terminalLocation, totalSales: $totalSales, transactionCount: $transactionCount, fees: $fees)';
}


}

/// @nodoc
abstract mixin class _$TerminalSummaryCopyWith<$Res> implements $TerminalSummaryCopyWith<$Res> {
  factory _$TerminalSummaryCopyWith(_TerminalSummary value, $Res Function(_TerminalSummary) _then) = __$TerminalSummaryCopyWithImpl;
@override @useResult
$Res call({
 String? tid, String? terminalLocation, num? totalSales, int? transactionCount, num? fees
});




}
/// @nodoc
class __$TerminalSummaryCopyWithImpl<$Res>
    implements _$TerminalSummaryCopyWith<$Res> {
  __$TerminalSummaryCopyWithImpl(this._self, this._then);

  final _TerminalSummary _self;
  final $Res Function(_TerminalSummary) _then;

/// Create a copy of TerminalSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tid = freezed,Object? terminalLocation = freezed,Object? totalSales = freezed,Object? transactionCount = freezed,Object? fees = freezed,}) {
  return _then(_TerminalSummary(
tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,terminalLocation: freezed == terminalLocation ? _self.terminalLocation : terminalLocation // ignore: cast_nullable_to_non_nullable
as String?,totalSales: freezed == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as num?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,fees: freezed == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}


/// @nodoc
mixin _$CountAmount {

 int? get count; num? get amount;
/// Create a copy of CountAmount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountAmountCopyWith<CountAmount> get copyWith => _$CountAmountCopyWithImpl<CountAmount>(this as CountAmount, _$identity);

  /// Serializes this CountAmount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CountAmount&&(identical(other.count, count) || other.count == count)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,amount);

@override
String toString() {
  return 'CountAmount(count: $count, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $CountAmountCopyWith<$Res>  {
  factory $CountAmountCopyWith(CountAmount value, $Res Function(CountAmount) _then) = _$CountAmountCopyWithImpl;
@useResult
$Res call({
 int? count, num? amount
});




}
/// @nodoc
class _$CountAmountCopyWithImpl<$Res>
    implements $CountAmountCopyWith<$Res> {
  _$CountAmountCopyWithImpl(this._self, this._then);

  final CountAmount _self;
  final $Res Function(CountAmount) _then;

/// Create a copy of CountAmount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = freezed,Object? amount = freezed,}) {
  return _then(_self.copyWith(
count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [CountAmount].
extension CountAmountPatterns on CountAmount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CountAmount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CountAmount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CountAmount value)  $default,){
final _that = this;
switch (_that) {
case _CountAmount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CountAmount value)?  $default,){
final _that = this;
switch (_that) {
case _CountAmount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? count,  num? amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CountAmount() when $default != null:
return $default(_that.count,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? count,  num? amount)  $default,) {final _that = this;
switch (_that) {
case _CountAmount():
return $default(_that.count,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? count,  num? amount)?  $default,) {final _that = this;
switch (_that) {
case _CountAmount() when $default != null:
return $default(_that.count,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CountAmount implements CountAmount {
  const _CountAmount({this.count, this.amount});
  factory _CountAmount.fromJson(Map<String, dynamic> json) => _$CountAmountFromJson(json);

@override final  int? count;
@override final  num? amount;

/// Create a copy of CountAmount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountAmountCopyWith<_CountAmount> get copyWith => __$CountAmountCopyWithImpl<_CountAmount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountAmountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountAmount&&(identical(other.count, count) || other.count == count)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,amount);

@override
String toString() {
  return 'CountAmount(count: $count, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$CountAmountCopyWith<$Res> implements $CountAmountCopyWith<$Res> {
  factory _$CountAmountCopyWith(_CountAmount value, $Res Function(_CountAmount) _then) = __$CountAmountCopyWithImpl;
@override @useResult
$Res call({
 int? count, num? amount
});




}
/// @nodoc
class __$CountAmountCopyWithImpl<$Res>
    implements _$CountAmountCopyWith<$Res> {
  __$CountAmountCopyWithImpl(this._self, this._then);

  final _CountAmount _self;
  final $Res Function(_CountAmount) _then;

/// Create a copy of CountAmount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = freezed,Object? amount = freezed,}) {
  return _then(_CountAmount(
count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}


/// @nodoc
mixin _$CardSchemeSummary {

 String? get cardScheme; int? get transactionCount; num? get totalAmount; num? get totalSales; num? get totalFees; num? get fees; num? get netAmount; num? get averageTransactionValue;
/// Create a copy of CardSchemeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardSchemeSummaryCopyWith<CardSchemeSummary> get copyWith => _$CardSchemeSummaryCopyWithImpl<CardSchemeSummary>(this as CardSchemeSummary, _$identity);

  /// Serializes this CardSchemeSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardSchemeSummary&&(identical(other.cardScheme, cardScheme) || other.cardScheme == cardScheme)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.fees, fees) || other.fees == fees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.averageTransactionValue, averageTransactionValue) || other.averageTransactionValue == averageTransactionValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardScheme,transactionCount,totalAmount,totalSales,totalFees,fees,netAmount,averageTransactionValue);

@override
String toString() {
  return 'CardSchemeSummary(cardScheme: $cardScheme, transactionCount: $transactionCount, totalAmount: $totalAmount, totalSales: $totalSales, totalFees: $totalFees, fees: $fees, netAmount: $netAmount, averageTransactionValue: $averageTransactionValue)';
}


}

/// @nodoc
abstract mixin class $CardSchemeSummaryCopyWith<$Res>  {
  factory $CardSchemeSummaryCopyWith(CardSchemeSummary value, $Res Function(CardSchemeSummary) _then) = _$CardSchemeSummaryCopyWithImpl;
@useResult
$Res call({
 String? cardScheme, int? transactionCount, num? totalAmount, num? totalSales, num? totalFees, num? fees, num? netAmount, num? averageTransactionValue
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
@pragma('vm:prefer-inline') @override $Res call({Object? cardScheme = freezed,Object? transactionCount = freezed,Object? totalAmount = freezed,Object? totalSales = freezed,Object? totalFees = freezed,Object? fees = freezed,Object? netAmount = freezed,Object? averageTransactionValue = freezed,}) {
  return _then(_self.copyWith(
cardScheme: freezed == cardScheme ? _self.cardScheme : cardScheme // ignore: cast_nullable_to_non_nullable
as String?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num?,totalSales: freezed == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as num?,totalFees: freezed == totalFees ? _self.totalFees : totalFees // ignore: cast_nullable_to_non_nullable
as num?,fees: freezed == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,averageTransactionValue: freezed == averageTransactionValue ? _self.averageTransactionValue : averageTransactionValue // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? cardScheme,  int? transactionCount,  num? totalAmount,  num? totalSales,  num? totalFees,  num? fees,  num? netAmount,  num? averageTransactionValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardSchemeSummary() when $default != null:
return $default(_that.cardScheme,_that.transactionCount,_that.totalAmount,_that.totalSales,_that.totalFees,_that.fees,_that.netAmount,_that.averageTransactionValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? cardScheme,  int? transactionCount,  num? totalAmount,  num? totalSales,  num? totalFees,  num? fees,  num? netAmount,  num? averageTransactionValue)  $default,) {final _that = this;
switch (_that) {
case _CardSchemeSummary():
return $default(_that.cardScheme,_that.transactionCount,_that.totalAmount,_that.totalSales,_that.totalFees,_that.fees,_that.netAmount,_that.averageTransactionValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? cardScheme,  int? transactionCount,  num? totalAmount,  num? totalSales,  num? totalFees,  num? fees,  num? netAmount,  num? averageTransactionValue)?  $default,) {final _that = this;
switch (_that) {
case _CardSchemeSummary() when $default != null:
return $default(_that.cardScheme,_that.transactionCount,_that.totalAmount,_that.totalSales,_that.totalFees,_that.fees,_that.netAmount,_that.averageTransactionValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CardSchemeSummary extends CardSchemeSummary {
  const _CardSchemeSummary({this.cardScheme, this.transactionCount, this.totalAmount, this.totalSales, this.totalFees, this.fees, this.netAmount, this.averageTransactionValue}): super._();
  factory _CardSchemeSummary.fromJson(Map<String, dynamic> json) => _$CardSchemeSummaryFromJson(json);

@override final  String? cardScheme;
@override final  int? transactionCount;
@override final  num? totalAmount;
@override final  num? totalSales;
@override final  num? totalFees;
@override final  num? fees;
@override final  num? netAmount;
@override final  num? averageTransactionValue;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardSchemeSummary&&(identical(other.cardScheme, cardScheme) || other.cardScheme == cardScheme)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.fees, fees) || other.fees == fees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.averageTransactionValue, averageTransactionValue) || other.averageTransactionValue == averageTransactionValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardScheme,transactionCount,totalAmount,totalSales,totalFees,fees,netAmount,averageTransactionValue);

@override
String toString() {
  return 'CardSchemeSummary(cardScheme: $cardScheme, transactionCount: $transactionCount, totalAmount: $totalAmount, totalSales: $totalSales, totalFees: $totalFees, fees: $fees, netAmount: $netAmount, averageTransactionValue: $averageTransactionValue)';
}


}

/// @nodoc
abstract mixin class _$CardSchemeSummaryCopyWith<$Res> implements $CardSchemeSummaryCopyWith<$Res> {
  factory _$CardSchemeSummaryCopyWith(_CardSchemeSummary value, $Res Function(_CardSchemeSummary) _then) = __$CardSchemeSummaryCopyWithImpl;
@override @useResult
$Res call({
 String? cardScheme, int? transactionCount, num? totalAmount, num? totalSales, num? totalFees, num? fees, num? netAmount, num? averageTransactionValue
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
@override @pragma('vm:prefer-inline') $Res call({Object? cardScheme = freezed,Object? transactionCount = freezed,Object? totalAmount = freezed,Object? totalSales = freezed,Object? totalFees = freezed,Object? fees = freezed,Object? netAmount = freezed,Object? averageTransactionValue = freezed,}) {
  return _then(_CardSchemeSummary(
cardScheme: freezed == cardScheme ? _self.cardScheme : cardScheme // ignore: cast_nullable_to_non_nullable
as String?,transactionCount: freezed == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as num?,totalSales: freezed == totalSales ? _self.totalSales : totalSales // ignore: cast_nullable_to_non_nullable
as num?,totalFees: freezed == totalFees ? _self.totalFees : totalFees // ignore: cast_nullable_to_non_nullable
as num?,fees: freezed == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as num?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as num?,averageTransactionValue: freezed == averageTransactionValue ? _self.averageTransactionValue : averageTransactionValue // ignore: cast_nullable_to_non_nullable
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

 String? get mid; String? get merchantName; String? get businessName; String? get merchantAddress; String? get merchantPhone; String? get merchantEmail; String? get startDate; String? get endDate; String? get reportPeriod; num? get totalSales; int? get totalTransactionCount; num? get totalFees; num? get netAmount; List<CardSchemeSummary> get cardSchemeBreakdown; List<DailyBreakdown> get dailyBreakdown; PeriodTotals? get previousPeriod; List<ChannelSummary> get channelBreakdown; List<TerminalSummary> get terminalBreakdown; CountAmount? get refunds; CountAmount? get chargebacks; num? get totalSettled; num? get pendingSettlement; int? get settlementCount; String? get generatedAt;
/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MerchantSalesReportResponseCopyWith<MerchantSalesReportResponse> get copyWith => _$MerchantSalesReportResponseCopyWithImpl<MerchantSalesReportResponse>(this as MerchantSalesReportResponse, _$identity);

  /// Serializes this MerchantSalesReportResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MerchantSalesReportResponse&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.merchantAddress, merchantAddress) || other.merchantAddress == merchantAddress)&&(identical(other.merchantPhone, merchantPhone) || other.merchantPhone == merchantPhone)&&(identical(other.merchantEmail, merchantEmail) || other.merchantEmail == merchantEmail)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.reportPeriod, reportPeriod) || other.reportPeriod == reportPeriod)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalTransactionCount, totalTransactionCount) || other.totalTransactionCount == totalTransactionCount)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&const DeepCollectionEquality().equals(other.cardSchemeBreakdown, cardSchemeBreakdown)&&const DeepCollectionEquality().equals(other.dailyBreakdown, dailyBreakdown)&&(identical(other.previousPeriod, previousPeriod) || other.previousPeriod == previousPeriod)&&const DeepCollectionEquality().equals(other.channelBreakdown, channelBreakdown)&&const DeepCollectionEquality().equals(other.terminalBreakdown, terminalBreakdown)&&(identical(other.refunds, refunds) || other.refunds == refunds)&&(identical(other.chargebacks, chargebacks) || other.chargebacks == chargebacks)&&(identical(other.totalSettled, totalSettled) || other.totalSettled == totalSettled)&&(identical(other.pendingSettlement, pendingSettlement) || other.pendingSettlement == pendingSettlement)&&(identical(other.settlementCount, settlementCount) || other.settlementCount == settlementCount)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,mid,merchantName,businessName,merchantAddress,merchantPhone,merchantEmail,startDate,endDate,reportPeriod,totalSales,totalTransactionCount,totalFees,netAmount,const DeepCollectionEquality().hash(cardSchemeBreakdown),const DeepCollectionEquality().hash(dailyBreakdown),previousPeriod,const DeepCollectionEquality().hash(channelBreakdown),const DeepCollectionEquality().hash(terminalBreakdown),refunds,chargebacks,totalSettled,pendingSettlement,settlementCount,generatedAt]);

@override
String toString() {
  return 'MerchantSalesReportResponse(mid: $mid, merchantName: $merchantName, businessName: $businessName, merchantAddress: $merchantAddress, merchantPhone: $merchantPhone, merchantEmail: $merchantEmail, startDate: $startDate, endDate: $endDate, reportPeriod: $reportPeriod, totalSales: $totalSales, totalTransactionCount: $totalTransactionCount, totalFees: $totalFees, netAmount: $netAmount, cardSchemeBreakdown: $cardSchemeBreakdown, dailyBreakdown: $dailyBreakdown, previousPeriod: $previousPeriod, channelBreakdown: $channelBreakdown, terminalBreakdown: $terminalBreakdown, refunds: $refunds, chargebacks: $chargebacks, totalSettled: $totalSettled, pendingSettlement: $pendingSettlement, settlementCount: $settlementCount, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class $MerchantSalesReportResponseCopyWith<$Res>  {
  factory $MerchantSalesReportResponseCopyWith(MerchantSalesReportResponse value, $Res Function(MerchantSalesReportResponse) _then) = _$MerchantSalesReportResponseCopyWithImpl;
@useResult
$Res call({
 String? mid, String? merchantName, String? businessName, String? merchantAddress, String? merchantPhone, String? merchantEmail, String? startDate, String? endDate, String? reportPeriod, num? totalSales, int? totalTransactionCount, num? totalFees, num? netAmount, List<CardSchemeSummary> cardSchemeBreakdown, List<DailyBreakdown> dailyBreakdown, PeriodTotals? previousPeriod, List<ChannelSummary> channelBreakdown, List<TerminalSummary> terminalBreakdown, CountAmount? refunds, CountAmount? chargebacks, num? totalSettled, num? pendingSettlement, int? settlementCount, String? generatedAt
});


$PeriodTotalsCopyWith<$Res>? get previousPeriod;$CountAmountCopyWith<$Res>? get refunds;$CountAmountCopyWith<$Res>? get chargebacks;

}
/// @nodoc
class _$MerchantSalesReportResponseCopyWithImpl<$Res>
    implements $MerchantSalesReportResponseCopyWith<$Res> {
  _$MerchantSalesReportResponseCopyWithImpl(this._self, this._then);

  final MerchantSalesReportResponse _self;
  final $Res Function(MerchantSalesReportResponse) _then;

/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mid = freezed,Object? merchantName = freezed,Object? businessName = freezed,Object? merchantAddress = freezed,Object? merchantPhone = freezed,Object? merchantEmail = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? reportPeriod = freezed,Object? totalSales = freezed,Object? totalTransactionCount = freezed,Object? totalFees = freezed,Object? netAmount = freezed,Object? cardSchemeBreakdown = null,Object? dailyBreakdown = null,Object? previousPeriod = freezed,Object? channelBreakdown = null,Object? terminalBreakdown = null,Object? refunds = freezed,Object? chargebacks = freezed,Object? totalSettled = freezed,Object? pendingSettlement = freezed,Object? settlementCount = freezed,Object? generatedAt = freezed,}) {
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
as List<DailyBreakdown>,previousPeriod: freezed == previousPeriod ? _self.previousPeriod : previousPeriod // ignore: cast_nullable_to_non_nullable
as PeriodTotals?,channelBreakdown: null == channelBreakdown ? _self.channelBreakdown : channelBreakdown // ignore: cast_nullable_to_non_nullable
as List<ChannelSummary>,terminalBreakdown: null == terminalBreakdown ? _self.terminalBreakdown : terminalBreakdown // ignore: cast_nullable_to_non_nullable
as List<TerminalSummary>,refunds: freezed == refunds ? _self.refunds : refunds // ignore: cast_nullable_to_non_nullable
as CountAmount?,chargebacks: freezed == chargebacks ? _self.chargebacks : chargebacks // ignore: cast_nullable_to_non_nullable
as CountAmount?,totalSettled: freezed == totalSettled ? _self.totalSettled : totalSettled // ignore: cast_nullable_to_non_nullable
as num?,pendingSettlement: freezed == pendingSettlement ? _self.pendingSettlement : pendingSettlement // ignore: cast_nullable_to_non_nullable
as num?,settlementCount: freezed == settlementCount ? _self.settlementCount : settlementCount // ignore: cast_nullable_to_non_nullable
as int?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeriodTotalsCopyWith<$Res>? get previousPeriod {
    if (_self.previousPeriod == null) {
    return null;
  }

  return $PeriodTotalsCopyWith<$Res>(_self.previousPeriod!, (value) {
    return _then(_self.copyWith(previousPeriod: value));
  });
}/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountAmountCopyWith<$Res>? get refunds {
    if (_self.refunds == null) {
    return null;
  }

  return $CountAmountCopyWith<$Res>(_self.refunds!, (value) {
    return _then(_self.copyWith(refunds: value));
  });
}/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountAmountCopyWith<$Res>? get chargebacks {
    if (_self.chargebacks == null) {
    return null;
  }

  return $CountAmountCopyWith<$Res>(_self.chargebacks!, (value) {
    return _then(_self.copyWith(chargebacks: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? mid,  String? merchantName,  String? businessName,  String? merchantAddress,  String? merchantPhone,  String? merchantEmail,  String? startDate,  String? endDate,  String? reportPeriod,  num? totalSales,  int? totalTransactionCount,  num? totalFees,  num? netAmount,  List<CardSchemeSummary> cardSchemeBreakdown,  List<DailyBreakdown> dailyBreakdown,  PeriodTotals? previousPeriod,  List<ChannelSummary> channelBreakdown,  List<TerminalSummary> terminalBreakdown,  CountAmount? refunds,  CountAmount? chargebacks,  num? totalSettled,  num? pendingSettlement,  int? settlementCount,  String? generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MerchantSalesReportResponse() when $default != null:
return $default(_that.mid,_that.merchantName,_that.businessName,_that.merchantAddress,_that.merchantPhone,_that.merchantEmail,_that.startDate,_that.endDate,_that.reportPeriod,_that.totalSales,_that.totalTransactionCount,_that.totalFees,_that.netAmount,_that.cardSchemeBreakdown,_that.dailyBreakdown,_that.previousPeriod,_that.channelBreakdown,_that.terminalBreakdown,_that.refunds,_that.chargebacks,_that.totalSettled,_that.pendingSettlement,_that.settlementCount,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? mid,  String? merchantName,  String? businessName,  String? merchantAddress,  String? merchantPhone,  String? merchantEmail,  String? startDate,  String? endDate,  String? reportPeriod,  num? totalSales,  int? totalTransactionCount,  num? totalFees,  num? netAmount,  List<CardSchemeSummary> cardSchemeBreakdown,  List<DailyBreakdown> dailyBreakdown,  PeriodTotals? previousPeriod,  List<ChannelSummary> channelBreakdown,  List<TerminalSummary> terminalBreakdown,  CountAmount? refunds,  CountAmount? chargebacks,  num? totalSettled,  num? pendingSettlement,  int? settlementCount,  String? generatedAt)  $default,) {final _that = this;
switch (_that) {
case _MerchantSalesReportResponse():
return $default(_that.mid,_that.merchantName,_that.businessName,_that.merchantAddress,_that.merchantPhone,_that.merchantEmail,_that.startDate,_that.endDate,_that.reportPeriod,_that.totalSales,_that.totalTransactionCount,_that.totalFees,_that.netAmount,_that.cardSchemeBreakdown,_that.dailyBreakdown,_that.previousPeriod,_that.channelBreakdown,_that.terminalBreakdown,_that.refunds,_that.chargebacks,_that.totalSettled,_that.pendingSettlement,_that.settlementCount,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? mid,  String? merchantName,  String? businessName,  String? merchantAddress,  String? merchantPhone,  String? merchantEmail,  String? startDate,  String? endDate,  String? reportPeriod,  num? totalSales,  int? totalTransactionCount,  num? totalFees,  num? netAmount,  List<CardSchemeSummary> cardSchemeBreakdown,  List<DailyBreakdown> dailyBreakdown,  PeriodTotals? previousPeriod,  List<ChannelSummary> channelBreakdown,  List<TerminalSummary> terminalBreakdown,  CountAmount? refunds,  CountAmount? chargebacks,  num? totalSettled,  num? pendingSettlement,  int? settlementCount,  String? generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MerchantSalesReportResponse() when $default != null:
return $default(_that.mid,_that.merchantName,_that.businessName,_that.merchantAddress,_that.merchantPhone,_that.merchantEmail,_that.startDate,_that.endDate,_that.reportPeriod,_that.totalSales,_that.totalTransactionCount,_that.totalFees,_that.netAmount,_that.cardSchemeBreakdown,_that.dailyBreakdown,_that.previousPeriod,_that.channelBreakdown,_that.terminalBreakdown,_that.refunds,_that.chargebacks,_that.totalSettled,_that.pendingSettlement,_that.settlementCount,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MerchantSalesReportResponse implements MerchantSalesReportResponse {
  const _MerchantSalesReportResponse({this.mid, this.merchantName, this.businessName, this.merchantAddress, this.merchantPhone, this.merchantEmail, this.startDate, this.endDate, this.reportPeriod, this.totalSales, this.totalTransactionCount, this.totalFees, this.netAmount, final  List<CardSchemeSummary> cardSchemeBreakdown = const <CardSchemeSummary>[], final  List<DailyBreakdown> dailyBreakdown = const <DailyBreakdown>[], this.previousPeriod, final  List<ChannelSummary> channelBreakdown = const <ChannelSummary>[], final  List<TerminalSummary> terminalBreakdown = const <TerminalSummary>[], this.refunds, this.chargebacks, this.totalSettled, this.pendingSettlement, this.settlementCount, this.generatedAt}): _cardSchemeBreakdown = cardSchemeBreakdown,_dailyBreakdown = dailyBreakdown,_channelBreakdown = channelBreakdown,_terminalBreakdown = terminalBreakdown;
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

@override final  PeriodTotals? previousPeriod;
 final  List<ChannelSummary> _channelBreakdown;
@override@JsonKey() List<ChannelSummary> get channelBreakdown {
  if (_channelBreakdown is EqualUnmodifiableListView) return _channelBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_channelBreakdown);
}

 final  List<TerminalSummary> _terminalBreakdown;
@override@JsonKey() List<TerminalSummary> get terminalBreakdown {
  if (_terminalBreakdown is EqualUnmodifiableListView) return _terminalBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_terminalBreakdown);
}

@override final  CountAmount? refunds;
@override final  CountAmount? chargebacks;
@override final  num? totalSettled;
@override final  num? pendingSettlement;
@override final  int? settlementCount;
@override final  String? generatedAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MerchantSalesReportResponse&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.merchantAddress, merchantAddress) || other.merchantAddress == merchantAddress)&&(identical(other.merchantPhone, merchantPhone) || other.merchantPhone == merchantPhone)&&(identical(other.merchantEmail, merchantEmail) || other.merchantEmail == merchantEmail)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.reportPeriod, reportPeriod) || other.reportPeriod == reportPeriod)&&(identical(other.totalSales, totalSales) || other.totalSales == totalSales)&&(identical(other.totalTransactionCount, totalTransactionCount) || other.totalTransactionCount == totalTransactionCount)&&(identical(other.totalFees, totalFees) || other.totalFees == totalFees)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&const DeepCollectionEquality().equals(other._cardSchemeBreakdown, _cardSchemeBreakdown)&&const DeepCollectionEquality().equals(other._dailyBreakdown, _dailyBreakdown)&&(identical(other.previousPeriod, previousPeriod) || other.previousPeriod == previousPeriod)&&const DeepCollectionEquality().equals(other._channelBreakdown, _channelBreakdown)&&const DeepCollectionEquality().equals(other._terminalBreakdown, _terminalBreakdown)&&(identical(other.refunds, refunds) || other.refunds == refunds)&&(identical(other.chargebacks, chargebacks) || other.chargebacks == chargebacks)&&(identical(other.totalSettled, totalSettled) || other.totalSettled == totalSettled)&&(identical(other.pendingSettlement, pendingSettlement) || other.pendingSettlement == pendingSettlement)&&(identical(other.settlementCount, settlementCount) || other.settlementCount == settlementCount)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,mid,merchantName,businessName,merchantAddress,merchantPhone,merchantEmail,startDate,endDate,reportPeriod,totalSales,totalTransactionCount,totalFees,netAmount,const DeepCollectionEquality().hash(_cardSchemeBreakdown),const DeepCollectionEquality().hash(_dailyBreakdown),previousPeriod,const DeepCollectionEquality().hash(_channelBreakdown),const DeepCollectionEquality().hash(_terminalBreakdown),refunds,chargebacks,totalSettled,pendingSettlement,settlementCount,generatedAt]);

@override
String toString() {
  return 'MerchantSalesReportResponse(mid: $mid, merchantName: $merchantName, businessName: $businessName, merchantAddress: $merchantAddress, merchantPhone: $merchantPhone, merchantEmail: $merchantEmail, startDate: $startDate, endDate: $endDate, reportPeriod: $reportPeriod, totalSales: $totalSales, totalTransactionCount: $totalTransactionCount, totalFees: $totalFees, netAmount: $netAmount, cardSchemeBreakdown: $cardSchemeBreakdown, dailyBreakdown: $dailyBreakdown, previousPeriod: $previousPeriod, channelBreakdown: $channelBreakdown, terminalBreakdown: $terminalBreakdown, refunds: $refunds, chargebacks: $chargebacks, totalSettled: $totalSettled, pendingSettlement: $pendingSettlement, settlementCount: $settlementCount, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$MerchantSalesReportResponseCopyWith<$Res> implements $MerchantSalesReportResponseCopyWith<$Res> {
  factory _$MerchantSalesReportResponseCopyWith(_MerchantSalesReportResponse value, $Res Function(_MerchantSalesReportResponse) _then) = __$MerchantSalesReportResponseCopyWithImpl;
@override @useResult
$Res call({
 String? mid, String? merchantName, String? businessName, String? merchantAddress, String? merchantPhone, String? merchantEmail, String? startDate, String? endDate, String? reportPeriod, num? totalSales, int? totalTransactionCount, num? totalFees, num? netAmount, List<CardSchemeSummary> cardSchemeBreakdown, List<DailyBreakdown> dailyBreakdown, PeriodTotals? previousPeriod, List<ChannelSummary> channelBreakdown, List<TerminalSummary> terminalBreakdown, CountAmount? refunds, CountAmount? chargebacks, num? totalSettled, num? pendingSettlement, int? settlementCount, String? generatedAt
});


@override $PeriodTotalsCopyWith<$Res>? get previousPeriod;@override $CountAmountCopyWith<$Res>? get refunds;@override $CountAmountCopyWith<$Res>? get chargebacks;

}
/// @nodoc
class __$MerchantSalesReportResponseCopyWithImpl<$Res>
    implements _$MerchantSalesReportResponseCopyWith<$Res> {
  __$MerchantSalesReportResponseCopyWithImpl(this._self, this._then);

  final _MerchantSalesReportResponse _self;
  final $Res Function(_MerchantSalesReportResponse) _then;

/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mid = freezed,Object? merchantName = freezed,Object? businessName = freezed,Object? merchantAddress = freezed,Object? merchantPhone = freezed,Object? merchantEmail = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? reportPeriod = freezed,Object? totalSales = freezed,Object? totalTransactionCount = freezed,Object? totalFees = freezed,Object? netAmount = freezed,Object? cardSchemeBreakdown = null,Object? dailyBreakdown = null,Object? previousPeriod = freezed,Object? channelBreakdown = null,Object? terminalBreakdown = null,Object? refunds = freezed,Object? chargebacks = freezed,Object? totalSettled = freezed,Object? pendingSettlement = freezed,Object? settlementCount = freezed,Object? generatedAt = freezed,}) {
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
as List<DailyBreakdown>,previousPeriod: freezed == previousPeriod ? _self.previousPeriod : previousPeriod // ignore: cast_nullable_to_non_nullable
as PeriodTotals?,channelBreakdown: null == channelBreakdown ? _self._channelBreakdown : channelBreakdown // ignore: cast_nullable_to_non_nullable
as List<ChannelSummary>,terminalBreakdown: null == terminalBreakdown ? _self._terminalBreakdown : terminalBreakdown // ignore: cast_nullable_to_non_nullable
as List<TerminalSummary>,refunds: freezed == refunds ? _self.refunds : refunds // ignore: cast_nullable_to_non_nullable
as CountAmount?,chargebacks: freezed == chargebacks ? _self.chargebacks : chargebacks // ignore: cast_nullable_to_non_nullable
as CountAmount?,totalSettled: freezed == totalSettled ? _self.totalSettled : totalSettled // ignore: cast_nullable_to_non_nullable
as num?,pendingSettlement: freezed == pendingSettlement ? _self.pendingSettlement : pendingSettlement // ignore: cast_nullable_to_non_nullable
as num?,settlementCount: freezed == settlementCount ? _self.settlementCount : settlementCount // ignore: cast_nullable_to_non_nullable
as int?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeriodTotalsCopyWith<$Res>? get previousPeriod {
    if (_self.previousPeriod == null) {
    return null;
  }

  return $PeriodTotalsCopyWith<$Res>(_self.previousPeriod!, (value) {
    return _then(_self.copyWith(previousPeriod: value));
  });
}/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountAmountCopyWith<$Res>? get refunds {
    if (_self.refunds == null) {
    return null;
  }

  return $CountAmountCopyWith<$Res>(_self.refunds!, (value) {
    return _then(_self.copyWith(refunds: value));
  });
}/// Create a copy of MerchantSalesReportResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountAmountCopyWith<$Res>? get chargebacks {
    if (_self.chargebacks == null) {
    return null;
  }

  return $CountAmountCopyWith<$Res>(_self.chargebacks!, (value) {
    return _then(_self.copyWith(chargebacks: value));
  });
}
}


/// @nodoc
mixin _$SettlementResponse {

 String? get id; String? get settlementReference; String? get batchReference; String? get mid; String? get merchantName; String? get settlementDate; int? get transactionCount; num? get totalTransactionAmount; num? get totalTransactionFees; num? get grossAmount; num? get settlementFee; num? get netAmount; String? get accountNumber; String? get accountName; String? get bankName; String? get status; String? get settledAt; String? get failureReason; String? get cycle;
/// Create a copy of SettlementResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementResponseCopyWith<SettlementResponse> get copyWith => _$SettlementResponseCopyWithImpl<SettlementResponse>(this as SettlementResponse, _$identity);

  /// Serializes this SettlementResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.settlementReference, settlementReference) || other.settlementReference == settlementReference)&&(identical(other.batchReference, batchReference) || other.batchReference == batchReference)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.settlementDate, settlementDate) || other.settlementDate == settlementDate)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalTransactionAmount, totalTransactionAmount) || other.totalTransactionAmount == totalTransactionAmount)&&(identical(other.totalTransactionFees, totalTransactionFees) || other.totalTransactionFees == totalTransactionFees)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.settlementFee, settlementFee) || other.settlementFee == settlementFee)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.status, status) || other.status == status)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.cycle, cycle) || other.cycle == cycle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,settlementReference,batchReference,mid,merchantName,settlementDate,transactionCount,totalTransactionAmount,totalTransactionFees,grossAmount,settlementFee,netAmount,accountNumber,accountName,bankName,status,settledAt,failureReason,cycle]);

@override
String toString() {
  return 'SettlementResponse(id: $id, settlementReference: $settlementReference, batchReference: $batchReference, mid: $mid, merchantName: $merchantName, settlementDate: $settlementDate, transactionCount: $transactionCount, totalTransactionAmount: $totalTransactionAmount, totalTransactionFees: $totalTransactionFees, grossAmount: $grossAmount, settlementFee: $settlementFee, netAmount: $netAmount, accountNumber: $accountNumber, accountName: $accountName, bankName: $bankName, status: $status, settledAt: $settledAt, failureReason: $failureReason, cycle: $cycle)';
}


}

/// @nodoc
abstract mixin class $SettlementResponseCopyWith<$Res>  {
  factory $SettlementResponseCopyWith(SettlementResponse value, $Res Function(SettlementResponse) _then) = _$SettlementResponseCopyWithImpl;
@useResult
$Res call({
 String? id, String? settlementReference, String? batchReference, String? mid, String? merchantName, String? settlementDate, int? transactionCount, num? totalTransactionAmount, num? totalTransactionFees, num? grossAmount, num? settlementFee, num? netAmount, String? accountNumber, String? accountName, String? bankName, String? status, String? settledAt, String? failureReason, String? cycle
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? settlementReference = freezed,Object? batchReference = freezed,Object? mid = freezed,Object? merchantName = freezed,Object? settlementDate = freezed,Object? transactionCount = freezed,Object? totalTransactionAmount = freezed,Object? totalTransactionFees = freezed,Object? grossAmount = freezed,Object? settlementFee = freezed,Object? netAmount = freezed,Object? accountNumber = freezed,Object? accountName = freezed,Object? bankName = freezed,Object? status = freezed,Object? settledAt = freezed,Object? failureReason = freezed,Object? cycle = freezed,}) {
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
as String?,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,cycle: freezed == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? settlementReference,  String? batchReference,  String? mid,  String? merchantName,  String? settlementDate,  int? transactionCount,  num? totalTransactionAmount,  num? totalTransactionFees,  num? grossAmount,  num? settlementFee,  num? netAmount,  String? accountNumber,  String? accountName,  String? bankName,  String? status,  String? settledAt,  String? failureReason,  String? cycle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementResponse() when $default != null:
return $default(_that.id,_that.settlementReference,_that.batchReference,_that.mid,_that.merchantName,_that.settlementDate,_that.transactionCount,_that.totalTransactionAmount,_that.totalTransactionFees,_that.grossAmount,_that.settlementFee,_that.netAmount,_that.accountNumber,_that.accountName,_that.bankName,_that.status,_that.settledAt,_that.failureReason,_that.cycle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? settlementReference,  String? batchReference,  String? mid,  String? merchantName,  String? settlementDate,  int? transactionCount,  num? totalTransactionAmount,  num? totalTransactionFees,  num? grossAmount,  num? settlementFee,  num? netAmount,  String? accountNumber,  String? accountName,  String? bankName,  String? status,  String? settledAt,  String? failureReason,  String? cycle)  $default,) {final _that = this;
switch (_that) {
case _SettlementResponse():
return $default(_that.id,_that.settlementReference,_that.batchReference,_that.mid,_that.merchantName,_that.settlementDate,_that.transactionCount,_that.totalTransactionAmount,_that.totalTransactionFees,_that.grossAmount,_that.settlementFee,_that.netAmount,_that.accountNumber,_that.accountName,_that.bankName,_that.status,_that.settledAt,_that.failureReason,_that.cycle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? settlementReference,  String? batchReference,  String? mid,  String? merchantName,  String? settlementDate,  int? transactionCount,  num? totalTransactionAmount,  num? totalTransactionFees,  num? grossAmount,  num? settlementFee,  num? netAmount,  String? accountNumber,  String? accountName,  String? bankName,  String? status,  String? settledAt,  String? failureReason,  String? cycle)?  $default,) {final _that = this;
switch (_that) {
case _SettlementResponse() when $default != null:
return $default(_that.id,_that.settlementReference,_that.batchReference,_that.mid,_that.merchantName,_that.settlementDate,_that.transactionCount,_that.totalTransactionAmount,_that.totalTransactionFees,_that.grossAmount,_that.settlementFee,_that.netAmount,_that.accountNumber,_that.accountName,_that.bankName,_that.status,_that.settledAt,_that.failureReason,_that.cycle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementResponse implements SettlementResponse {
  const _SettlementResponse({this.id, this.settlementReference, this.batchReference, this.mid, this.merchantName, this.settlementDate, this.transactionCount, this.totalTransactionAmount, this.totalTransactionFees, this.grossAmount, this.settlementFee, this.netAmount, this.accountNumber, this.accountName, this.bankName, this.status, this.settledAt, this.failureReason, this.cycle});
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
@override final  String? settledAt;
@override final  String? failureReason;
@override final  String? cycle;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.settlementReference, settlementReference) || other.settlementReference == settlementReference)&&(identical(other.batchReference, batchReference) || other.batchReference == batchReference)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.settlementDate, settlementDate) || other.settlementDate == settlementDate)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalTransactionAmount, totalTransactionAmount) || other.totalTransactionAmount == totalTransactionAmount)&&(identical(other.totalTransactionFees, totalTransactionFees) || other.totalTransactionFees == totalTransactionFees)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.settlementFee, settlementFee) || other.settlementFee == settlementFee)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.status, status) || other.status == status)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.cycle, cycle) || other.cycle == cycle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,settlementReference,batchReference,mid,merchantName,settlementDate,transactionCount,totalTransactionAmount,totalTransactionFees,grossAmount,settlementFee,netAmount,accountNumber,accountName,bankName,status,settledAt,failureReason,cycle]);

@override
String toString() {
  return 'SettlementResponse(id: $id, settlementReference: $settlementReference, batchReference: $batchReference, mid: $mid, merchantName: $merchantName, settlementDate: $settlementDate, transactionCount: $transactionCount, totalTransactionAmount: $totalTransactionAmount, totalTransactionFees: $totalTransactionFees, grossAmount: $grossAmount, settlementFee: $settlementFee, netAmount: $netAmount, accountNumber: $accountNumber, accountName: $accountName, bankName: $bankName, status: $status, settledAt: $settledAt, failureReason: $failureReason, cycle: $cycle)';
}


}

/// @nodoc
abstract mixin class _$SettlementResponseCopyWith<$Res> implements $SettlementResponseCopyWith<$Res> {
  factory _$SettlementResponseCopyWith(_SettlementResponse value, $Res Function(_SettlementResponse) _then) = __$SettlementResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? settlementReference, String? batchReference, String? mid, String? merchantName, String? settlementDate, int? transactionCount, num? totalTransactionAmount, num? totalTransactionFees, num? grossAmount, num? settlementFee, num? netAmount, String? accountNumber, String? accountName, String? bankName, String? status, String? settledAt, String? failureReason, String? cycle
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? settlementReference = freezed,Object? batchReference = freezed,Object? mid = freezed,Object? merchantName = freezed,Object? settlementDate = freezed,Object? transactionCount = freezed,Object? totalTransactionAmount = freezed,Object? totalTransactionFees = freezed,Object? grossAmount = freezed,Object? settlementFee = freezed,Object? netAmount = freezed,Object? accountNumber = freezed,Object? accountName = freezed,Object? bankName = freezed,Object? status = freezed,Object? settledAt = freezed,Object? failureReason = freezed,Object? cycle = freezed,}) {
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
as String?,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,cycle: freezed == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
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
