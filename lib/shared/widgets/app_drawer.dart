import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/config/app_config_provider.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../features/auth/presentation/auth_controller.dart';
import '../../features/merchant/presentation/merchant_providers.dart';
import '../format.dart';
import 'empty_state.dart';
import 'list_card.dart';
import 'round_icon_button.dart';
import '../../l10n/generated/app_localizations.dart';

/// Account drawer opened from the dashboard hero card.
class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authControllerProvider);
    final user = auth.user;
    final terminals = ref.watch(terminalsProvider);
    final summary = ref.watch(summaryProvider);
    final displayName = ref.watch(businessNameProvider);
    final role = _titleCase(user?.role ?? 'Merchant');
    final canSwitch = auth.canSwitchMerchant;
    final version = ref.watch(packageInfoProvider).asData?.value.version ?? '';

    void go(String route) {
      Navigator.of(context).pop();
      if (GoRouter.of(context).state.matchedLocation != route) {
        context.push(route);
      }
    }

    void notYet() {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.commonComingSoon)));
    }

    return Drawer(
      backgroundColor: AppColors.canvas,
      width: (MediaQuery.sizeOf(context).width * 0.88).clamp(0, 340),
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: RoundIconButton(
                icon: LucideIcons.x,
                semanticLabel: l10n.commonClose,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    initialsOf(displayName),
                    style: AppText.display(
                      size: 24,
                      color: AppColors.primary,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: canSwitch ? () => _pickMerchant(context) : null,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          displayName,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.money(size: 16),
                        ),
                      ),
                      if (canSwitch) ...[
                        const SizedBox(width: 4),
                        Icon(
                          LucideIcons.chevronDown,
                          size: 16,
                          color: AppColors.textTertiary,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.drawerRoleMerchant(role),
                  style: AppText.body(size: 14, color: AppColors.textTertiary),
                ),
                if (canSwitch) ...[
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () => _pickMerchant(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(LucideIcons.arrowLeftRight, size: 14),
                    label: Text(l10n.drawerSwitchMerchant),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _FeatureTile(
                    icon: LucideIcons.printer,
                    label: l10n.drawerTerminals,
                    sub: terminals.when(
                      data: (t) => l10n.drawerTerminalsActive(
                        t
                            .where(
                              (x) =>
                                  (x.status ?? 'ACTIVE').toUpperCase() ==
                                  'ACTIVE',
                            )
                            .length,
                      ),
                      loading: () => '…',
                      error: (_, _) => l10n.commonUnavailable,
                    ),
                    onTap: () => go(AppRoutes.stores),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _FeatureTile(
                    icon: LucideIcons.landmark,
                    label: l10n.drawerSettled,
                    sub: summary.when(
                      data: (s) => formatMoneyCompact(s.totalSettledAmount),
                      loading: () => '…',
                      error: (_, _) => l10n.commonUnavailable,
                    ),
                    onTap: () => go(AppRoutes.settlements),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListCard(
              children: [
                ListRow(
                  leading: Icon(
                    LucideIcons.store,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  title: l10n.drawerStores,
                  onTap: () => go(AppRoutes.stores),
                ),
                if (auth.canViewMoney)
                  ListRow(
                    leading: Icon(
                      LucideIcons.fileText,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    title: l10n.drawerStatements,
                    onTap: () => go(AppRoutes.settlements),
                  ),
                ListRow(
                  leading: Icon(
                    LucideIcons.chartNoAxesColumn,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  title: l10n.insightsTitle,
                  onTap: () => go(AppRoutes.insights),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListCard(
              children: [
                ListRow(
                  leading: Icon(
                    LucideIcons.settings,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  title: l10n.drawerSettings,
                  chevron: false,
                  onTap: () => go(AppRoutes.settings),
                ),
                ListRow(
                  leading: Icon(
                    LucideIcons.circleQuestionMark,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  title: l10n.drawerHelp,
                  chevron: false,
                  onTap: notYet,
                ),
                ListRow(
                  leading: Icon(
                    LucideIcons.logOut,
                    size: 20,
                    color: AppColors.danger,
                  ),
                  title: l10n.drawerLogout,
                  titleColor: AppColors.danger,
                  chevron: false,
                  onTap: () async {
                    Navigator.of(context).pop();
                    await ref.read(authControllerProvider.notifier).logout();
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                l10n.appVersionLabel(version),
                style: AppText.body(size: 12, color: AppColors.textTertiary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickMerchant(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const MerchantPickerSheet(),
    );
  }

  String _titleCase(String s) {
    final clean = s.replaceAll('_', ' ').toLowerCase();
    if (clean.isEmpty) return s;
    return clean[0].toUpperCase() + clean.substring(1);
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.label,
    required this.sub,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String sub;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      radius: 16,
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: AppColors.navy),
          const SizedBox(height: 10),
          Text(label, style: AppText.body(size: 15, weight: FontWeight.w600)),
          Text(
            sub,
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet listing merchants an admin user can act as.
class MerchantPickerSheet extends ConsumerStatefulWidget {
  const MerchantPickerSheet({super.key});

  @override
  ConsumerState<MerchantPickerSheet> createState() =>
      _MerchantPickerSheetState();
}

class _MerchantPickerSheetState extends ConsumerState<MerchantPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final list = ref.watch(merchantListProvider(_query));
    final currentMid = ref.watch(authControllerProvider).mid;
    final height = MediaQuery.sizeOf(context).height * 0.75;

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.hairline,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(l10n.drawerSwitchMerchant, style: AppText.money(size: 17)),
            const SizedBox(height: 4),
            Text(
              l10n.drawerSwitchMerchantHint,
              style: AppText.body(size: 13, color: AppColors.textTertiary),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (v) => setState(() => _query = v.trim()),
              style: AppText.body(size: 15),
              decoration: InputDecoration(
                hintText: l10n.drawerSearchMerchants,
                fillColor: AppColors.canvas,
                prefixIcon: Icon(
                  LucideIcons.search,
                  size: 16,
                  color: AppColors.textTertiary,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: list.when(
                loading: () => const Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.2),
                  ),
                ),
                error: (e, _) => EmptyState(
                  icon: LucideIcons.triangleAlert,
                  title: l10n.drawerLoadMerchantsFailed,
                  subtitle: e.toString(),
                ),
                data: (merchants) {
                  if (merchants.isEmpty) {
                    return EmptyState(
                      icon: LucideIcons.store,
                      title: l10n.drawerNoMerchants,
                    );
                  }
                  return ListView.separated(
                    itemCount: merchants.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final m = merchants[i];
                      final selected = m.mid == currentMid;
                      return ListRow(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 12,
                        ),
                        leading: InitialsTile(
                          text: initialsOf(m.name),
                          background: selected
                              ? AppColors.primaryLight
                              : AppColors.canvas,
                          foreground: selected
                              ? AppColors.primary
                              : AppColors.navy,
                        ),
                        title: m.name.isEmpty ? m.mid : m.name,
                        subtitle: [
                          if (m.email.isNotEmpty) m.email,
                          l10n.midLabel(m.mid),
                        ].join(' · '),
                        chevron: false,
                        trailing: selected
                            ? Icon(
                                LucideIcons.circleCheck,
                                size: 20,
                                color: AppColors.primary,
                              )
                            : null,
                        onTap: () {
                          ref
                              .read(authControllerProvider.notifier)
                              .selectMerchant(m.mid);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
