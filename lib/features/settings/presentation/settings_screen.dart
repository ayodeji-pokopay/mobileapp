import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../core/config/app_config_provider.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/section_label.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../../../l10n/generated/app_localizations.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  static const _dailyKey = 'pref_daily_report';
  static const _monthlyKey = 'pref_monthly_report';
  bool _daily = true;
  bool _monthly = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _daily = prefs.getBool(_dailyKey) ?? true;
      _monthly = prefs.getBool(_monthlyKey) ?? true;
    });
  }

  Future<void> _setPref(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void _notYet() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).commonComingSoon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(authControllerProvider).user;
    final displayName = ref.watch(businessNameProvider);
    final version = ref.watch(packageInfoProvider).asData?.value.version ?? '';

    return BackScaffold(
      title: l10n.settingsTitle,
      bottomNav: const PokoBottomNav(active: NavTab.settings),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
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
                leading: const _RowIcon(LucideIcons.lock),
                title: l10n.settingsSecurity,
                subtitle: l10n.settingsSecurityHint,
                onTap: () => context.push(AppRoutes.changePassword),
              ),
              ListRow(
                leading: const _RowIcon(LucideIcons.globe),
                title: l10n.settingsPreferences,
                subtitle: l10n.settingsPreferencesHint,
                onTap: _notYet,
              ),
            ],
          ),
          const SizedBox(height: 24),
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
                leading: const _RowIcon(LucideIcons.creditCard),
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
          const SizedBox(height: 24),
          SectionLabel(
            l10n.settingsReportsSection,
            uppercase: true,
            color: AppColors.textSecondary,
          ),
          ListCard(
            children: [
              ListRow(
                title: l10n.settingsDailyReport,
                subtitle: l10n.settingsDailyReportHint,
                chevron: false,
                trailing: Switch(
                  value: _daily,
                  onChanged: (v) {
                    setState(() => _daily = v);
                    _setPref(_dailyKey, v);
                  },
                ),
              ),
              ListRow(
                title: l10n.settingsMonthlyReport,
                subtitle: l10n.settingsMonthlyReportHint,
                chevron: false,
                trailing: Switch(
                  value: _monthly,
                  onChanged: (v) {
                    setState(() => _monthly = v);
                    _setPref(_monthlyKey, v);
                  },
                ),
              ),
              ListRow(
                title: l10n.settingsRecipients,
                subtitle: user?.email ?? l10n.settingsNoEmail,
                onTap: _notYet,
              ),
            ],
          ),
          const SizedBox(height: 24),
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
