import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../data/auth_repository.dart';
import '../../../l10n/generated/app_localizations.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _submitting = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .changePassword(
            currentPassword: _currentCtrl.text,
            newPassword: _newCtrl.text,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).changePasswordUpdated),
          backgroundColor: AppColors.primary,
        ),
      );
      context.pop();
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: AppColors.danger),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BackScaffold(
      title: l10n.changePasswordTitle,
      titleSize: 28,
      subtitle: l10n.changePasswordSubtitle,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            _Label(l10n.changePasswordCurrent),
            const SizedBox(height: 8),
            TextFormField(
              controller: _currentCtrl,
              obscureText: _obscureCurrent,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: '••••••••',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureCurrent ? LucideIcons.eye : LucideIcons.eyeOff,
                    size: 20,
                    color: AppColors.textTertiary,
                  ),
                  onPressed: () =>
                      setState(() => _obscureCurrent = !_obscureCurrent),
                ),
              ),
              validator: (v) => (v == null || v.isEmpty)
                  ? l10n.validationCurrentPasswordRequired
                  : null,
            ),
            const SizedBox(height: 16),
            _Label(l10n.changePasswordNew),
            const SizedBox(height: 8),
            TextFormField(
              controller: _newCtrl,
              obscureText: _obscureNew,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: l10n.changePasswordNewHint,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNew ? LucideIcons.eye : LucideIcons.eyeOff,
                    size: 20,
                    color: AppColors.textTertiary,
                  ),
                  onPressed: () => setState(() => _obscureNew = !_obscureNew),
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
            _Label(l10n.changePasswordConfirm),
            const SizedBox(height: 8),
            TextFormField(
              controller: _confirmCtrl,
              obscureText: _obscureNew,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
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
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(l10n.changePasswordButton),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
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
