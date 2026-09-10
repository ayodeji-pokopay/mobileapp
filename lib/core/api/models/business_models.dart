import 'package:freezed_annotation/freezed_annotation.dart';

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
    bool? instantSettlement,
    String? activatedAt,
    String? lastHeartbeat,
    num? todaySales,
    int? todayTransactions,
  }) = _TerminalResponse;

  factory TerminalResponse.fromJson(Map<String, dynamic> json) =>
      _$TerminalResponseFromJson(json);
}

@freezed
abstract class MerchantPreferences with _$MerchantPreferences {
  const factory MerchantPreferences({
    bool? dailySettlementReport,
    bool? monthlySettlementReport,
    @Default(<String>[]) List<String> reportRecipients,
    String? language,
    bool? pushEnabled,
  }) = _MerchantPreferences;

  factory MerchantPreferences.fromJson(Map<String, dynamic> json) =>
      _$MerchantPreferencesFromJson(json);
}

@freezed
abstract class StatementResponse with _$StatementResponse {
  const factory StatementResponse({
    String? id,
    String? period,
    num? grossSales,
    num? fees,
    num? netSettled,
    int? settlementCount,
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
    @Default(false) bool read,
    String? createdAt,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}

@freezed
abstract class NotificationFeed with _$NotificationFeed {
  const factory NotificationFeed({
    @Default(0) int unreadCount,
    @Default(<NotificationItem>[]) List<NotificationItem> content,
    int? totalElements,
    int? number,
    int? size,
    bool? last,
  }) = _NotificationFeed;

  factory NotificationFeed.fromJson(Map<String, dynamic> json) =>
      _$NotificationFeedFromJson(json);
}
