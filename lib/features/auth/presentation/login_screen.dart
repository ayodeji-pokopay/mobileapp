import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/biometric/biometric_service.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../shared/widgets/pokopay_logo.dart';
import 'auth_controller.dart';

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
  bool _hasSavedCredentials = false;

  @override
  void initState() {
    super.initState();
    _checkSavedCredentials();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _checkSavedCredentials() async {
    final has =
        await ref.read(secureStorageProvider).hasBiometricCredentials();
    if (!mounted) return;
    setState(() => _hasSavedCredentials = has);
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
    final ok = await ref.read(authControllerProvider.notifier).login(
          _emailCtrl.text.trim(),
          _passwordCtrl.text,
          enableBiometric: _enableBiometric,
        );
    if (!mounted) return;
    setState(() => _submitting = false);
    if (!ok) {
      _showError(ref.read(authControllerProvider).error ?? 'Login failed');
    }
  }

  Future<void> _biometricLogin() async {
    final ok = await ref
        .read(biometricServiceProvider)
        .authenticate(reason: 'Sign in to Pokopay');
    if (!ok || !mounted) return;
    setState(() => _submitting = true);
    final success = await ref
        .read(authControllerProvider.notifier)
        .loginWithBiometricCredentials();
    if (!mounted) return;
    setState(() => _submitting = false);
    if (!success) {
      _showError(
        ref.read(authControllerProvider).error ?? 'Biometric login failed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bioAvailable =
        ref.watch(biometricAvailableProvider).asData?.value ?? false;
    final showBiometricButton = bioAvailable && _hasSavedCredentials;

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
                        const SizedBox(height: 32),
                        const Center(child: PokopayMark()),
                        const SizedBox(height: 44),
                        Text('Welcome back', style: AppText.display()),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to your merchant account',
                          style: AppText.body(
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 36),
                        const _FieldLabel('Email address'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          style: AppText.body(size: 16),
                          decoration: const InputDecoration(
                            hintText: 'you@company.com',
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Email required';
                            }
                            if (!v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const _FieldLabel('Password'),
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Contact support to reset your password.',
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text('Forgot?'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscure,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          style: AppText.body(size: 16),
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            suffixIcon: IconButton(
                              splashRadius: 20,
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
                              ? 'Password required'
                              : null,
                        ),
                        if (bioAvailable) ...[
                          const SizedBox(height: 14),
                          GestureDetector(
                            onTap: () => setState(
                                () => _enableBiometric = !_enableBiometric),
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: Checkbox(
                                    value: _enableBiometric,
                                    onChanged: (v) => setState(
                                        () => _enableBiometric = v ?? false),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Enable biometric sign-in on this device',
                                  style: AppText.body(
                                    size: 14,
                                    color: AppColors.textSecondary,
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
                                            Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Signing in...',
                                      style: AppText.body(
                                        size: 16,
                                        weight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text('Sign in'),
                        ),
                        if (showBiometricButton) ...[
                          const SizedBox(height: 28),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(color: AppColors.hairline),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'or',
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
                          const SizedBox(height: 28),
                          OutlinedButton.icon(
                            onPressed: _submitting ? null : _biometricLogin,
                            icon: const Icon(LucideIcons.fingerprintPattern,
                                size: 24, color: AppColors.primary),
                            label: const Text('Continue with biometrics'),
                          ),
                        ],
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(LucideIcons.shieldCheck,
                                  size: 16, color: AppColors.textTertiary),
                              const SizedBox(width: 6),
                              Text(
                                'Bank-grade security',
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
