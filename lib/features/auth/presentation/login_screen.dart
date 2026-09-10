import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/biometric/biometric_service.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/pokopay_logo.dart';
import '../data/auth_repository.dart';
import 'auth_controller.dart';

/// Debug-only convenience: prefill and submit the form when both defines are
/// set, e.g. `flutter run --dart-define=DEV_LOGIN_EMAIL=... --dart-define=DEV_LOGIN_PASSWORD=...`.
/// Ignored in release builds.
const _devEmail = String.fromEnvironment('DEV_LOGIN_EMAIL');
const _devPassword = String.fromEnvironment('DEV_LOGIN_PASSWORD');

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;
  bool _enableBiometric = false;
  bool _submitting = false;
  bool _hasDeviceToken = false;

  @override
  void initState() {
    super.initState();
    _checkDevice();
    if (kDebugMode && _devEmail.isNotEmpty && _devPassword.isNotEmpty) {
      _emailCtrl.text = _devEmail;
      _passwordCtrl.text = _devPassword;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _submit();
      });
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _checkDevice() async {
    final has = await ref.read(secureStorageProvider).hasDeviceToken();
    if (!mounted) return;
    setState(() => _hasDeviceToken = has);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.danger),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _submitting = true);
    final ok = await ref
        .read(authControllerProvider.notifier)
        .login(
          _emailCtrl.text.trim(),
          _passwordCtrl.text,
          enableBiometric: _enableBiometric,
        );
    if (!mounted) return;
    setState(() => _submitting = false);
    if (!ok) {
      _showError(
        ref.read(authControllerProvider).error ??
            AppLocalizations.of(context).loginFailed,
      );
    }
  }

  Future<void> _biometricLogin() async {
    final l10n = AppLocalizations.of(context);
    final ok = await ref
        .read(biometricServiceProvider)
        .authenticate(reason: l10n.loginBiometricReason);
    if (!ok || !mounted) return;
    setState(() => _submitting = true);
    final success = await ref
        .read(authControllerProvider.notifier)
        .loginWithDevice();
    if (!mounted) return;
    setState(() => _submitting = false);
    if (!success) {
      final auth = ref.read(authControllerProvider);
      if (auth.errorCode == AuthException.deviceReenrol) {
        setState(() => _hasDeviceToken = false);
        _showError(l10n.loginBiometricReenrol);
      } else {
        _showError(auth.error ?? l10n.loginBiometricFailed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bioAvailable =
        ref.watch(biometricAvailableProvider).asData?.value ?? false;
    final sessionExpired = ref.watch(authControllerProvider).sessionExpired;
    final showBiometricButton = bioAvailable && _hasDeviceToken;

    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 28),
                        const Center(child: PokopayMark()),
                        const SizedBox(height: 40),
                        Text(
                          l10n.loginWelcome,
                          style: AppText.display(size: 34),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.loginSubtitle,
                          style: AppText.body(
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        if (sessionExpired) ...[
                          const SizedBox(height: 16),
                          _Notice(text: l10n.loginSessionExpired),
                        ],
                        const SizedBox(height: 32),
                        _FieldLabel(l10n.loginEmailLabel),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          style: AppText.body(size: 16),
                          decoration: InputDecoration(
                            hintText: l10n.loginEmailHint,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return l10n.validationEmailRequired;
                            }
                            if (!v.contains('@')) {
                              return l10n.validationEmailInvalid;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _FieldLabel(l10n.loginPasswordLabel),
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l10n.loginForgotHint)),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(l10n.loginForgot),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscure,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          style: AppText.body(size: 16),
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            suffixIcon: IconButton(
                              splashRadius: 20,
                              tooltip: _obscure
                                  ? l10n.showPassword
                                  : l10n.hidePassword,
                              icon: Icon(
                                _obscure ? LucideIcons.eye : LucideIcons.eyeOff,
                                size: 20,
                                color: AppColors.textTertiary,
                              ),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (v) => (v == null || v.isEmpty)
                              ? l10n.validationPasswordRequired
                              : null,
                        ),
                        if (bioAvailable) ...[
                          const SizedBox(height: 14),
                          GestureDetector(
                            onTap: () => setState(
                              () => _enableBiometric = !_enableBiometric,
                            ),
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: Checkbox(
                                    value: _enableBiometric,
                                    onChanged: (v) => setState(
                                      () => _enableBiometric = v ?? false,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    l10n.loginEnableBiometric,
                                    style: AppText.body(
                                      size: 14,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _submitting ? null : _submit,
                          child: _submitting
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      l10n.loginSigningIn,
                                      style: AppText.body(
                                        size: 16,
                                        weight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(l10n.loginButton),
                        ),
                        if (showBiometricButton) ...[
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(color: AppColors.hairline),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  l10n.loginOr,
                                  style: AppText.body(
                                    size: 14,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Divider(color: AppColors.hairline),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          OutlinedButton.icon(
                            onPressed: _submitting ? null : _biometricLogin,
                            icon: const Icon(
                              LucideIcons.fingerprintPattern,
                              size: 24,
                              color: AppColors.primary,
                            ),
                            label: Text(l10n.loginBiometricButton),
                          ),
                        ],
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                LucideIcons.shieldCheck,
                                size: 16,
                                color: AppColors.textTertiary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                l10n.loginSecurityFooter,
                                style: AppText.body(
                                  size: 12,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.warningBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.clock, size: 16, color: AppColors.warningText),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppText.body(size: 13, color: AppColors.warningText),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppText.body(
        size: 14,
        weight: FontWeight.w500,
        color: AppColors.textBody,
      ),
    );
  }
}
