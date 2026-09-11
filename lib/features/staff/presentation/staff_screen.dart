import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/staff_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/error_text.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../../shared/widgets/pills.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/data/merchant_repository.dart';
import '../../merchant/presentation/merchant_providers.dart';

String roleLabel(String role, AppLocalizations l10n) => switch (role) {
  StaffRoles.owner => l10n.roleOwner,
  StaffRoles.manager => l10n.roleManager,
  StaffRoles.cashier => l10n.roleCashier,
  _ => role,
};

/// Settings › Staff: who can sign in to this business and what they see.
class StaffScreen extends ConsumerWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final staff = ref.watch(staffProvider);
    return BackScaffold(
      title: l10n.staffTitle,
      subtitle: l10n.staffHint,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(staffProvider);
          await ref.read(staffProvider.future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            ElevatedButton.icon(
              onPressed: () => showInviteStaffSheet(context),
              icon: const Icon(LucideIcons.userPlus, size: 18),
              label: Text(l10n.staffInvite),
            ),
            const SizedBox(height: 16),
            AsyncSlot<List<StaffMember>>(
              value: staff,
              loadingHeight: 200,
              onRetry: () => ref.invalidate(staffProvider),
              data: (list) {
                if (list.isEmpty) {
                  return EmptyState(
                    icon: LucideIcons.users,
                    title: l10n.staffEmpty,
                    subtitle: l10n.staffEmptyHint,
                  );
                }
                return ListCard(
                  children: [
                    for (final m in list)
                      ListRow(
                        leading: InitialsTile(
                          text: initialsOf(m.name.isEmpty ? m.email : m.name),
                          background: m.active
                              ? AppColors.primaryLight
                              : AppColors.surfaceAlt,
                          foreground: m.active
                              ? AppColors.primary
                              : AppColors.textTertiary,
                        ),
                        title: m.name.isEmpty ? m.email : m.name,
                        subtitle: [
                          if (m.name.isNotEmpty) m.email,
                          roleLabel(m.role, l10n),
                          if (m.lastActiveAt != null)
                            l10n.sessionsLastActive(
                              formatRelativeTime(m.lastActiveAt!),
                            ),
                        ].join(' · '),
                        trailing: StatusPill(
                          label: m.pendingInvite
                              ? l10n.staffInvited
                              : m.active
                              ? l10n.staffActive
                              : l10n.staffInactive,
                          tone: m.pendingInvite
                              ? PillTone.warning
                              : m.active
                              ? PillTone.success
                              : PillTone.neutral,
                        ),
                        titleColor: m.active
                            ? AppColors.navy
                            : AppColors.textTertiary,
                        onTap: m.role == StaffRoles.owner
                            ? null
                            : () => showEditStaffSheet(context, m),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showInviteStaffSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _InviteSheet(),
  );
}

Future<void> showEditStaffSheet(BuildContext context, StaffMember m) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _EditSheet(m: m),
  );
}

class _Handle extends StatelessWidget {
  const _Handle();
  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.hairline,
        borderRadius: BorderRadius.circular(999),
      ),
    ),
  );
}

class _RolePicker extends StatelessWidget {
  const _RolePicker({required this.role, required this.onChanged});
  final String role;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final idx = StaffRoles.assignable.indexOf(role);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.staffRole, style: AppText.label()),
        const SizedBox(height: 8),
        PillTabs(
          items: [for (final r in StaffRoles.assignable) roleLabel(r, l10n)],
          selected: idx < 0 ? 1 : idx,
          onChanged: (i) => onChanged(StaffRoles.assignable[i]),
        ),
        const SizedBox(height: 6),
        Text(
          role == StaffRoles.manager
              ? l10n.roleManagerHint
              : l10n.roleCashierHint,
          style: AppText.body(size: 12.5, color: AppColors.textTertiary),
        ),
      ],
    );
  }
}

class _InviteSheet extends ConsumerStatefulWidget {
  const _InviteSheet();
  @override
  ConsumerState<_InviteSheet> createState() => _InviteSheetState();
}

class _InviteSheetState extends ConsumerState<_InviteSheet> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  String _role = StaffRoles.cashier;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final email = _email.text.trim();
    if (!email.contains('@')) {
      setState(() => _error = l10n.staffEmailInvalid);
      return;
    }
    final mid = ref.read(authControllerProvider).mid;
    if (mid == null) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(merchantRepositoryProvider)
          .inviteStaff(
            mid: mid,
            email: email,
            name: _name.text.trim(),
            role: _role,
          );
      ref.invalidate(staffProvider);
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.staffInviteSent(email))));
    } catch (e) {
      setState(() => _error = describeError(e, l10n));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final inset = MediaQuery.viewInsetsOf(context).bottom;
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        16 + (inset > 0 ? inset : bottom),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Handle(),
            const SizedBox(height: 18),
            Text(l10n.staffInviteTitle, style: AppText.money(size: 17)),
            const SizedBox(height: 4),
            Text(
              l10n.staffInviteHint,
              style: AppText.body(size: 13, color: AppColors.textTertiary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              style: AppText.body(size: 15),
              decoration: InputDecoration(
                labelText: l10n.staffName,
                fillColor: AppColors.canvas,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              style: AppText.body(size: 15),
              decoration: InputDecoration(
                labelText: l10n.staffEmail,
                fillColor: AppColors.canvas,
              ),
            ),
            const SizedBox(height: 16),
            _RolePicker(
              role: _role,
              onChanged: (r) => setState(() => _role = r),
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(
                _error!,
                style: AppText.body(size: 13, color: AppColors.danger),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(l10n.staffSendInvite),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditSheet extends ConsumerStatefulWidget {
  const _EditSheet({required this.m});
  final StaffMember m;
  @override
  ConsumerState<_EditSheet> createState() => _EditSheetState();
}

class _EditSheetState extends ConsumerState<_EditSheet> {
  late String _role = widget.m.role;
  late bool _active = widget.m.active;
  bool _busy = false;
  String? _error;

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final mid = ref.read(authControllerProvider).mid;
    if (mid == null) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(merchantRepositoryProvider)
          .updateStaff(
            mid: mid,
            id: widget.m.id,
            role: _role == widget.m.role ? null : _role,
            active: _active == widget.m.active ? null : _active,
          );
      ref.invalidate(staffProvider);
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.staffUpdated)));
    } catch (e) {
      setState(() => _error = describeError(e, l10n));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottom = MediaQuery.paddingOf(context).bottom;
    final m = widget.m;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Handle(),
          const SizedBox(height: 18),
          Text(
            m.name.isEmpty ? m.email : m.name,
            style: AppText.money(size: 17),
          ),
          const SizedBox(height: 4),
          Text(
            m.email,
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),
          _RolePicker(role: _role, onChanged: (r) => setState(() => _role = r)),
          const SizedBox(height: 12),
          ListCard(
            children: [
              ListRow(
                title: l10n.staffAccessOn,
                subtitle: l10n.staffAccessHint,
                chevron: false,
                trailing: Switch(
                  value: _active,
                  onChanged: (v) => setState(() => _active = v),
                ),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: 10),
            Text(
              _error!,
              style: AppText.body(size: 13, color: AppColors.danger),
            ),
          ],
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _busy ? null : _save,
            child: _busy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(l10n.commonSave),
          ),
        ],
      ),
    );
  }
}
