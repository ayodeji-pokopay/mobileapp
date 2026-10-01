import 'package:freezed_annotation/freezed_annotation.dart';

import 'lenient.dart';

part 'business_models.freezed.dart';
part 'business_models.g.dart';

@freezed
abstract class TerminalResponse with _$TerminalResponse {
  const factory TerminalResponse({
    String? id,
    String? tid,
    String? serialNumber,
    String? model,
    String? label,
    String? status,
    @LenientBool() bool? instantSettlement,
    String? activatedAt,
    String? lastHeartbeat,
    @LenientNum() num? todaySales,
    @LenientInt() int? todayTransactions,
    // Terminal health (backend verdict + raw telemetry from heartbeats).
    String? connectivity,
    String? health,
    @Default(<String>[]) List<String> healthReasons,
    @LenientInt() int? batteryPercent,
    @LenientBool() bool? charging,
    String? connectionType,
    @LenientInt() int? signal,
    String? printerStatus,
    String? appVersion,
  }) = _TerminalResponse;

  factory TerminalResponse.fromJson(Map<String, dynamic> json) =>
      _$TerminalResponseFromJson(json);
}

@freezed
abstract class MerchantPreferences with _$MerchantPreferences {
  const factory MerchantPreferences({
    @LenientBool() bool? dailySettlementReport,
    @LenientBool() bool? monthlySettlementReport,
    @Default(<String>[]) List<String> reportRecipients,
    String? language,
    @LenientBool() bool? pushEnabled,
    @LenientNum() num? dailyTarget,
    @LenientNum() num? monthlyTarget,
  }) = _MerchantPreferences;

  factory MerchantPreferences.fromJson(Map<String, dynamic> json) =>
      _$MerchantPreferencesFromJson(json);
}

@freezed
abstract class StatementResponse with _$StatementResponse {
  const factory StatementResponse({
    String? id,
    String? period,
    @LenientNum() num? grossSales,
    @LenientNum() num? fees,
    @LenientNum() num? netSettled,
    @LenientInt() int? settlementCount,
    String? generatedAt,
  }) = _StatementResponse;

  factory StatementResponse.fromJson(Map<String, dynamic> json) =>
      _$StatementResponseFromJson(json);
}

@freezed
abstract class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    String? id,
    String? type,
    String? title,
    String? body,
    String? reference,
    @LenientFlag() @Default(false) bool read,
    String? createdAt,
    // Suspicious-activity alerts (type == SUSPICIOUS_ACTIVITY) only.
    String? severity,
    String? rule,
    @LenientMap() Map<String, dynamic>? evidence,
    @LenientFlag() @Default(false) bool acknowledged,
  }) = _NotificationItem;

  const NotificationItem._();

  bool get isAlert => (type ?? '').toUpperCase() == 'SUSPICIOUS_ACTIVITY';
  bool get needsReview => isAlert && !acknowledged;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}

@freezed
abstract class NotificationFeed with _$NotificationFeed {
  const factory NotificationFeed({
    @Default(0) int unreadCount,
    @Default(<NotificationItem>[]) List<NotificationItem> content,
    @LenientInt() int? totalElements,
    @LenientInt() int? number,
    @LenientInt() int? size,
    @LenientBool() bool? last,
  }) = _NotificationFeed;

  factory NotificationFeed.fromJson(Map<String, dynamic> json) =>
      _$NotificationFeedFromJson(json);
}
