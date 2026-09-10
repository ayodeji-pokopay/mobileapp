// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TerminalResponse {

 String? get id; String? get tid; String? get serialNumber; String? get model; String? get label; String? get status; bool? get instantSettlement; String? get activatedAt; String? get lastHeartbeat; num? get todaySales; int? get todayTransactions;
/// Create a copy of TerminalResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TerminalResponseCopyWith<TerminalResponse> get copyWith => _$TerminalResponseCopyWithImpl<TerminalResponse>(this as TerminalResponse, _$identity);

  /// Serializes this TerminalResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TerminalResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber)&&(identical(other.model, model) || other.model == model)&&(identical(other.label, label) || other.label == label)&&(identical(other.status, status) || other.status == status)&&(identical(other.instantSettlement, instantSettlement) || other.instantSettlement == instantSettlement)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.lastHeartbeat, lastHeartbeat) || other.lastHeartbeat == lastHeartbeat)&&(identical(other.todaySales, todaySales) || other.todaySales == todaySales)&&(identical(other.todayTransactions, todayTransactions) || other.todayTransactions == todayTransactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tid,serialNumber,model,label,status,instantSettlement,activatedAt,lastHeartbeat,todaySales,todayTransactions);

@override
String toString() {
  return 'TerminalResponse(id: $id, tid: $tid, serialNumber: $serialNumber, model: $model, label: $label, status: $status, instantSettlement: $instantSettlement, activatedAt: $activatedAt, lastHeartbeat: $lastHeartbeat, todaySales: $todaySales, todayTransactions: $todayTransactions)';
}


}

/// @nodoc
abstract mixin class $TerminalResponseCopyWith<$Res>  {
  factory $TerminalResponseCopyWith(TerminalResponse value, $Res Function(TerminalResponse) _then) = _$TerminalResponseCopyWithImpl;
@useResult
$Res call({
 String? id, String? tid, String? serialNumber, String? model, String? label, String? status, bool? instantSettlement, String? activatedAt, String? lastHeartbeat, num? todaySales, int? todayTransactions
});




}
/// @nodoc
class _$TerminalResponseCopyWithImpl<$Res>
    implements $TerminalResponseCopyWith<$Res> {
  _$TerminalResponseCopyWithImpl(this._self, this._then);

  final TerminalResponse _self;
  final $Res Function(TerminalResponse) _then;

/// Create a copy of TerminalResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? tid = freezed,Object? serialNumber = freezed,Object? model = freezed,Object? label = freezed,Object? status = freezed,Object? instantSettlement = freezed,Object? activatedAt = freezed,Object? lastHeartbeat = freezed,Object? todaySales = freezed,Object? todayTransactions = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,serialNumber: freezed == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,instantSettlement: freezed == instantSettlement ? _self.instantSettlement : instantSettlement // ignore: cast_nullable_to_non_nullable
as bool?,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as String?,lastHeartbeat: freezed == lastHeartbeat ? _self.lastHeartbeat : lastHeartbeat // ignore: cast_nullable_to_non_nullable
as String?,todaySales: freezed == todaySales ? _self.todaySales : todaySales // ignore: cast_nullable_to_non_nullable
as num?,todayTransactions: freezed == todayTransactions ? _self.todayTransactions : todayTransactions // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TerminalResponse].
extension TerminalResponsePatterns on TerminalResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TerminalResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TerminalResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TerminalResponse value)  $default,){
final _that = this;
switch (_that) {
case _TerminalResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TerminalResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TerminalResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? tid,  String? serialNumber,  String? model,  String? label,  String? status,  bool? instantSettlement,  String? activatedAt,  String? lastHeartbeat,  num? todaySales,  int? todayTransactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TerminalResponse() when $default != null:
return $default(_that.id,_that.tid,_that.serialNumber,_that.model,_that.label,_that.status,_that.instantSettlement,_that.activatedAt,_that.lastHeartbeat,_that.todaySales,_that.todayTransactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? tid,  String? serialNumber,  String? model,  String? label,  String? status,  bool? instantSettlement,  String? activatedAt,  String? lastHeartbeat,  num? todaySales,  int? todayTransactions)  $default,) {final _that = this;
switch (_that) {
case _TerminalResponse():
return $default(_that.id,_that.tid,_that.serialNumber,_that.model,_that.label,_that.status,_that.instantSettlement,_that.activatedAt,_that.lastHeartbeat,_that.todaySales,_that.todayTransactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? tid,  String? serialNumber,  String? model,  String? label,  String? status,  bool? instantSettlement,  String? activatedAt,  String? lastHeartbeat,  num? todaySales,  int? todayTransactions)?  $default,) {final _that = this;
switch (_that) {
case _TerminalResponse() when $default != null:
return $default(_that.id,_that.tid,_that.serialNumber,_that.model,_that.label,_that.status,_that.instantSettlement,_that.activatedAt,_that.lastHeartbeat,_that.todaySales,_that.todayTransactions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TerminalResponse implements TerminalResponse {
  const _TerminalResponse({this.id, this.tid, this.serialNumber, this.model, this.label, this.status, this.instantSettlement, this.activatedAt, this.lastHeartbeat, this.todaySales, this.todayTransactions});
  factory _TerminalResponse.fromJson(Map<String, dynamic> json) => _$TerminalResponseFromJson(json);

@override final  String? id;
@override final  String? tid;
@override final  String? serialNumber;
@override final  String? model;
@override final  String? label;
@override final  String? status;
@override final  bool? instantSettlement;
@override final  String? activatedAt;
@override final  String? lastHeartbeat;
@override final  num? todaySales;
@override final  int? todayTransactions;

/// Create a copy of TerminalResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TerminalResponseCopyWith<_TerminalResponse> get copyWith => __$TerminalResponseCopyWithImpl<_TerminalResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TerminalResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TerminalResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber)&&(identical(other.model, model) || other.model == model)&&(identical(other.label, label) || other.label == label)&&(identical(other.status, status) || other.status == status)&&(identical(other.instantSettlement, instantSettlement) || other.instantSettlement == instantSettlement)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.lastHeartbeat, lastHeartbeat) || other.lastHeartbeat == lastHeartbeat)&&(identical(other.todaySales, todaySales) || other.todaySales == todaySales)&&(identical(other.todayTransactions, todayTransactions) || other.todayTransactions == todayTransactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tid,serialNumber,model,label,status,instantSettlement,activatedAt,lastHeartbeat,todaySales,todayTransactions);

@override
String toString() {
  return 'TerminalResponse(id: $id, tid: $tid, serialNumber: $serialNumber, model: $model, label: $label, status: $status, instantSettlement: $instantSettlement, activatedAt: $activatedAt, lastHeartbeat: $lastHeartbeat, todaySales: $todaySales, todayTransactions: $todayTransactions)';
}


}

/// @nodoc
abstract mixin class _$TerminalResponseCopyWith<$Res> implements $TerminalResponseCopyWith<$Res> {
  factory _$TerminalResponseCopyWith(_TerminalResponse value, $Res Function(_TerminalResponse) _then) = __$TerminalResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? tid, String? serialNumber, String? model, String? label, String? status, bool? instantSettlement, String? activatedAt, String? lastHeartbeat, num? todaySales, int? todayTransactions
});




}
/// @nodoc
class __$TerminalResponseCopyWithImpl<$Res>
    implements _$TerminalResponseCopyWith<$Res> {
  __$TerminalResponseCopyWithImpl(this._self, this._then);

  final _TerminalResponse _self;
  final $Res Function(_TerminalResponse) _then;

/// Create a copy of TerminalResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? tid = freezed,Object? serialNumber = freezed,Object? model = freezed,Object? label = freezed,Object? status = freezed,Object? instantSettlement = freezed,Object? activatedAt = freezed,Object? lastHeartbeat = freezed,Object? todaySales = freezed,Object? todayTransactions = freezed,}) {
  return _then(_TerminalResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,serialNumber: freezed == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,instantSettlement: freezed == instantSettlement ? _self.instantSettlement : instantSettlement // ignore: cast_nullable_to_non_nullable
as bool?,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as String?,lastHeartbeat: freezed == lastHeartbeat ? _self.lastHeartbeat : lastHeartbeat // ignore: cast_nullable_to_non_nullable
as String?,todaySales: freezed == todaySales ? _self.todaySales : todaySales // ignore: cast_nullable_to_non_nullable
as num?,todayTransactions: freezed == todayTransactions ? _self.todayTransactions : todayTransactions // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$MerchantPreferences {

 bool? get dailySettlementReport; bool? get monthlySettlementReport; List<String> get reportRecipients; String? get language; bool? get pushEnabled;
/// Create a copy of MerchantPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MerchantPreferencesCopyWith<MerchantPreferences> get copyWith => _$MerchantPreferencesCopyWithImpl<MerchantPreferences>(this as MerchantPreferences, _$identity);

  /// Serializes this MerchantPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MerchantPreferences&&(identical(other.dailySettlementReport, dailySettlementReport) || other.dailySettlementReport == dailySettlementReport)&&(identical(other.monthlySettlementReport, monthlySettlementReport) || other.monthlySettlementReport == monthlySettlementReport)&&const DeepCollectionEquality().equals(other.reportRecipients, reportRecipients)&&(identical(other.language, language) || other.language == language)&&(identical(other.pushEnabled, pushEnabled) || other.pushEnabled == pushEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dailySettlementReport,monthlySettlementReport,const DeepCollectionEquality().hash(reportRecipients),language,pushEnabled);

@override
String toString() {
  return 'MerchantPreferences(dailySettlementReport: $dailySettlementReport, monthlySettlementReport: $monthlySettlementReport, reportRecipients: $reportRecipients, language: $language, pushEnabled: $pushEnabled)';
}


}

/// @nodoc
abstract mixin class $MerchantPreferencesCopyWith<$Res>  {
  factory $MerchantPreferencesCopyWith(MerchantPreferences value, $Res Function(MerchantPreferences) _then) = _$MerchantPreferencesCopyWithImpl;
@useResult
$Res call({
 bool? dailySettlementReport, bool? monthlySettlementReport, List<String> reportRecipients, String? language, bool? pushEnabled
});




}
/// @nodoc
class _$MerchantPreferencesCopyWithImpl<$Res>
    implements $MerchantPreferencesCopyWith<$Res> {
  _$MerchantPreferencesCopyWithImpl(this._self, this._then);

  final MerchantPreferences _self;
  final $Res Function(MerchantPreferences) _then;

/// Create a copy of MerchantPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dailySettlementReport = freezed,Object? monthlySettlementReport = freezed,Object? reportRecipients = null,Object? language = freezed,Object? pushEnabled = freezed,}) {
  return _then(_self.copyWith(
dailySettlementReport: freezed == dailySettlementReport ? _self.dailySettlementReport : dailySettlementReport // ignore: cast_nullable_to_non_nullable
as bool?,monthlySettlementReport: freezed == monthlySettlementReport ? _self.monthlySettlementReport : monthlySettlementReport // ignore: cast_nullable_to_non_nullable
as bool?,reportRecipients: null == reportRecipients ? _self.reportRecipients : reportRecipients // ignore: cast_nullable_to_non_nullable
as List<String>,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,pushEnabled: freezed == pushEnabled ? _self.pushEnabled : pushEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MerchantPreferences].
extension MerchantPreferencesPatterns on MerchantPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MerchantPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MerchantPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MerchantPreferences value)  $default,){
final _that = this;
switch (_that) {
case _MerchantPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MerchantPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _MerchantPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? dailySettlementReport,  bool? monthlySettlementReport,  List<String> reportRecipients,  String? language,  bool? pushEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MerchantPreferences() when $default != null:
return $default(_that.dailySettlementReport,_that.monthlySettlementReport,_that.reportRecipients,_that.language,_that.pushEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? dailySettlementReport,  bool? monthlySettlementReport,  List<String> reportRecipients,  String? language,  bool? pushEnabled)  $default,) {final _that = this;
switch (_that) {
case _MerchantPreferences():
return $default(_that.dailySettlementReport,_that.monthlySettlementReport,_that.reportRecipients,_that.language,_that.pushEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? dailySettlementReport,  bool? monthlySettlementReport,  List<String> reportRecipients,  String? language,  bool? pushEnabled)?  $default,) {final _that = this;
switch (_that) {
case _MerchantPreferences() when $default != null:
return $default(_that.dailySettlementReport,_that.monthlySettlementReport,_that.reportRecipients,_that.language,_that.pushEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MerchantPreferences implements MerchantPreferences {
  const _MerchantPreferences({this.dailySettlementReport, this.monthlySettlementReport, final  List<String> reportRecipients = const <String>[], this.language, this.pushEnabled}): _reportRecipients = reportRecipients;
  factory _MerchantPreferences.fromJson(Map<String, dynamic> json) => _$MerchantPreferencesFromJson(json);

@override final  bool? dailySettlementReport;
@override final  bool? monthlySettlementReport;
 final  List<String> _reportRecipients;
@override@JsonKey() List<String> get reportRecipients {
  if (_reportRecipients is EqualUnmodifiableListView) return _reportRecipients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reportRecipients);
}

@override final  String? language;
@override final  bool? pushEnabled;

/// Create a copy of MerchantPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MerchantPreferencesCopyWith<_MerchantPreferences> get copyWith => __$MerchantPreferencesCopyWithImpl<_MerchantPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MerchantPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MerchantPreferences&&(identical(other.dailySettlementReport, dailySettlementReport) || other.dailySettlementReport == dailySettlementReport)&&(identical(other.monthlySettlementReport, monthlySettlementReport) || other.monthlySettlementReport == monthlySettlementReport)&&const DeepCollectionEquality().equals(other._reportRecipients, _reportRecipients)&&(identical(other.language, language) || other.language == language)&&(identical(other.pushEnabled, pushEnabled) || other.pushEnabled == pushEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dailySettlementReport,monthlySettlementReport,const DeepCollectionEquality().hash(_reportRecipients),language,pushEnabled);

@override
String toString() {
  return 'MerchantPreferences(dailySettlementReport: $dailySettlementReport, monthlySettlementReport: $monthlySettlementReport, reportRecipients: $reportRecipients, language: $language, pushEnabled: $pushEnabled)';
}


}

/// @nodoc
abstract mixin class _$MerchantPreferencesCopyWith<$Res> implements $MerchantPreferencesCopyWith<$Res> {
  factory _$MerchantPreferencesCopyWith(_MerchantPreferences value, $Res Function(_MerchantPreferences) _then) = __$MerchantPreferencesCopyWithImpl;
@override @useResult
$Res call({
 bool? dailySettlementReport, bool? monthlySettlementReport, List<String> reportRecipients, String? language, bool? pushEnabled
});




}
/// @nodoc
class __$MerchantPreferencesCopyWithImpl<$Res>
    implements _$MerchantPreferencesCopyWith<$Res> {
  __$MerchantPreferencesCopyWithImpl(this._self, this._then);

  final _MerchantPreferences _self;
  final $Res Function(_MerchantPreferences) _then;

/// Create a copy of MerchantPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dailySettlementReport = freezed,Object? monthlySettlementReport = freezed,Object? reportRecipients = null,Object? language = freezed,Object? pushEnabled = freezed,}) {
  return _then(_MerchantPreferences(
dailySettlementReport: freezed == dailySettlementReport ? _self.dailySettlementReport : dailySettlementReport // ignore: cast_nullable_to_non_nullable
as bool?,monthlySettlementReport: freezed == monthlySettlementReport ? _self.monthlySettlementReport : monthlySettlementReport // ignore: cast_nullable_to_non_nullable
as bool?,reportRecipients: null == reportRecipients ? _self._reportRecipients : reportRecipients // ignore: cast_nullable_to_non_nullable
as List<String>,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,pushEnabled: freezed == pushEnabled ? _self.pushEnabled : pushEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$StatementResponse {

 String? get id; String? get period; num? get grossSales; num? get fees; num? get netSettled; int? get settlementCount; String? get generatedAt;
/// Create a copy of StatementResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatementResponseCopyWith<StatementResponse> get copyWith => _$StatementResponseCopyWithImpl<StatementResponse>(this as StatementResponse, _$identity);

  /// Serializes this StatementResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatementResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.period, period) || other.period == period)&&(identical(other.grossSales, grossSales) || other.grossSales == grossSales)&&(identical(other.fees, fees) || other.fees == fees)&&(identical(other.netSettled, netSettled) || other.netSettled == netSettled)&&(identical(other.settlementCount, settlementCount) || other.settlementCount == settlementCount)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,period,grossSales,fees,netSettled,settlementCount,generatedAt);

@override
String toString() {
  return 'StatementResponse(id: $id, period: $period, grossSales: $grossSales, fees: $fees, netSettled: $netSettled, settlementCount: $settlementCount, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class $StatementResponseCopyWith<$Res>  {
  factory $StatementResponseCopyWith(StatementResponse value, $Res Function(StatementResponse) _then) = _$StatementResponseCopyWithImpl;
@useResult
$Res call({
 String? id, String? period, num? grossSales, num? fees, num? netSettled, int? settlementCount, String? generatedAt
});




}
/// @nodoc
class _$StatementResponseCopyWithImpl<$Res>
    implements $StatementResponseCopyWith<$Res> {
  _$StatementResponseCopyWithImpl(this._self, this._then);

  final StatementResponse _self;
  final $Res Function(StatementResponse) _then;

/// Create a copy of StatementResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? period = freezed,Object? grossSales = freezed,Object? fees = freezed,Object? netSettled = freezed,Object? settlementCount = freezed,Object? generatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,grossSales: freezed == grossSales ? _self.grossSales : grossSales // ignore: cast_nullable_to_non_nullable
as num?,fees: freezed == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as num?,netSettled: freezed == netSettled ? _self.netSettled : netSettled // ignore: cast_nullable_to_non_nullable
as num?,settlementCount: freezed == settlementCount ? _self.settlementCount : settlementCount // ignore: cast_nullable_to_non_nullable
as int?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StatementResponse].
extension StatementResponsePatterns on StatementResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatementResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatementResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatementResponse value)  $default,){
final _that = this;
switch (_that) {
case _StatementResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatementResponse value)?  $default,){
final _that = this;
switch (_that) {
case _StatementResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? period,  num? grossSales,  num? fees,  num? netSettled,  int? settlementCount,  String? generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatementResponse() when $default != null:
return $default(_that.id,_that.period,_that.grossSales,_that.fees,_that.netSettled,_that.settlementCount,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? period,  num? grossSales,  num? fees,  num? netSettled,  int? settlementCount,  String? generatedAt)  $default,) {final _that = this;
switch (_that) {
case _StatementResponse():
return $default(_that.id,_that.period,_that.grossSales,_that.fees,_that.netSettled,_that.settlementCount,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? period,  num? grossSales,  num? fees,  num? netSettled,  int? settlementCount,  String? generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _StatementResponse() when $default != null:
return $default(_that.id,_that.period,_that.grossSales,_that.fees,_that.netSettled,_that.settlementCount,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatementResponse implements StatementResponse {
  const _StatementResponse({this.id, this.period, this.grossSales, this.fees, this.netSettled, this.settlementCount, this.generatedAt});
  factory _StatementResponse.fromJson(Map<String, dynamic> json) => _$StatementResponseFromJson(json);

@override final  String? id;
@override final  String? period;
@override final  num? grossSales;
@override final  num? fees;
@override final  num? netSettled;
@override final  int? settlementCount;
@override final  String? generatedAt;

/// Create a copy of StatementResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatementResponseCopyWith<_StatementResponse> get copyWith => __$StatementResponseCopyWithImpl<_StatementResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatementResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatementResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.period, period) || other.period == period)&&(identical(other.grossSales, grossSales) || other.grossSales == grossSales)&&(identical(other.fees, fees) || other.fees == fees)&&(identical(other.netSettled, netSettled) || other.netSettled == netSettled)&&(identical(other.settlementCount, settlementCount) || other.settlementCount == settlementCount)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,period,grossSales,fees,netSettled,settlementCount,generatedAt);

@override
String toString() {
  return 'StatementResponse(id: $id, period: $period, grossSales: $grossSales, fees: $fees, netSettled: $netSettled, settlementCount: $settlementCount, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$StatementResponseCopyWith<$Res> implements $StatementResponseCopyWith<$Res> {
  factory _$StatementResponseCopyWith(_StatementResponse value, $Res Function(_StatementResponse) _then) = __$StatementResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? period, num? grossSales, num? fees, num? netSettled, int? settlementCount, String? generatedAt
});




}
/// @nodoc
class __$StatementResponseCopyWithImpl<$Res>
    implements _$StatementResponseCopyWith<$Res> {
  __$StatementResponseCopyWithImpl(this._self, this._then);

  final _StatementResponse _self;
  final $Res Function(_StatementResponse) _then;

/// Create a copy of StatementResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? period = freezed,Object? grossSales = freezed,Object? fees = freezed,Object? netSettled = freezed,Object? settlementCount = freezed,Object? generatedAt = freezed,}) {
  return _then(_StatementResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,grossSales: freezed == grossSales ? _self.grossSales : grossSales // ignore: cast_nullable_to_non_nullable
as num?,fees: freezed == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as num?,netSettled: freezed == netSettled ? _self.netSettled : netSettled // ignore: cast_nullable_to_non_nullable
as num?,settlementCount: freezed == settlementCount ? _self.settlementCount : settlementCount // ignore: cast_nullable_to_non_nullable
as int?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NotificationItem {

 String? get id; String? get type; String? get title; String? get body; String? get reference; bool get read; String? get createdAt;// Suspicious-activity alerts (type == SUSPICIOUS_ACTIVITY) only.
 String? get severity; String? get rule; Map<String, dynamic>? get evidence; bool get acknowledged;
/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationItemCopyWith<NotificationItem> get copyWith => _$NotificationItemCopyWithImpl<NotificationItem>(this as NotificationItem, _$identity);

  /// Serializes this NotificationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.read, read) || other.read == read)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.rule, rule) || other.rule == rule)&&const DeepCollectionEquality().equals(other.evidence, evidence)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,body,reference,read,createdAt,severity,rule,const DeepCollectionEquality().hash(evidence),acknowledged);

@override
String toString() {
  return 'NotificationItem(id: $id, type: $type, title: $title, body: $body, reference: $reference, read: $read, createdAt: $createdAt, severity: $severity, rule: $rule, evidence: $evidence, acknowledged: $acknowledged)';
}


}

/// @nodoc
abstract mixin class $NotificationItemCopyWith<$Res>  {
  factory $NotificationItemCopyWith(NotificationItem value, $Res Function(NotificationItem) _then) = _$NotificationItemCopyWithImpl;
@useResult
$Res call({
 String? id, String? type, String? title, String? body, String? reference, bool read, String? createdAt, String? severity, String? rule, Map<String, dynamic>? evidence, bool acknowledged
});




}
/// @nodoc
class _$NotificationItemCopyWithImpl<$Res>
    implements $NotificationItemCopyWith<$Res> {
  _$NotificationItemCopyWithImpl(this._self, this._then);

  final NotificationItem _self;
  final $Res Function(NotificationItem) _then;

/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? type = freezed,Object? title = freezed,Object? body = freezed,Object? reference = freezed,Object? read = null,Object? createdAt = freezed,Object? severity = freezed,Object? rule = freezed,Object? evidence = freezed,Object? acknowledged = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,rule: freezed == rule ? _self.rule : rule // ignore: cast_nullable_to_non_nullable
as String?,evidence: freezed == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,acknowledged: null == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationItem].
extension NotificationItemPatterns on NotificationItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationItem value)  $default,){
final _that = this;
switch (_that) {
case _NotificationItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationItem value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? type,  String? title,  String? body,  String? reference,  bool read,  String? createdAt,  String? severity,  String? rule,  Map<String, dynamic>? evidence,  bool acknowledged)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.body,_that.reference,_that.read,_that.createdAt,_that.severity,_that.rule,_that.evidence,_that.acknowledged);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? type,  String? title,  String? body,  String? reference,  bool read,  String? createdAt,  String? severity,  String? rule,  Map<String, dynamic>? evidence,  bool acknowledged)  $default,) {final _that = this;
switch (_that) {
case _NotificationItem():
return $default(_that.id,_that.type,_that.title,_that.body,_that.reference,_that.read,_that.createdAt,_that.severity,_that.rule,_that.evidence,_that.acknowledged);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? type,  String? title,  String? body,  String? reference,  bool read,  String? createdAt,  String? severity,  String? rule,  Map<String, dynamic>? evidence,  bool acknowledged)?  $default,) {final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.body,_that.reference,_that.read,_that.createdAt,_that.severity,_that.rule,_that.evidence,_that.acknowledged);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationItem extends NotificationItem {
  const _NotificationItem({this.id, this.type, this.title, this.body, this.reference, this.read = false, this.createdAt, this.severity, this.rule, final  Map<String, dynamic>? evidence, this.acknowledged = false}): _evidence = evidence,super._();
  factory _NotificationItem.fromJson(Map<String, dynamic> json) => _$NotificationItemFromJson(json);

@override final  String? id;
@override final  String? type;
@override final  String? title;
@override final  String? body;
@override final  String? reference;
@override@JsonKey() final  bool read;
@override final  String? createdAt;
// Suspicious-activity alerts (type == SUSPICIOUS_ACTIVITY) only.
@override final  String? severity;
@override final  String? rule;
 final  Map<String, dynamic>? _evidence;
@override Map<String, dynamic>? get evidence {
  final value = _evidence;
  if (value == null) return null;
  if (_evidence is EqualUnmodifiableMapView) return _evidence;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  bool acknowledged;

/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationItemCopyWith<_NotificationItem> get copyWith => __$NotificationItemCopyWithImpl<_NotificationItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.read, read) || other.read == read)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.rule, rule) || other.rule == rule)&&const DeepCollectionEquality().equals(other._evidence, _evidence)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,body,reference,read,createdAt,severity,rule,const DeepCollectionEquality().hash(_evidence),acknowledged);

@override
String toString() {
  return 'NotificationItem(id: $id, type: $type, title: $title, body: $body, reference: $reference, read: $read, createdAt: $createdAt, severity: $severity, rule: $rule, evidence: $evidence, acknowledged: $acknowledged)';
}


}

/// @nodoc
abstract mixin class _$NotificationItemCopyWith<$Res> implements $NotificationItemCopyWith<$Res> {
  factory _$NotificationItemCopyWith(_NotificationItem value, $Res Function(_NotificationItem) _then) = __$NotificationItemCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? type, String? title, String? body, String? reference, bool read, String? createdAt, String? severity, String? rule, Map<String, dynamic>? evidence, bool acknowledged
});




}
/// @nodoc
class __$NotificationItemCopyWithImpl<$Res>
    implements _$NotificationItemCopyWith<$Res> {
  __$NotificationItemCopyWithImpl(this._self, this._then);

  final _NotificationItem _self;
  final $Res Function(_NotificationItem) _then;

/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? type = freezed,Object? title = freezed,Object? body = freezed,Object? reference = freezed,Object? read = null,Object? createdAt = freezed,Object? severity = freezed,Object? rule = freezed,Object? evidence = freezed,Object? acknowledged = null,}) {
  return _then(_NotificationItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,rule: freezed == rule ? _self.rule : rule // ignore: cast_nullable_to_non_nullable
as String?,evidence: freezed == evidence ? _self._evidence : evidence // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,acknowledged: null == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NotificationFeed {

 int get unreadCount; List<NotificationItem> get content; int? get totalElements; int? get number; int? get size; bool? get last;
/// Create a copy of NotificationFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationFeedCopyWith<NotificationFeed> get copyWith => _$NotificationFeedCopyWithImpl<NotificationFeed>(this as NotificationFeed, _$identity);

  /// Serializes this NotificationFeed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationFeed&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.number, number) || other.number == number)&&(identical(other.size, size) || other.size == size)&&(identical(other.last, last) || other.last == last));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unreadCount,const DeepCollectionEquality().hash(content),totalElements,number,size,last);

@override
String toString() {
  return 'NotificationFeed(unreadCount: $unreadCount, content: $content, totalElements: $totalElements, number: $number, size: $size, last: $last)';
}


}

/// @nodoc
abstract mixin class $NotificationFeedCopyWith<$Res>  {
  factory $NotificationFeedCopyWith(NotificationFeed value, $Res Function(NotificationFeed) _then) = _$NotificationFeedCopyWithImpl;
@useResult
$Res call({
 int unreadCount, List<NotificationItem> content, int? totalElements, int? number, int? size, bool? last
});




}
/// @nodoc
class _$NotificationFeedCopyWithImpl<$Res>
    implements $NotificationFeedCopyWith<$Res> {
  _$NotificationFeedCopyWithImpl(this._self, this._then);

  final NotificationFeed _self;
  final $Res Function(NotificationFeed) _then;

/// Create a copy of NotificationFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unreadCount = null,Object? content = null,Object? totalElements = freezed,Object? number = freezed,Object? size = freezed,Object? last = freezed,}) {
  return _then(_self.copyWith(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<NotificationItem>,totalElements: freezed == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int?,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,last: freezed == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationFeed].
extension NotificationFeedPatterns on NotificationFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationFeed value)  $default,){
final _that = this;
switch (_that) {
case _NotificationFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationFeed value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int unreadCount,  List<NotificationItem> content,  int? totalElements,  int? number,  int? size,  bool? last)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationFeed() when $default != null:
return $default(_that.unreadCount,_that.content,_that.totalElements,_that.number,_that.size,_that.last);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int unreadCount,  List<NotificationItem> content,  int? totalElements,  int? number,  int? size,  bool? last)  $default,) {final _that = this;
switch (_that) {
case _NotificationFeed():
return $default(_that.unreadCount,_that.content,_that.totalElements,_that.number,_that.size,_that.last);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int unreadCount,  List<NotificationItem> content,  int? totalElements,  int? number,  int? size,  bool? last)?  $default,) {final _that = this;
switch (_that) {
case _NotificationFeed() when $default != null:
return $default(_that.unreadCount,_that.content,_that.totalElements,_that.number,_that.size,_that.last);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationFeed implements NotificationFeed {
  const _NotificationFeed({this.unreadCount = 0, final  List<NotificationItem> content = const <NotificationItem>[], this.totalElements, this.number, this.size, this.last}): _content = content;
  factory _NotificationFeed.fromJson(Map<String, dynamic> json) => _$NotificationFeedFromJson(json);

@override@JsonKey() final  int unreadCount;
 final  List<NotificationItem> _content;
@override@JsonKey() List<NotificationItem> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

@override final  int? totalElements;
@override final  int? number;
@override final  int? size;
@override final  bool? last;

/// Create a copy of NotificationFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationFeedCopyWith<_NotificationFeed> get copyWith => __$NotificationFeedCopyWithImpl<_NotificationFeed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationFeedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationFeed&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&const DeepCollectionEquality().equals(other._content, _content)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.number, number) || other.number == number)&&(identical(other.size, size) || other.size == size)&&(identical(other.last, last) || other.last == last));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unreadCount,const DeepCollectionEquality().hash(_content),totalElements,number,size,last);

@override
String toString() {
  return 'NotificationFeed(unreadCount: $unreadCount, content: $content, totalElements: $totalElements, number: $number, size: $size, last: $last)';
}


}

/// @nodoc
abstract mixin class _$NotificationFeedCopyWith<$Res> implements $NotificationFeedCopyWith<$Res> {
  factory _$NotificationFeedCopyWith(_NotificationFeed value, $Res Function(_NotificationFeed) _then) = __$NotificationFeedCopyWithImpl;
@override @useResult
$Res call({
 int unreadCount, List<NotificationItem> content, int? totalElements, int? number, int? size, bool? last
});




}
/// @nodoc
class __$NotificationFeedCopyWithImpl<$Res>
    implements _$NotificationFeedCopyWith<$Res> {
  __$NotificationFeedCopyWithImpl(this._self, this._then);

  final _NotificationFeed _self;
  final $Res Function(_NotificationFeed) _then;

/// Create a copy of NotificationFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unreadCount = null,Object? content = null,Object? totalElements = freezed,Object? number = freezed,Object? size = freezed,Object? last = freezed,}) {
  return _then(_NotificationFeed(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<NotificationItem>,totalElements: freezed == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int?,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,last: freezed == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
