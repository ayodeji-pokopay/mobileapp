import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/biometric/biometric_service.dart';
import '../../../core/lock/app_lock.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/error_text.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../../shared/widgets/section_label.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../auth/presentation/auth_controller.dart';

/// Settings › Security: password, biometric sign-in, app lock, devices.
class SecurityScreen extends ConsumerWidget {
  const SecurityScreen({super.key});

  static const _timeouts = [0, 1, 5, 15];

  Future<void> _guard(
    BuildContext context,
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
    final lock = ref.watch(appLockProvider);
    final bioAvailable =
        ref.watch(biometricAvailableProvider).asData?.value ?? false;
    final enrolled = ref.watch(deviceEnrolledProvider);
    final timeoutIndex = _timeouts.indexOf(lock.settings.timeoutMinutes);

    String timeoutLabel(int m) => switch (m) {
      0 => l10n.lockTimeoutImmediately,
      1 => l10n.lockTimeoutMinutes(1),
      _ => l10n.lockTimeoutMinutes(m),
    };

    return BackScaffold(
      title: l10n.securityTitle,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          SectionLabel(l10n.securitySignIn, color: AppColors.textSecondary),
          ListCard(
            children: [
              ListRow(
                leading: const _RowIcon(LucideIcons.keyRound),
                title: l10n.securityChangePassword,
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
                          onChanged: (v) => _guard(context, () async {
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
                leading: const _RowIcon(LucideIcons.smartphone),
                title: l10n.sessionsTitle,
                subtitle: l10n.sessionsHint,
                onTap: () => context.push(AppRoutes.sessions),
              ),
            ],
          ),
          const SizedBox(height: 22),
          SectionLabel(l10n.lockSection, color: AppColors.textSecondary),
          ListCard(
            children: [
              ListRow(
                leading: const _RowIcon(LucideIcons.lockKeyhole),
                title: l10n.lockEnable,
                subtitle: l10n.lockEnableHint,
                chevron: false,
                trailing: !lock.loaded
                    ? const Skeleton(height: 28, width: 48, radius: 14)
                    : Switch(
                        value: lock.settings.enabled,
                        onChanged: (v) async {
                          final n = ref.read(appLockProvider.notifier);
                          if (!v) {
                            await n.disable();
                            return;
                          }
                          final pin = await showSetPinSheet(context);
                          if (pin != null) {
                            await n.enable(pin: pin);
                          } else if (bioAvailable) {
                            await n.enable();
                          }
                        },
                      ),
              ),
              if (lock.settings.enabled) ...[
                ListRow(
                  leading: const _RowIcon(LucideIcons.timer),
                  title: l10n.lockTimeout,
                  subtitle: l10n.lockTimeoutHint,
                  chevron: false,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: PillTabs(
                    scrollable: true,
                    items: [for (final m in _timeouts) timeoutLabel(m)],
                    selected: timeoutIndex < 0 ? 1 : timeoutIndex,
                    onChanged: (i) => ref
                        .read(appLockProvider.notifier)
                        .setTimeout(_timeouts[i]),
                  ),
                ),
                if (bioAvailable)
                  ListRow(
                    leading: const _RowIcon(LucideIcons.scanFace),
                    title: l10n.lockUseBiometrics,
                    subtitle: l10n.lockUseBiometricsHint,
                    chevron: false,
                    trailing: Switch(
                      value: lock.settings.useBiometrics,
                      onChanged: (v) => ref
                          .read(appLockProvider.notifier)
                          .setUseBiometrics(v),
                    ),
                  ),
                ListRow(
                  leading: const _RowIcon(LucideIcons.hash),
                  title: lock.hasPin
                      ? l10n.lockChangePin
                      : l10n.lockSetPinTitle,
                  onTap: () async {
                    final pin = await showSetPinSheet(context);
                    if (pin == null || !context.mounted) return;
                    await ref.read(appLockProvider.notifier).setPin(pin);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.lockPinUpdated)),
                    );
                  },
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              l10n.lockFootnote(AppLockController.maxAttempts),
              style: AppText.body(size: 12, color: AppColors.textTertiary),
            ),
          ),
        ],
      ),
    );
  }
}

/// Asks for a 4-digit PIN twice. Returns null when dismissed.
Future<String?> showSetPinSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _SetPinSheet(),
  );
}

class _SetPinSheet extends StatefulWidget {
  const _SetPinSheet();

  @override
  State<_SetPinSheet> createState() => _SetPinSheetState();
}

class _SetPinSheetState extends State<_SetPinSheet> {
  final _first = TextEditingController();
  final _second = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _first.dispose();
    _second.dispose();
    super.dispose();
  }

  void _submit() {
    final l10n = AppLocalizations.of(context);
    final a = _first.text.trim();
    final b = _second.text.trim();
    if (!RegExp(r'^\d{4}$').hasMatch(a)) {
      setState(() => _error = l10n.lockPinFormat);
      return;
    }
    if (a != b) {
      setState(() => _error = l10n.lockPinMismatch);
      return;
    }
    Navigator.of(context).pop(a);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final inset = MediaQuery.viewInsetsOf(context).bottom;
    final bottom = MediaQuery.paddingOf(context).bottom;
    InputDecoration deco(String label) => InputDecoration(
      labelText: label,
      fillColor: AppColors.canvas,
      counterText: '',
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        16 + (inset > 0 ? inset : bottom),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          const SizedBox(height: 18),
          Text(l10n.lockSetPinTitle, style: AppText.money(size: 17)),
          const SizedBox(height: 4),
          Text(
            l10n.lockSetPinHint,
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _first,
            autofocus: true,
            obscureText: true,
            maxLength: 4,
            keyboardType: TextInputType.number,
            style: AppText.money(size: 20, letterSpacing: 8),
            decoration: deco(l10n.lockPin),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _second,
            obscureText: true,
            maxLength: 4,
            keyboardType: TextInputType.number,
            style: AppText.money(size: 20, letterSpacing: 8),
            decoration: deco(l10n.lockPinConfirm),
            onSubmitted: (_) => _submit(),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(
              _error!,
              style: AppText.body(size: 13, color: AppColors.danger),
            ),
          ],
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _submit, child: Text(l10n.commonSave)),
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
