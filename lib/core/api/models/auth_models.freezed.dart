// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginRequest {

 String get email; String get password;
/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRequestCopyWith<LoginRequest> get copyWith => _$LoginRequestCopyWithImpl<LoginRequest>(this as LoginRequest, _$identity);

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'LoginRequest(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginRequestCopyWith<$Res>  {
  factory $LoginRequestCopyWith(LoginRequest value, $Res Function(LoginRequest) _then) = _$LoginRequestCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$LoginRequestCopyWithImpl<$Res>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._self, this._then);

  final LoginRequest _self;
  final $Res Function(LoginRequest) _then;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginRequest].
extension LoginRequestPatterns on LoginRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginRequest value)  $default,){
final _that = this;
switch (_that) {
case _LoginRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
return $default(_that.email,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password)  $default,) {final _that = this;
switch (_that) {
case _LoginRequest():
return $default(_that.email,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password)?  $default,) {final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
return $default(_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginRequest implements LoginRequest {
  const _LoginRequest({required this.email, required this.password});
  factory _LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

@override final  String email;
@override final  String password;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginRequestCopyWith<_LoginRequest> get copyWith => __$LoginRequestCopyWithImpl<_LoginRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'LoginRequest(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$LoginRequestCopyWith<$Res> implements $LoginRequestCopyWith<$Res> {
  factory _$LoginRequestCopyWith(_LoginRequest value, $Res Function(_LoginRequest) _then) = __$LoginRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$LoginRequestCopyWithImpl<$Res>
    implements _$LoginRequestCopyWith<$Res> {
  __$LoginRequestCopyWithImpl(this._self, this._then);

  final _LoginRequest _self;
  final $Res Function(_LoginRequest) _then;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_LoginRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SelectTenantRequest {

 String get tenantId;
/// Create a copy of SelectTenantRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectTenantRequestCopyWith<SelectTenantRequest> get copyWith => _$SelectTenantRequestCopyWithImpl<SelectTenantRequest>(this as SelectTenantRequest, _$identity);

  /// Serializes this SelectTenantRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectTenantRequest&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tenantId);

@override
String toString() {
  return 'SelectTenantRequest(tenantId: $tenantId)';
}


}

/// @nodoc
abstract mixin class $SelectTenantRequestCopyWith<$Res>  {
  factory $SelectTenantRequestCopyWith(SelectTenantRequest value, $Res Function(SelectTenantRequest) _then) = _$SelectTenantRequestCopyWithImpl;
@useResult
$Res call({
 String tenantId
});




}
/// @nodoc
class _$SelectTenantRequestCopyWithImpl<$Res>
    implements $SelectTenantRequestCopyWith<$Res> {
  _$SelectTenantRequestCopyWithImpl(this._self, this._then);

  final SelectTenantRequest _self;
  final $Res Function(SelectTenantRequest) _then;

/// Create a copy of SelectTenantRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tenantId = null,}) {
  return _then(_self.copyWith(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectTenantRequest].
extension SelectTenantRequestPatterns on SelectTenantRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectTenantRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectTenantRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectTenantRequest value)  $default,){
final _that = this;
switch (_that) {
case _SelectTenantRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectTenantRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SelectTenantRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tenantId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectTenantRequest() when $default != null:
return $default(_that.tenantId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tenantId)  $default,) {final _that = this;
switch (_that) {
case _SelectTenantRequest():
return $default(_that.tenantId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tenantId)?  $default,) {final _that = this;
switch (_that) {
case _SelectTenantRequest() when $default != null:
return $default(_that.tenantId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelectTenantRequest implements SelectTenantRequest {
  const _SelectTenantRequest({required this.tenantId});
  factory _SelectTenantRequest.fromJson(Map<String, dynamic> json) => _$SelectTenantRequestFromJson(json);

@override final  String tenantId;

/// Create a copy of SelectTenantRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectTenantRequestCopyWith<_SelectTenantRequest> get copyWith => __$SelectTenantRequestCopyWithImpl<_SelectTenantRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectTenantRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectTenantRequest&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tenantId);

@override
String toString() {
  return 'SelectTenantRequest(tenantId: $tenantId)';
}


}

/// @nodoc
abstract mixin class _$SelectTenantRequestCopyWith<$Res> implements $SelectTenantRequestCopyWith<$Res> {
  factory _$SelectTenantRequestCopyWith(_SelectTenantRequest value, $Res Function(_SelectTenantRequest) _then) = __$SelectTenantRequestCopyWithImpl;
@override @useResult
$Res call({
 String tenantId
});




}
/// @nodoc
class __$SelectTenantRequestCopyWithImpl<$Res>
    implements _$SelectTenantRequestCopyWith<$Res> {
  __$SelectTenantRequestCopyWithImpl(this._self, this._then);

  final _SelectTenantRequest _self;
  final $Res Function(_SelectTenantRequest) _then;

/// Create a copy of SelectTenantRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tenantId = null,}) {
  return _then(_SelectTenantRequest(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChangePasswordRequest {

 String get currentPassword; String get newPassword;
/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordRequestCopyWith<ChangePasswordRequest> get copyWith => _$ChangePasswordRequestCopyWithImpl<ChangePasswordRequest>(this as ChangePasswordRequest, _$identity);

  /// Serializes this ChangePasswordRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordRequest&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPassword,newPassword);

@override
String toString() {
  return 'ChangePasswordRequest(currentPassword: $currentPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordRequestCopyWith<$Res>  {
  factory $ChangePasswordRequestCopyWith(ChangePasswordRequest value, $Res Function(ChangePasswordRequest) _then) = _$ChangePasswordRequestCopyWithImpl;
@useResult
$Res call({
 String currentPassword, String newPassword
});




}
/// @nodoc
class _$ChangePasswordRequestCopyWithImpl<$Res>
    implements $ChangePasswordRequestCopyWith<$Res> {
  _$ChangePasswordRequestCopyWithImpl(this._self, this._then);

  final ChangePasswordRequest _self;
  final $Res Function(ChangePasswordRequest) _then;

/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPassword = null,Object? newPassword = null,}) {
  return _then(_self.copyWith(
currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangePasswordRequest].
extension ChangePasswordRequestPatterns on ChangePasswordRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePasswordRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePasswordRequest value)  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePasswordRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currentPassword,  String newPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
return $default(_that.currentPassword,_that.newPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currentPassword,  String newPassword)  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordRequest():
return $default(_that.currentPassword,_that.newPassword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currentPassword,  String newPassword)?  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
return $default(_that.currentPassword,_that.newPassword);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangePasswordRequest implements ChangePasswordRequest {
  const _ChangePasswordRequest({required this.currentPassword, required this.newPassword});
  factory _ChangePasswordRequest.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestFromJson(json);

@override final  String currentPassword;
@override final  String newPassword;

/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePasswordRequestCopyWith<_ChangePasswordRequest> get copyWith => __$ChangePasswordRequestCopyWithImpl<_ChangePasswordRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangePasswordRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePasswordRequest&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPassword,newPassword);

@override
String toString() {
  return 'ChangePasswordRequest(currentPassword: $currentPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$ChangePasswordRequestCopyWith<$Res> implements $ChangePasswordRequestCopyWith<$Res> {
  factory _$ChangePasswordRequestCopyWith(_ChangePasswordRequest value, $Res Function(_ChangePasswordRequest) _then) = __$ChangePasswordRequestCopyWithImpl;
@override @useResult
$Res call({
 String currentPassword, String newPassword
});




}
/// @nodoc
class __$ChangePasswordRequestCopyWithImpl<$Res>
    implements _$ChangePasswordRequestCopyWith<$Res> {
  __$ChangePasswordRequestCopyWithImpl(this._self, this._then);

  final _ChangePasswordRequest _self;
  final $Res Function(_ChangePasswordRequest) _then;

/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPassword = null,Object? newPassword = null,}) {
  return _then(_ChangePasswordRequest(
currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AuthResponse {

 String? get accessToken; String? get refreshToken; String? get tokenType; int? get expiresIn; String? get userId; String? get email; String? get firstName; String? get lastName; String? get role; bool? get emailVerified; String? get selectedTenantId; String? get selectedTenantName; String? get mid; String? get message;
/// Create a copy of AuthResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResponseCopyWith<AuthResponse> get copyWith => _$AuthResponseCopyWithImpl<AuthResponse>(this as AuthResponse, _$identity);

  /// Serializes this AuthResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResponse&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.role, role) || other.role == role)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.selectedTenantId, selectedTenantId) || other.selectedTenantId == selectedTenantId)&&(identical(other.selectedTenantName, selectedTenantName) || other.selectedTenantName == selectedTenantName)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,tokenType,expiresIn,userId,email,firstName,lastName,role,emailVerified,selectedTenantId,selectedTenantName,mid,message);

@override
String toString() {
  return 'AuthResponse(accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, expiresIn: $expiresIn, userId: $userId, email: $email, firstName: $firstName, lastName: $lastName, role: $role, emailVerified: $emailVerified, selectedTenantId: $selectedTenantId, selectedTenantName: $selectedTenantName, mid: $mid, message: $message)';
}


}

/// @nodoc
abstract mixin class $AuthResponseCopyWith<$Res>  {
  factory $AuthResponseCopyWith(AuthResponse value, $Res Function(AuthResponse) _then) = _$AuthResponseCopyWithImpl;
@useResult
$Res call({
 String? accessToken, String? refreshToken, String? tokenType, int? expiresIn, String? userId, String? email, String? firstName, String? lastName, String? role, bool? emailVerified, String? selectedTenantId, String? selectedTenantName, String? mid, String? message
});




}
/// @nodoc
class _$AuthResponseCopyWithImpl<$Res>
    implements $AuthResponseCopyWith<$Res> {
  _$AuthResponseCopyWithImpl(this._self, this._then);

  final AuthResponse _self;
  final $Res Function(AuthResponse) _then;

/// Create a copy of AuthResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,Object? tokenType = freezed,Object? expiresIn = freezed,Object? userId = freezed,Object? email = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? role = freezed,Object? emailVerified = freezed,Object? selectedTenantId = freezed,Object? selectedTenantName = freezed,Object? mid = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: freezed == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool?,selectedTenantId: freezed == selectedTenantId ? _self.selectedTenantId : selectedTenantId // ignore: cast_nullable_to_non_nullable
as String?,selectedTenantName: freezed == selectedTenantName ? _self.selectedTenantName : selectedTenantName // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthResponse].
extension AuthResponsePatterns on AuthResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthResponse value)  $default,){
final _that = this;
switch (_that) {
case _AuthResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AuthResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? accessToken,  String? refreshToken,  String? tokenType,  int? expiresIn,  String? userId,  String? email,  String? firstName,  String? lastName,  String? role,  bool? emailVerified,  String? selectedTenantId,  String? selectedTenantName,  String? mid,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthResponse() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.tokenType,_that.expiresIn,_that.userId,_that.email,_that.firstName,_that.lastName,_that.role,_that.emailVerified,_that.selectedTenantId,_that.selectedTenantName,_that.mid,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? accessToken,  String? refreshToken,  String? tokenType,  int? expiresIn,  String? userId,  String? email,  String? firstName,  String? lastName,  String? role,  bool? emailVerified,  String? selectedTenantId,  String? selectedTenantName,  String? mid,  String? message)  $default,) {final _that = this;
switch (_that) {
case _AuthResponse():
return $default(_that.accessToken,_that.refreshToken,_that.tokenType,_that.expiresIn,_that.userId,_that.email,_that.firstName,_that.lastName,_that.role,_that.emailVerified,_that.selectedTenantId,_that.selectedTenantName,_that.mid,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? accessToken,  String? refreshToken,  String? tokenType,  int? expiresIn,  String? userId,  String? email,  String? firstName,  String? lastName,  String? role,  bool? emailVerified,  String? selectedTenantId,  String? selectedTenantName,  String? mid,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AuthResponse() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.tokenType,_that.expiresIn,_that.userId,_that.email,_that.firstName,_that.lastName,_that.role,_that.emailVerified,_that.selectedTenantId,_that.selectedTenantName,_that.mid,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthResponse implements AuthResponse {
  const _AuthResponse({this.accessToken, this.refreshToken, this.tokenType, this.expiresIn, this.userId, this.email, this.firstName, this.lastName, this.role, this.emailVerified, this.selectedTenantId, this.selectedTenantName, this.mid, this.message});
  factory _AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

@override final  String? accessToken;
@override final  String? refreshToken;
@override final  String? tokenType;
@override final  int? expiresIn;
@override final  String? userId;
@override final  String? email;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? role;
@override final  bool? emailVerified;
@override final  String? selectedTenantId;
@override final  String? selectedTenantName;
@override final  String? mid;
@override final  String? message;

/// Create a copy of AuthResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthResponseCopyWith<_AuthResponse> get copyWith => __$AuthResponseCopyWithImpl<_AuthResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResponse&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.role, role) || other.role == role)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.selectedTenantId, selectedTenantId) || other.selectedTenantId == selectedTenantId)&&(identical(other.selectedTenantName, selectedTenantName) || other.selectedTenantName == selectedTenantName)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,tokenType,expiresIn,userId,email,firstName,lastName,role,emailVerified,selectedTenantId,selectedTenantName,mid,message);

@override
String toString() {
  return 'AuthResponse(accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, expiresIn: $expiresIn, userId: $userId, email: $email, firstName: $firstName, lastName: $lastName, role: $role, emailVerified: $emailVerified, selectedTenantId: $selectedTenantId, selectedTenantName: $selectedTenantName, mid: $mid, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AuthResponseCopyWith<$Res> implements $AuthResponseCopyWith<$Res> {
  factory _$AuthResponseCopyWith(_AuthResponse value, $Res Function(_AuthResponse) _then) = __$AuthResponseCopyWithImpl;
@override @useResult
$Res call({
 String? accessToken, String? refreshToken, String? tokenType, int? expiresIn, String? userId, String? email, String? firstName, String? lastName, String? role, bool? emailVerified, String? selectedTenantId, String? selectedTenantName, String? mid, String? message
});




}
/// @nodoc
class __$AuthResponseCopyWithImpl<$Res>
    implements _$AuthResponseCopyWith<$Res> {
  __$AuthResponseCopyWithImpl(this._self, this._then);

  final _AuthResponse _self;
  final $Res Function(_AuthResponse) _then;

/// Create a copy of AuthResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,Object? tokenType = freezed,Object? expiresIn = freezed,Object? userId = freezed,Object? email = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? role = freezed,Object? emailVerified = freezed,Object? selectedTenantId = freezed,Object? selectedTenantName = freezed,Object? mid = freezed,Object? message = freezed,}) {
  return _then(_AuthResponse(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: freezed == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool?,selectedTenantId: freezed == selectedTenantId ? _self.selectedTenantId : selectedTenantId // ignore: cast_nullable_to_non_nullable
as String?,selectedTenantName: freezed == selectedTenantName ? _self.selectedTenantName : selectedTenantName // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TenantInfo {

 String? get id; String? get name; String? get slug; String? get role; bool? get primary;
/// Create a copy of TenantInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantInfoCopyWith<TenantInfo> get copyWith => _$TenantInfoCopyWithImpl<TenantInfo>(this as TenantInfo, _$identity);

  /// Serializes this TenantInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.role, role) || other.role == role)&&(identical(other.primary, primary) || other.primary == primary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,role,primary);

@override
String toString() {
  return 'TenantInfo(id: $id, name: $name, slug: $slug, role: $role, primary: $primary)';
}


}

/// @nodoc
abstract mixin class $TenantInfoCopyWith<$Res>  {
  factory $TenantInfoCopyWith(TenantInfo value, $Res Function(TenantInfo) _then) = _$TenantInfoCopyWithImpl;
@useResult
$Res call({
 String? id, String? name, String? slug, String? role, bool? primary
});




}
/// @nodoc
class _$TenantInfoCopyWithImpl<$Res>
    implements $TenantInfoCopyWith<$Res> {
  _$TenantInfoCopyWithImpl(this._self, this._then);

  final TenantInfo _self;
  final $Res Function(TenantInfo) _then;

/// Create a copy of TenantInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? slug = freezed,Object? role = freezed,Object? primary = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,primary: freezed == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantInfo].
extension TenantInfoPatterns on TenantInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantInfo value)  $default,){
final _that = this;
switch (_that) {
case _TenantInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantInfo value)?  $default,){
final _that = this;
switch (_that) {
case _TenantInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? name,  String? slug,  String? role,  bool? primary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantInfo() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.role,_that.primary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? name,  String? slug,  String? role,  bool? primary)  $default,) {final _that = this;
switch (_that) {
case _TenantInfo():
return $default(_that.id,_that.name,_that.slug,_that.role,_that.primary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? name,  String? slug,  String? role,  bool? primary)?  $default,) {final _that = this;
switch (_that) {
case _TenantInfo() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.role,_that.primary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantInfo implements TenantInfo {
  const _TenantInfo({this.id, this.name, this.slug, this.role, this.primary});
  factory _TenantInfo.fromJson(Map<String, dynamic> json) => _$TenantInfoFromJson(json);

@override final  String? id;
@override final  String? name;
@override final  String? slug;
@override final  String? role;
@override final  bool? primary;

/// Create a copy of TenantInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantInfoCopyWith<_TenantInfo> get copyWith => __$TenantInfoCopyWithImpl<_TenantInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.role, role) || other.role == role)&&(identical(other.primary, primary) || other.primary == primary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,role,primary);

@override
String toString() {
  return 'TenantInfo(id: $id, name: $name, slug: $slug, role: $role, primary: $primary)';
}


}

/// @nodoc
abstract mixin class _$TenantInfoCopyWith<$Res> implements $TenantInfoCopyWith<$Res> {
  factory _$TenantInfoCopyWith(_TenantInfo value, $Res Function(_TenantInfo) _then) = __$TenantInfoCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name, String? slug, String? role, bool? primary
});




}
/// @nodoc
class __$TenantInfoCopyWithImpl<$Res>
    implements _$TenantInfoCopyWith<$Res> {
  __$TenantInfoCopyWithImpl(this._self, this._then);

  final _TenantInfo _self;
  final $Res Function(_TenantInfo) _then;

/// Create a copy of TenantInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? slug = freezed,Object? role = freezed,Object? primary = freezed,}) {
  return _then(_TenantInfo(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,primary: freezed == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$UserInfoResponse {

 String? get id; String? get email; String? get firstName; String? get lastName; String? get role; bool? get emailVerified; String? get primaryTenantId; String? get mid; String? get merchantName; String? get phone; List<String> get permissions; List<TenantInfo> get tenants;
/// Create a copy of UserInfoResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInfoResponseCopyWith<UserInfoResponse> get copyWith => _$UserInfoResponseCopyWithImpl<UserInfoResponse>(this as UserInfoResponse, _$identity);

  /// Serializes this UserInfoResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInfoResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.role, role) || other.role == role)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.primaryTenantId, primaryTenantId) || other.primaryTenantId == primaryTenantId)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other.permissions, permissions)&&const DeepCollectionEquality().equals(other.tenants, tenants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,role,emailVerified,primaryTenantId,mid,merchantName,phone,const DeepCollectionEquality().hash(permissions),const DeepCollectionEquality().hash(tenants));

@override
String toString() {
  return 'UserInfoResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, role: $role, emailVerified: $emailVerified, primaryTenantId: $primaryTenantId, mid: $mid, merchantName: $merchantName, phone: $phone, permissions: $permissions, tenants: $tenants)';
}


}

/// @nodoc
abstract mixin class $UserInfoResponseCopyWith<$Res>  {
  factory $UserInfoResponseCopyWith(UserInfoResponse value, $Res Function(UserInfoResponse) _then) = _$UserInfoResponseCopyWithImpl;
@useResult
$Res call({
 String? id, String? email, String? firstName, String? lastName, String? role, bool? emailVerified, String? primaryTenantId, String? mid, String? merchantName, String? phone, List<String> permissions, List<TenantInfo> tenants
});




}
/// @nodoc
class _$UserInfoResponseCopyWithImpl<$Res>
    implements $UserInfoResponseCopyWith<$Res> {
  _$UserInfoResponseCopyWithImpl(this._self, this._then);

  final UserInfoResponse _self;
  final $Res Function(UserInfoResponse) _then;

/// Create a copy of UserInfoResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? email = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? role = freezed,Object? emailVerified = freezed,Object? primaryTenantId = freezed,Object? mid = freezed,Object? merchantName = freezed,Object? phone = freezed,Object? permissions = null,Object? tenants = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: freezed == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool?,primaryTenantId: freezed == primaryTenantId ? _self.primaryTenantId : primaryTenantId // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,tenants: null == tenants ? _self.tenants : tenants // ignore: cast_nullable_to_non_nullable
as List<TenantInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInfoResponse].
extension UserInfoResponsePatterns on UserInfoResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserInfoResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInfoResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserInfoResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserInfoResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserInfoResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserInfoResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? email,  String? firstName,  String? lastName,  String? role,  bool? emailVerified,  String? primaryTenantId,  String? mid,  String? merchantName,  String? phone,  List<String> permissions,  List<TenantInfo> tenants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInfoResponse() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.role,_that.emailVerified,_that.primaryTenantId,_that.mid,_that.merchantName,_that.phone,_that.permissions,_that.tenants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? email,  String? firstName,  String? lastName,  String? role,  bool? emailVerified,  String? primaryTenantId,  String? mid,  String? merchantName,  String? phone,  List<String> permissions,  List<TenantInfo> tenants)  $default,) {final _that = this;
switch (_that) {
case _UserInfoResponse():
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.role,_that.emailVerified,_that.primaryTenantId,_that.mid,_that.merchantName,_that.phone,_that.permissions,_that.tenants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? email,  String? firstName,  String? lastName,  String? role,  bool? emailVerified,  String? primaryTenantId,  String? mid,  String? merchantName,  String? phone,  List<String> permissions,  List<TenantInfo> tenants)?  $default,) {final _that = this;
switch (_that) {
case _UserInfoResponse() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.role,_that.emailVerified,_that.primaryTenantId,_that.mid,_that.merchantName,_that.phone,_that.permissions,_that.tenants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserInfoResponse implements UserInfoResponse {
  const _UserInfoResponse({this.id, this.email, this.firstName, this.lastName, this.role, this.emailVerified, this.primaryTenantId, this.mid, this.merchantName, this.phone, final  List<String> permissions = const <String>[], final  List<TenantInfo> tenants = const <TenantInfo>[]}): _permissions = permissions,_tenants = tenants;
  factory _UserInfoResponse.fromJson(Map<String, dynamic> json) => _$UserInfoResponseFromJson(json);

@override final  String? id;
@override final  String? email;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? role;
@override final  bool? emailVerified;
@override final  String? primaryTenantId;
@override final  String? mid;
@override final  String? merchantName;
@override final  String? phone;
 final  List<String> _permissions;
@override@JsonKey() List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}

 final  List<TenantInfo> _tenants;
@override@JsonKey() List<TenantInfo> get tenants {
  if (_tenants is EqualUnmodifiableListView) return _tenants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tenants);
}


/// Create a copy of UserInfoResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserInfoResponseCopyWith<_UserInfoResponse> get copyWith => __$UserInfoResponseCopyWithImpl<_UserInfoResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserInfoResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInfoResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.role, role) || other.role == role)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.primaryTenantId, primaryTenantId) || other.primaryTenantId == primaryTenantId)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&const DeepCollectionEquality().equals(other._tenants, _tenants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,role,emailVerified,primaryTenantId,mid,merchantName,phone,const DeepCollectionEquality().hash(_permissions),const DeepCollectionEquality().hash(_tenants));

@override
String toString() {
  return 'UserInfoResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, role: $role, emailVerified: $emailVerified, primaryTenantId: $primaryTenantId, mid: $mid, merchantName: $merchantName, phone: $phone, permissions: $permissions, tenants: $tenants)';
}


}

/// @nodoc
abstract mixin class _$UserInfoResponseCopyWith<$Res> implements $UserInfoResponseCopyWith<$Res> {
  factory _$UserInfoResponseCopyWith(_UserInfoResponse value, $Res Function(_UserInfoResponse) _then) = __$UserInfoResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? email, String? firstName, String? lastName, String? role, bool? emailVerified, String? primaryTenantId, String? mid, String? merchantName, String? phone, List<String> permissions, List<TenantInfo> tenants
});




}
/// @nodoc
class __$UserInfoResponseCopyWithImpl<$Res>
    implements _$UserInfoResponseCopyWith<$Res> {
  __$UserInfoResponseCopyWithImpl(this._self, this._then);

  final _UserInfoResponse _self;
  final $Res Function(_UserInfoResponse) _then;

/// Create a copy of UserInfoResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? email = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? role = freezed,Object? emailVerified = freezed,Object? primaryTenantId = freezed,Object? mid = freezed,Object? merchantName = freezed,Object? phone = freezed,Object? permissions = null,Object? tenants = null,}) {
  return _then(_UserInfoResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: freezed == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool?,primaryTenantId: freezed == primaryTenantId ? _self.primaryTenantId : primaryTenantId // ignore: cast_nullable_to_non_nullable
as String?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,tenants: null == tenants ? _self._tenants : tenants // ignore: cast_nullable_to_non_nullable
as List<TenantInfo>,
  ));
}


}

// dart format on
