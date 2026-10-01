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
      instantSettlement: const LenientBool().fromJson(
        json['instantSettlement'],
      ),
      activatedAt: json['activatedAt'] as String?,
      lastHeartbeat: json['lastHeartbeat'] as String?,
      todaySales: const LenientNum().fromJson(json['todaySales']),
      todayTransactions: const LenientInt().fromJson(json['todayTransactions']),
      connectivity: json['connectivity'] as String?,
      health: json['health'] as String?,
      healthReasons:
          (json['healthReasons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      batteryPercent: const LenientInt().fromJson(json['batteryPercent']),
      charging: const LenientBool().fromJson(json['charging']),
      connectionType: json['connectionType'] as String?,
      signal: const LenientInt().fromJson(json['signal']),
      printerStatus: json['printerStatus'] as String?,
      appVersion: json['appVersion'] as String?,
    );

Map<String, dynamic> _$TerminalResponseToJson(
  _TerminalResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'tid': instance.tid,
  'serialNumber': instance.serialNumber,
  'model': instance.model,
  'label': instance.label,
  'status': instance.status,
  'instantSettlement': const LenientBool().toJson(instance.instantSettlement),
  'activatedAt': instance.activatedAt,
  'lastHeartbeat': instance.lastHeartbeat,
  'todaySales': const LenientNum().toJson(instance.todaySales),
  'todayTransactions': const LenientInt().toJson(instance.todayTransactions),
  'connectivity': instance.connectivity,
  'health': instance.health,
  'healthReasons': instance.healthReasons,
  'batteryPercent': const LenientInt().toJson(instance.batteryPercent),
  'charging': const LenientBool().toJson(instance.charging),
  'connectionType': instance.connectionType,
  'signal': const LenientInt().toJson(instance.signal),
  'printerStatus': instance.printerStatus,
  'appVersion': instance.appVersion,
};

_MerchantPreferences _$MerchantPreferencesFromJson(Map<String, dynamic> json) =>
    _MerchantPreferences(
      dailySettlementReport: const LenientBool().fromJson(
        json['dailySettlementReport'],
      ),
      monthlySettlementReport: const LenientBool().fromJson(
        json['monthlySettlementReport'],
      ),
      reportRecipients:
          (json['reportRecipients'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      language: json['language'] as String?,
      pushEnabled: const LenientBool().fromJson(json['pushEnabled']),
      dailyTarget: const LenientNum().fromJson(json['dailyTarget']),
      monthlyTarget: const LenientNum().fromJson(json['monthlyTarget']),
    );

Map<String, dynamic> _$MerchantPreferencesToJson(
  _MerchantPreferences instance,
) => <String, dynamic>{
  'dailySettlementReport': const LenientBool().toJson(
    instance.dailySettlementReport,
  ),
  'monthlySettlementReport': const LenientBool().toJson(
    instance.monthlySettlementReport,
  ),
  'reportRecipients': instance.reportRecipients,
  'language': instance.language,
  'pushEnabled': const LenientBool().toJson(instance.pushEnabled),
  'dailyTarget': const LenientNum().toJson(instance.dailyTarget),
  'monthlyTarget': const LenientNum().toJson(instance.monthlyTarget),
};

_StatementResponse _$StatementResponseFromJson(Map<String, dynamic> json) =>
    _StatementResponse(
      id: json['id'] as String?,
      period: json['period'] as String?,
      grossSales: const LenientNum().fromJson(json['grossSales']),
      fees: const LenientNum().fromJson(json['fees']),
      netSettled: const LenientNum().fromJson(json['netSettled']),
      settlementCount: const LenientInt().fromJson(json['settlementCount']),
      generatedAt: json['generatedAt'] as String?,
    );

Map<String, dynamic> _$StatementResponseToJson(_StatementResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'period': instance.period,
      'grossSales': const LenientNum().toJson(instance.grossSales),
      'fees': const LenientNum().toJson(instance.fees),
      'netSettled': const LenientNum().toJson(instance.netSettled),
      'settlementCount': const LenientInt().toJson(instance.settlementCount),
      'generatedAt': instance.generatedAt,
    };

_NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    _NotificationItem(
      id: json['id'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      reference: json['reference'] as String?,
      read: json['read'] == null
          ? false
          : const LenientFlag().fromJson(json['read']),
      createdAt: json['createdAt'] as String?,
      severity: json['severity'] as String?,
      rule: json['rule'] as String?,
      evidence: const LenientMap().fromJson(json['evidence']),
      acknowledged: json['acknowledged'] == null
          ? false
          : const LenientFlag().fromJson(json['acknowledged']),
    );

Map<String, dynamic> _$NotificationItemToJson(_NotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'reference': instance.reference,
      'read': const LenientFlag().toJson(instance.read),
      'createdAt': instance.createdAt,
      'severity': instance.severity,
      'rule': instance.rule,
      'evidence': const LenientMap().toJson(instance.evidence),
      'acknowledged': const LenientFlag().toJson(instance.acknowledged),
    };

_NotificationFeed _$NotificationFeedFromJson(Map<String, dynamic> json) =>
    _NotificationFeed(
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      content:
          (json['content'] as List<dynamic>?)
              ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NotificationItem>[],
      totalElements: const LenientInt().fromJson(json['totalElements']),
      number: const LenientInt().fromJson(json['number']),
      size: const LenientInt().fromJson(json['size']),
      last: const LenientBool().fromJson(json['last']),
    );

Map<String, dynamic> _$NotificationFeedToJson(_NotificationFeed instance) =>
    <String, dynamic>{
      'unreadCount': instance.unreadCount,
      'content': instance.content,
      'totalElements': const LenientInt().toJson(instance.totalElements),
      'number': const LenientInt().toJson(instance.number),
      'size': const LenientInt().toJson(instance.size),
      'last': const LenientBool().toJson(instance.last),
    };
