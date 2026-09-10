import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/business_models.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pills.dart';
import '../../../shared/widgets/section_label.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/presentation/merchant_providers.dart';
import 'rename_terminal_sheet.dart';

/// Lists the merchant's business and its POS terminals.
class StoresScreen extends ConsumerWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(merchantProfileProvider);
    final terminals = ref.watch(terminalsProvider);
    final user = ref.watch(authControllerProvider).user;
    final fallbackName =
        user?.merchantName ??
        (user?.tenants.isNotEmpty == true
            ? (user!.tenants.first.name ?? l10n.storeDefaultName)
            : l10n.storeDefaultName);

    return BackScaffold(
      title: l10n.storesTitle,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(merchantProfileProvider);
          ref.invalidate(terminalsProvider);
          await Future.wait([
            ref.read(merchantProfileProvider.future),
            ref.read(terminalsProvider.future),
          ]);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            const OfflineBanner(),
            AsyncSlot<Map<String, dynamic>>(
              value: profile,
              loadingHeight: 88,
              onRetry: () => ref.invalidate(merchantProfileProvider),
              data: (m) {
                final name = (m['merchantName'] ?? '').toString();
                final address = [
                  m['merchantAddress'],
                  m['lga'],
                  m['state'],
                  m['country'],
                ].where((e) => e != null && e.toString().isNotEmpty).join(', ');
                final active =
                    (m['approved'] as bool? ?? false) ||
                    (m['status'] ?? '').toString().toUpperCase() == 'ACTIVE';
                return ListCard(
                  children: [
                    ListRow(
                      leading: InitialsTile(
                        text: initialsOf(name.isEmpty ? fallbackName : name),
                        size: 48,
                        background: active
                            ? AppColors.primaryLight
                            : AppColors.surfaceAlt,
                        foreground: active
                            ? AppColors.primary
                            : AppColors.textTertiary,
                        fontSize: 13,
                      ),
                      title: name.isEmpty ? fallbackName : name,
                      subtitle: address.isEmpty
                          ? l10n.storesNoAddress
                          : address,
                      titleColor: active
                          ? AppColors.navy
                          : AppColors.textTertiary,
                      onTap: () => context.push(AppRoutes.businessDetails),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 22),
            SectionLabel(l10n.storesCardMachines, uppercase: true),
            AsyncSlot<List<TerminalResponse>>(
              value: terminals,
              loadingHeight: 120,
              onRetry: () => ref.invalidate(terminalsProvider),
              data: (list) {
                if (list.isEmpty) {
                  return EmptyState(
                    icon: LucideIcons.printer,
                    title: l10n.storesNoTerminals,
                    subtitle: l10n.storesNoTerminalsHint,
                  );
                }
                return ListCard(
                  children: [for (final t in list) _TerminalRow(t: t)],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TerminalRow extends StatelessWidget {
  const _TerminalRow({required this.t});
  final TerminalResponse t;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = (t.status ?? '').toUpperCase();
    final (tone, label) = switch (status) {
      'ACTIVE' => (PillTone.success, l10n.statusActive),
      'SUSPENDED' => (PillTone.warning, l10n.statusSuspended),
      'DISABLED' => (PillTone.danger, l10n.statusDisabled),
      'INACTIVE' => (PillTone.neutral, l10n.statusInactive),
      _ => (PillTone.neutral, status.isEmpty ? l10n.statusActive : status),
    };
    final seen = DateTime.tryParse(t.lastHeartbeat ?? '');
    final title = (t.label ?? '').isNotEmpty
        ? t.label!
        : (t.model ?? '').isNotEmpty
        ? t.model!
        : l10n.storesTerminal;
    return ListRow(
      leading: IconBubble(
        icon: LucideIcons.printer,
        tone: status == 'ACTIVE' ? PillTone.success : PillTone.neutral,
        size: 44,
      ),
      title: title,
      subtitle: [
        if ((t.tid ?? '').isNotEmpty) l10n.tidLabel(t.tid!),
        if ((t.serialNumber ?? '').isNotEmpty)
          l10n.terminalSerial(t.serialNumber!),
        seen == null
            ? l10n.terminalNeverSeen
            : l10n.terminalLastSeen(formatRelativeTime(seen)),
      ].join(' · '),
      trailing: StatusPill(label: label, tone: tone),
      chevron: false,
      onTap: () => showRenameTerminalSheet(context, t),
    );
  }
}
