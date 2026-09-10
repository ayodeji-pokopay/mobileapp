import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/business_models.dart';
import '../../../core/biometric/biometric_service.dart';
import '../../../core/config/app_config_provider.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/error_text.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/section_label.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/presentation/merchant_providers.dart';
import 'recipients_sheet.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _save(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function() action,
  ) async {
    final l10n = AppLocalizations.of(context);
    try {
      await action();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${l10n.settingsSaveFailed} ${describeError(e, l10n)}'),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(authControllerProvider).user;
    final displayName = ref.watch(businessNameProvider);
    final version = ref.watch(packageInfoProvider).asData?.value.version ?? '';
    final prefs = ref.watch(preferencesProvider);
    final p = prefs.asData?.value;
    final unread =
        ref.watch(notificationsProvider).asData?.value.unreadCount ?? 0;
    final bioAvailable =
        ref.watch(biometricAvailableProvider).asData?.value ?? false;
    final enrolled = ref.watch(deviceEnrolledProvider);

    void notYet() {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.commonComingSoon)));
    }

    Widget toggle({
      required String title,
      required String subtitle,
      required bool? value,
      required Future<void> Function(bool v) onChanged,
    }) {
      return ListRow(
        title: title,
        subtitle: subtitle,
        chevron: false,
        trailing: prefs.isLoading
            ? const Skeleton(height: 28, width: 48, radius: 14)
            : Switch(
                value: value ?? false,
                onChanged: prefs.hasError
                    ? null
                    : (v) => _save(context, ref, () => onChanged(v)),
              ),
      );
    }

    return BackScaffold(
      title: l10n.settingsTitle,
      bottomNav: const PokoBottomNav(active: NavTab.settings),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          SectionLabel(l10n.settingsPersonal, color: AppColors.textSecondary),
          ListCard(
            children: [
              ListRow(
                leading: InitialsTile(
                  text: initialsOf(displayName),
                  background: AppColors.navy,
                  foreground: Colors.white,
                  radius: 999,
                  fontSize: 14,
                ),
                title: displayName,
                subtitle: user?.email ?? '',
                onTap: () => context.push(AppRoutes.personalInfo),
              ),
              ListRow(
                leading: const _RowIcon(LucideIcons.bell),
                title: l10n.notificationsTitle,
                subtitle: unread > 0 ? '$unread' : l10n.notificationsEmpty,
                trailing: unread > 0
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '$unread',
                          style: AppText.body(
                            size: 12,
                            weight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : null,
                chevron: true,
                onTap: () => context.push(AppRoutes.notifications),
              ),
              ListRow(
                leading: const _RowIcon(LucideIcons.lock),
                title: l10n.settingsSecurity,
                subtitle: l10n.settingsSecurityHint,
                onTap: () => context.push(AppRoutes.changePassword),
              ),
              if (bioAvailable)
                ListRow(
                  leading: const _RowIcon(LucideIcons.fingerprintPattern),
                  title: l10n.settingsBiometric,
                  subtitle: l10n.settingsBiometricHint,
                  chevron: false,
                  trailing: enrolled.isLoading
                      ? const Skeleton(height: 28, width: 48, radius: 14)
                      : Switch(
                          value: enrolled.asData?.value ?? false,
                          onChanged: (v) => _save(context, ref, () async {
                            await ref
                                .read(authControllerProvider.notifier)
                                .setBiometricEnabled(v);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  v
                                      ? l10n.settingsBiometricEnrolled
                                      : l10n.settingsBiometricOff,
                                ),
                              ),
                            );
                          }),
                        ),
                ),
              ListRow(
                leading: const _RowIcon(LucideIcons.globe),
                title: l10n.settingsPreferences,
                subtitle: l10n.settingsPreferencesHint,
                onTap: notYet,
              ),
            ],
          ),
          const SizedBox(height: 22),
          SectionLabel(l10n.settingsCompany, color: AppColors.textSecondary),
          ListCard(
            children: [
              ListRow(
                leading: const _RowIcon(LucideIcons.building2),
                title: l10n.settingsBusinessInfo,
                subtitle: l10n.settingsBusinessInfoHint,
                onTap: () => context.push(AppRoutes.businessDetails),
              ),
              ListRow(
                leading: const _RowIcon(LucideIcons.printer),
                title: l10n.settingsCardMachines,
                subtitle: l10n.settingsCardMachinesHint,
                onTap: () => context.push(AppRoutes.stores),
              ),
              ListRow(
                leading: const _RowIcon(LucideIcons.receipt),
                title: l10n.settingsSettlements,
                subtitle: l10n.settingsSettlementsHint,
                onTap: () => context.push(AppRoutes.settlements),
              ),
            ],
          ),
          const SizedBox(height: 22),
          SectionLabel(
            l10n.settingsReportsSection,
            uppercase: true,
            color: AppColors.textSecondary,
          ),
          ListCard(
            children: [
              toggle(
                title: l10n.settingsDailyReport,
                subtitle: l10n.settingsDailyReportHint,
                value: p?.dailySettlementReport,
                onChanged: (v) => ref
                    .read(preferencesProvider.notifier)
                    .save(dailySettlementReport: v),
              ),
              toggle(
                title: l10n.settingsMonthlyReport,
                subtitle: l10n.settingsMonthlyReportHint,
                value: p?.monthlySettlementReport,
                onChanged: (v) => ref
                    .read(preferencesProvider.notifier)
                    .save(monthlySettlementReport: v),
              ),
              ListRow(
                title: l10n.settingsRecipients,
                subtitle: prefs.hasError
                    ? describeError(prefs.error!, l10n)
                    : l10n.settingsRecipientsCount(
                        p?.reportRecipients.length ?? 0,
                      ),
                onTap: p == null ? null : () => showRecipientsSheet(context, p),
              ),
              toggle(
                title: l10n.settingsPush,
                subtitle: l10n.settingsPushHint,
                value: p?.pushEnabled,
                onChanged: (v) =>
                    ref.read(preferencesProvider.notifier).save(pushEnabled: v),
              ),
            ],
          ),
          const SizedBox(height: 22),
          ListCard(
            children: [
              ListRow(
                leading: const Icon(
                  LucideIcons.logOut,
                  size: 20,
                  color: AppColors.danger,
                ),
                title: l10n.settingsLogout,
                titleColor: AppColors.danger,
                chevron: false,
                onTap: () => ref.read(authControllerProvider.notifier).logout(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              l10n.appVersionLabel(version),
              style: AppText.body(size: 12, color: AppColors.textTertiary),
            ),
          ),
        ],
      ),
    );
  }
}

class _RowIcon extends StatelessWidget {
  const _RowIcon(this.icon);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 20, color: AppColors.textSecondary);
  }
}

// Keep the type in scope for callers that pass preferences around.
typedef Preferences = MerchantPreferences;
