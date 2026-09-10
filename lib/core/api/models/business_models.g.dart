// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TerminalResponse _$TerminalResponseFromJson(Map<String, dynamic> json) =>
    _TerminalResponse(
      id: json['id'] as String?,
      tid: json['tid'] as String?,
      serialNumber: json['serialNumber'] as String?,
      model: json['model'] as String?,
      label: json['label'] as String?,
      status: json['status'] as String?,
      instantSettlement: json['instantSettlement'] as bool?,
      activatedAt: json['activatedAt'] as String?,
      lastHeartbeat: json['lastHeartbeat'] as String?,
      todaySales: json['todaySales'] as num?,
      todayTransactions: (json['todayTransactions'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TerminalResponseToJson(_TerminalResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tid': instance.tid,
      'serialNumber': instance.serialNumber,
      'model': instance.model,
      'label': instance.label,
      'status': instance.status,
      'instantSettlement': instance.instantSettlement,
      'activatedAt': instance.activatedAt,
      'lastHeartbeat': instance.lastHeartbeat,
      'todaySales': instance.todaySales,
      'todayTransactions': instance.todayTransactions,
    };

_MerchantPreferences _$MerchantPreferencesFromJson(Map<String, dynamic> json) =>
    _MerchantPreferences(
      dailySettlementReport: json['dailySettlementReport'] as bool?,
      monthlySettlementReport: json['monthlySettlementReport'] as bool?,
      reportRecipients:
          (json['reportRecipients'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      language: json['language'] as String?,
      pushEnabled: json['pushEnabled'] as bool?,
    );

Map<String, dynamic> _$MerchantPreferencesToJson(
  _MerchantPreferences instance,
) => <String, dynamic>{
  'dailySettlementReport': instance.dailySettlementReport,
  'monthlySettlementReport': instance.monthlySettlementReport,
  'reportRecipients': instance.reportRecipients,
  'language': instance.language,
  'pushEnabled': instance.pushEnabled,
};

_StatementResponse _$StatementResponseFromJson(Map<String, dynamic> json) =>
    _StatementResponse(
      id: json['id'] as String?,
      period: json['period'] as String?,
      grossSales: json['grossSales'] as num?,
      fees: json['fees'] as num?,
      netSettled: json['netSettled'] as num?,
      settlementCount: (json['settlementCount'] as num?)?.toInt(),
      generatedAt: json['generatedAt'] as String?,
    );

Map<String, dynamic> _$StatementResponseToJson(_StatementResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'period': instance.period,
      'grossSales': instance.grossSales,
      'fees': instance.fees,
      'netSettled': instance.netSettled,
      'settlementCount': instance.settlementCount,
      'generatedAt': instance.generatedAt,
    };

_NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    _NotificationItem(
      id: json['id'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      reference: json['reference'] as String?,
      read: json['read'] as bool? ?? false,
      createdAt: json['createdAt'] as String?,
      severity: json['severity'] as String?,
      rule: json['rule'] as String?,
      evidence: json['evidence'] as Map<String, dynamic>?,
      acknowledged: json['acknowledged'] as bool? ?? false,
    );

Map<String, dynamic> _$NotificationItemToJson(_NotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'reference': instance.reference,
      'read': instance.read,
      'createdAt': instance.createdAt,
      'severity': instance.severity,
      'rule': instance.rule,
      'evidence': instance.evidence,
      'acknowledged': instance.acknowledged,
    };

_NotificationFeed _$NotificationFeedFromJson(Map<String, dynamic> json) =>
    _NotificationFeed(
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      content:
          (json['content'] as List<dynamic>?)
              ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NotificationItem>[],
      totalElements: (json['totalElements'] as num?)?.toInt(),
      number: (json['number'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      last: json['last'] as bool?,
    );

Map<String, dynamic> _$NotificationFeedToJson(_NotificationFeed instance) =>
    <String, dynamic>{
      'unreadCount': instance.unreadCount,
      'content': instance.content,
      'totalElements': instance.totalElements,
      'number': instance.number,
      'size': instance.size,
      'last': instance.last,
    };
