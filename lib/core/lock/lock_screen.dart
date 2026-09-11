import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../features/auth/presentation/auth_controller.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/pokopay_logo.dart';
import '../biometric/biometric_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'app_lock.dart';

/// Full-screen cover. In [covered] mode it only hides content (app
/// switcher); otherwise it asks for biometrics or the PIN.
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key, required this.covered});
  final bool covered;

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  String _pin = '';
  bool _prompted = false;
  bool _error = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!widget.covered && !_prompted) {
      _prompted = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _tryBiometrics());
    }
  }

  Future<void> _tryBiometrics() async {
    final lock = ref.read(appLockProvider);
    final available =
        ref.read(biometricAvailableProvider).asData?.value ?? false;
    if (!lock.settings.useBiometrics || !available || !mounted) return;
    await ref
        .read(appLockProvider.notifier)
        .unlockWithBiometrics(AppLocalizations.of(context).lockTitle);
  }

  Future<void> _tap(String d) async {
    if (_pin.length >= 4) return;
    setState(() {
      _pin += d;
      _error = false;
    });
    if (_pin.length == 4) {
      final ok = await ref.read(appLockProvider.notifier).verifyPin(_pin);
      if (!mounted) return;
      setState(() {
        _pin = '';
        _error = !ok;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lock = ref.watch(appLockProvider);
    final bio = ref.watch(biometricAvailableProvider).asData?.value ?? false;
    final left = AppLockController.maxAttempts - lock.failedAttempts;

    return Material(
      color: AppColors.canvas,
      child: SafeArea(
        child: widget.covered
            ? const Center(child: PokopayMark(symbolSize: 48, fontSize: 32))
            : Column(
                children: [
                  const Spacer(),
                  const PokopayMark(symbolSize: 40, fontSize: 26),
                  const SizedBox(height: 28),
                  Text(l10n.lockTitle, style: AppText.display(size: 26)),
                  const SizedBox(height: 6),
                  Text(
                    _error
                        ? l10n.lockWrongPin(left)
                        : lock.hasPin
                        ? l10n.lockSubtitle
                        : '',
                    style: AppText.body(
                      size: 14,
                      color: _error
                          ? AppColors.danger
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (lock.hasPin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < 4; i++)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 120),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: i < _pin.length
                                  ? AppColors.primary
                                  : AppColors.surfaceAlt,
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: 28),
                  if (!lock.hasPin) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        l10n.lockNoPinHint,
                        textAlign: TextAlign.center,
                        style: AppText.body(
                          size: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: bio ? _tryBiometrics : null,
                      icon: const Icon(
                        LucideIcons.fingerprintPattern,
                        size: 18,
                      ),
                      label: Text(l10n.lockUnlockWithBiometrics),
                    ),
                  ] else
                    _Keypad(
                      onDigit: _tap,
                      onDelete: () => setState(
                        () => _pin = _pin.isEmpty
                            ? ''
                            : _pin.substring(0, _pin.length - 1),
                      ),
                      onBiometric: bio && lock.settings.useBiometrics
                          ? _tryBiometrics
                          : null,
                    ),
                  const Spacer(),
                  TextButton(
                    onPressed: () =>
                        ref.read(authControllerProvider.notifier).logout(),
                    child: Text(l10n.lockSignOut),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({
    required this.onDigit,
    required this.onDelete,
    required this.onBiometric,
  });
  final ValueChanged<String> onDigit;
  final VoidCallback onDelete;
  final VoidCallback? onBiometric;

  @override
  Widget build(BuildContext context) {
    Widget key(Widget child, VoidCallback? onTap) => SizedBox(
      width: 76,
      height: 64,
      child: Material(
        color: onTap == null ? Colors.transparent : AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Center(child: child),
        ),
      ),
    );
    Widget digit(String d) =>
        key(Text(d, style: AppText.money(size: 24)), () => onDigit(d));
    return Column(
      children: [
        for (final row in [
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9'],
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final d in row)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: digit(d),
                  ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: key(
                Icon(
                  LucideIcons.fingerprintPattern,
                  size: 26,
                  color: onBiometric == null
                      ? Colors.transparent
                      : AppColors.primary,
                ),
                onBiometric,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: digit('0'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: key(
                Icon(LucideIcons.delete, size: 22, color: AppColors.textBody),
                onDelete,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
