/// Staff accounts from `/api/v1/merchant/staff`.
library;

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
  });

  final String id;
  final String email;
  final String name;
  final String role; // OWNER | MANAGER | CASHIER
  final bool active;
  final DateTime? invitedAt;
  final DateTime? lastActiveAt;

  /// Null when the backend doesn't report invitation state.
  final bool? accepted;

  bool get pendingInvite => accepted == false;

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
  static const assignable = [manager, cashier];
}
