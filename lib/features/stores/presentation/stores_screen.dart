import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/section_label.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Lists the merchant's store (business profile) and its card machines.
class StoresScreen extends ConsumerWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(merchantProfileProvider);
    final terminals = ref.watch(terminalsProvider);
    final user = ref.watch(authControllerProvider).user;
    final fallbackName = user?.tenants.isNotEmpty == true
        ? (user!.tenants.first.name ?? l10n.storeDefaultName)
        : l10n.storeDefaultName;

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
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
          children: [
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
                            ? AppColors.canvas
                            : AppColors.surfaceAlt,
                        foreground: active
                            ? AppColors.navy
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
            const SizedBox(height: 24),
            SectionLabel(l10n.storesCardMachines, uppercase: true),
            AsyncSlot<List<String>>(
              value: terminals,
              loadingHeight: 120,
              onRetry: () => ref.invalidate(terminalsProvider),
              data: (tids) {
                if (tids.isEmpty) {
                  return EmptyState(
                    icon: LucideIcons.printer,
                    title: l10n.storesNoTerminals,
                    subtitle: l10n.storesNoTerminalsHint,
                  );
                }
                return ListCard(
                  children: [
                    for (final tid in tids)
                      ListRow(
                        leading: Container(
                          width: 44,
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.canvas,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            LucideIcons.printer,
                            size: 20,
                            color: AppColors.textBody,
                          ),
                        ),
                        title: l10n.storesTerminal,
                        subtitle: l10n.tidLabel(tid),
                        trailing: _StatusPill(l10n.statusActive),
                        chevron: false,
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

class _StatusPill extends StatelessWidget {
  const _StatusPill(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppText.body(
              size: 12,
              weight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
