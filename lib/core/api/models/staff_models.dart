/// Staff accounts from `/api/v1/merchant/staff`.
library;

import 'insights_models.dart' show parseList;

class StaffMember {
  const StaffMember({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.active,
    this.invitedAt,
    this.lastActiveAt,
    this.accepted,
    this.acceptedAt,
    this.invitedBy,
    this.permissions = const [],
    this.terminalIds = const [],
    this.status,
  });

  final DateTime? acceptedAt;
  final String? invitedBy;
  final List<String> permissions;

  /// Card machines a cashier is scoped to; empty = all.
  final List<String> terminalIds;

  /// INVITED | ACTIVE | DISABLED
  final String? status;

  final String id;
  final String email;
  final String name;
  final String role; // OWNER | MANAGER | CASHIER
  final bool active;
  final DateTime? invitedAt;
  final DateTime? lastActiveAt;

  /// Null when the backend doesn't report invitation state.
  final bool? accepted;

  bool get pendingInvite =>
      accepted == false || (status ?? '').toUpperCase() == 'INVITED';
  bool get disabled => !active || (status ?? '').toUpperCase() == 'DISABLED';
  bool get isOwner => role == StaffRoles.owner;

  factory StaffMember.fromJson(Map<String, dynamic> j) => StaffMember(
    id: (j['id'] ?? j['userId'] ?? '').toString(),
    email: (j['email'] ?? '').toString(),
    name: (j['name'] ?? j['fullName'] ?? '').toString(),
    role: (j['role'] ?? 'CASHIER').toString().toUpperCase(),
    active: j['active'] != false,
    invitedAt: DateTime.tryParse(j['invitedAt']?.toString() ?? ''),
    lastActiveAt: DateTime.tryParse(
      (j['lastActiveAt'] ?? j['lastLoginAt'])?.toString() ?? '',
    ),
    accepted: j['accepted'] is bool
        ? j['accepted'] as bool
        : (j['status'] == null
              ? null
              : j['status'].toString().toUpperCase() != 'INVITED'),
    acceptedAt: DateTime.tryParse(j['acceptedAt']?.toString() ?? ''),
    invitedBy: j['invitedBy']?.toString(),
    permissions: [
      if (j['permissions'] is List)
        for (final p in j['permissions'] as List) p.toString(),
    ],
    terminalIds: [
      if (j['terminalIds'] is List)
        for (final t in j['terminalIds'] as List) t.toString(),
    ],
    status: j['status']?.toString(),
  );
}

class DeclineReason {
  const DeclineReason({
    required this.responseCode,
    required this.description,
    required this.count,
  });
  final String responseCode;
  final String description;
  final int count;

  factory DeclineReason.fromJson(Map<String, dynamic> j) => DeclineReason(
    responseCode: (j['responseCode'] ?? '').toString(),
    description: (j['description'] ?? '').toString(),
    count: (j['count'] as num?)?.toInt() ?? 0,
  );
}

abstract final class StaffRoles {
  static const owner = 'OWNER';
  static const manager = 'MANAGER';
  static const cashier = 'CASHIER';
  static const viewer = 'VIEWER';
  static const assignable = [manager, cashier];
}

/// One row of `GET /merchant/staff/activity`.
class StaffActivity {
  const StaffActivity({
    required this.id,
    required this.action,
    required this.actorEmail,
    required this.targetEmail,
    required this.detail,
    required this.createdAt,
  });
  final String id;

  /// INVITED | RESENT_INVITE | ACCEPTED | ROLE_CHANGED | ACTIVATED | DEACTIVATED | REMOVED
  final String action;
  final String actorEmail;
  final String targetEmail;
  final String detail;
  final DateTime? createdAt;

  factory StaffActivity.fromJson(Map<String, dynamic> j) => StaffActivity(
    id: (j['id'] ?? '').toString(),
    action: (j['action'] ?? '').toString().toUpperCase(),
    actorEmail: (j['actorEmail'] ?? '').toString(),
    targetEmail: (j['targetEmail'] ?? '').toString(),
    detail: (j['detail'] ?? '').toString(),
    createdAt: DateTime.tryParse(j['createdAt']?.toString() ?? ''),
  );
}

class StaffActivityPage {
  const StaffActivityPage({required this.items, required this.last});
  final List<StaffActivity> items;
  final bool last;

  factory StaffActivityPage.fromJson(Object? data) {
    final map = data is Map
        ? data.cast<String, dynamic>()
        : const <String, dynamic>{};
    final content = map['content'] ?? (data is List ? data : const []);
    return StaffActivityPage(
      items: parseList(content, StaffActivity.fromJson),
      last: map['last'] != false,
    );
  }
}
