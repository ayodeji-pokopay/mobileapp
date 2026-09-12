import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
abstract class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
abstract class SelectTenantRequest with _$SelectTenantRequest {
  const factory SelectTenantRequest({required String tenantId}) =
      _SelectTenantRequest;

  factory SelectTenantRequest.fromJson(Map<String, dynamic> json) =>
      _$SelectTenantRequestFromJson(json);
}

@freezed
abstract class ChangePasswordRequest with _$ChangePasswordRequest {
  const factory ChangePasswordRequest({
    required String currentPassword,
    required String newPassword,
  }) = _ChangePasswordRequest;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
}

@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    String? accessToken,
    String? refreshToken,
    String? tokenType,
    int? expiresIn,
    String? userId,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    bool? emailVerified,
    String? selectedTenantId,
    String? selectedTenantName,
    String? mid,
    String? message,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
abstract class TenantInfo with _$TenantInfo {
  const factory TenantInfo({
    String? id,
    String? name,
    String? slug,
    String? role,
    bool? primary,
  }) = _TenantInfo;

  factory TenantInfo.fromJson(Map<String, dynamic> json) =>
      _$TenantInfoFromJson(json);
}

@freezed
abstract class UserInfoResponse with _$UserInfoResponse {
  const factory UserInfoResponse({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    bool? emailVerified,
    String? primaryTenantId,
    String? mid,
    String? merchantName,
    String? phone,
    @Default(<String>[]) List<String> permissions,
    @Default(<String>[]) List<String> terminalIds,
    @Default(<TenantInfo>[]) List<TenantInfo> tenants,
  }) = _UserInfoResponse;

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
}
