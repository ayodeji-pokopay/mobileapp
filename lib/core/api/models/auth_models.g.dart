// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_SelectTenantRequest _$SelectTenantRequestFromJson(Map<String, dynamic> json) =>
    _SelectTenantRequest(tenantId: json['tenantId'] as String);

Map<String, dynamic> _$SelectTenantRequestToJson(
  _SelectTenantRequest instance,
) => <String, dynamic>{'tenantId': instance.tenantId};

_ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => _ChangePasswordRequest(
  currentPassword: json['currentPassword'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ChangePasswordRequestToJson(
  _ChangePasswordRequest instance,
) => <String, dynamic>{
  'currentPassword': instance.currentPassword,
  'newPassword': instance.newPassword,
};

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      tokenType: json['tokenType'] as String?,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      role: json['role'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      selectedTenantId: json['selectedTenantId'] as String?,
      selectedTenantName: json['selectedTenantName'] as String?,
      mid: json['mid'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
      'userId': instance.userId,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'role': instance.role,
      'emailVerified': instance.emailVerified,
      'selectedTenantId': instance.selectedTenantId,
      'selectedTenantName': instance.selectedTenantName,
      'mid': instance.mid,
      'message': instance.message,
    };

_TenantInfo _$TenantInfoFromJson(Map<String, dynamic> json) => _TenantInfo(
  id: json['id'] as String?,
  name: json['name'] as String?,
  slug: json['slug'] as String?,
  role: json['role'] as String?,
  primary: json['primary'] as bool?,
);

Map<String, dynamic> _$TenantInfoToJson(_TenantInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'role': instance.role,
      'primary': instance.primary,
    };

_UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    _UserInfoResponse(
      id: json['id'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      role: json['role'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      primaryTenantId: json['primaryTenantId'] as String?,
      mid: json['mid'] as String?,
      merchantName: json['merchantName'] as String?,
      phone: json['phone'] as String?,
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      terminalIds:
          (json['terminalIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      tenants:
          (json['tenants'] as List<dynamic>?)
              ?.map((e) => TenantInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TenantInfo>[],
    );

Map<String, dynamic> _$UserInfoResponseToJson(_UserInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'role': instance.role,
      'emailVerified': instance.emailVerified,
      'primaryTenantId': instance.primaryTenantId,
      'mid': instance.mid,
      'merchantName': instance.merchantName,
      'phone': instance.phone,
      'permissions': instance.permissions,
      'terminalIds': instance.terminalIds,
      'tenants': instance.tenants,
    };
