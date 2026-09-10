import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../data/auth_repository.dart';

/// Step 1: ask for the account email and request a reset link.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key, this.initialEmail});
  final String? initialEmail;

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _emailCtrl = TextEditingController(text: widget.initialEmail);
  bool _sending = false;
  bool _sent = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _sending = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .forgotPassword(_emailCtrl.text.trim());
      if (!mounted) return;
      setState(() => _sent = true);
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: AppColors.danger),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _goToReset() {
    context.push(
      '${AppRoutes.resetPassword}?email=${Uri.encodeComponent(_emailCtrl.text.trim())}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BackScaffold(
      title: l10n.forgotTitle,
      titleSize: 30,
      fallbackRoute: AppRoutes.login,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
          children: [
            Text(
              l10n.forgotSubtitle,
              style: AppText.body(size: 15, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.loginEmailLabel,
              style: AppText.body(
                size: 14,
                weight: FontWeight.w500,
                color: AppColors.textBody,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _send(),
              style: AppText.body(size: 16),
              decoration: InputDecoration(hintText: l10n.loginEmailHint),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return l10n.validationEmailRequired;
                }
                if (!v.contains('@')) return l10n.validationEmailInvalid;
                return null;
              },
            ),
            const SizedBox(height: 20),
            if (_sent) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      LucideIcons.mailCheck,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.forgotSent(_emailCtrl.text.trim()),
                        style: AppText.body(
                          size: 14,
                          color: AppColors.primaryDark,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _goToReset, child: Text(l10n.haveCode)),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: _sending ? null : _send,
                child: Text(l10n.forgotResend),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: _sending ? null : _send,
                child: _sending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : Text(l10n.forgotButton),
              ),
              const SizedBox(height: 10),
              TextButton(onPressed: _goToReset, child: Text(l10n.haveCode)),
            ],
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => context.go(AppRoutes.login),
                child: Text(l10n.backToLogin),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Step 2: paste the emailed reset code and choose a new password.
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, this.email, this.token});
  final String? email;
  final String? token;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _tokenCtrl = TextEditingController(text: widget.token);
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure = true;
  bool _submitting = false;

  @override
  void dispose() {
    _tokenCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String _cleanToken(String raw) {
    // Accept the whole link pasted from the email.
    final t = raw.trim();
    final uri = Uri.tryParse(t);
    final fromQuery = uri?.queryParameters['token'];
    if (fromQuery != null && fromQuery.isNotEmpty) return fromQuery;
    return t;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final l10n = AppLocalizations.of(context);
    setState(() => _submitting = true);
    final repo = ref.read(authRepositoryProvider);
    final token = _cleanToken(_tokenCtrl.text);
    try {
      await repo.verifyResetToken(token);
      await repo.resetPassword(token: token, newPassword: _newCtrl.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.resetSuccess),
          backgroundColor: AppColors.primary,
        ),
      );
      context.go(AppRoutes.login);
    } on AuthException catch (e) {
      if (!mounted) return;
      final invalid =
          e.code == 'RESET_TOKEN_INVALID' ||
          e.message.toLowerCase().contains('token') ||
          e.message.toLowerCase().contains('expired');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(invalid ? l10n.resetInvalidToken : e.message),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget label(String t) => Text(
      t,
      style: AppText.body(
        size: 14,
        weight: FontWeight.w500,
        color: AppColors.textBody,
      ),
    );
    return BackScaffold(
      title: l10n.resetTitle,
      titleSize: 30,
      fallbackRoute: AppRoutes.forgotPassword,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
          children: [
            if ((widget.email ?? '').isNotEmpty) ...[
              Text(
                widget.email!,
                style: AppText.body(size: 15, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
            ],
            label(l10n.resetTokenLabel),
            const SizedBox(height: 8),
            TextFormField(
              controller: _tokenCtrl,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              style: AppText.body(size: 15),
              decoration: InputDecoration(
                hintText: l10n.resetTokenHint,
                helperText: l10n.resetTokenHelp,
                helperStyle: AppText.body(
                  size: 12,
                  color: AppColors.textTertiary,
                ),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? l10n.validationResetTokenRequired
                  : null,
            ),
            const SizedBox(height: 16),
            label(l10n.changePasswordNew),
            const SizedBox(height: 8),
            TextFormField(
              controller: _newCtrl,
              obscureText: _obscure,
              autofillHints: const [AutofillHints.newPassword],
              textInputAction: TextInputAction.next,
              style: AppText.body(size: 16),
              decoration: InputDecoration(
                hintText: l10n.changePasswordNewHint,
                suffixIcon: IconButton(
                  tooltip: _obscure ? l10n.showPassword : l10n.hidePassword,
                  icon: Icon(
                    _obscure ? LucideIcons.eye : LucideIcons.eyeOff,
                    size: 20,
                    color: AppColors.textTertiary,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return l10n.validationNewPasswordRequired;
                }
                if (v.length < 8) return l10n.validationPasswordLength;
                return null;
              },
            ),
            const SizedBox(height: 16),
            label(l10n.changePasswordConfirm),
            const SizedBox(height: 8),
            TextFormField(
              controller: _confirmCtrl,
              obscureText: _obscure,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              style: AppText.body(size: 16),
              decoration: InputDecoration(
                hintText: l10n.changePasswordConfirmHint,
              ),
              validator: (v) =>
                  v == _newCtrl.text ? null : l10n.validationPasswordsMismatch,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(l10n.resetButton),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => context.go(AppRoutes.login),
                child: Text(l10n.backToLogin),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
