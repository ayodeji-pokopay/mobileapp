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

/// A staff member invited from the Staff screen sets their name and
/// password with the code from their email (`POST /auth/accept-invite`).
class AcceptInviteScreen extends ConsumerStatefulWidget {
  const AcceptInviteScreen({super.key, this.code});
  final String? code;

  @override
  ConsumerState<AcceptInviteScreen> createState() => _AcceptInviteScreenState();
}

class _AcceptInviteScreenState extends ConsumerState<AcceptInviteScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _codeCtrl = TextEditingController(text: _clean(widget.code ?? ''));
  final _firstCtrl = TextEditingController();
  final _lastCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure = true;
  bool _submitting = false;

  @override
  void dispose() {
    for (final c in [
      _codeCtrl,
      _firstCtrl,
      _lastCtrl,
      _passCtrl,
      _confirmCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Accept the whole link pasted from the email.
  String _clean(String raw) {
    final v = raw.trim();
    final uri = Uri.tryParse(v);
    final fromQuery = uri?.queryParameters['code'];
    if (fromQuery != null && fromQuery.isNotEmpty) return fromQuery;
    return v;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    FocusScope.of(context).unfocus();
    setState(() => _submitting = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .acceptInvite(
            code: _clean(_codeCtrl.text),
            password: _passCtrl.text,
            firstName: _firstCtrl.text.trim(),
            lastName: _lastCtrl.text.trim(),
          );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.inviteAccepted)));
      context.go(AppRoutes.login);
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.code == AuthException.network
                ? l10n.errorNetwork
                : e.code == AuthException.serverUnavailable
                ? l10n.errorServiceUnavailable
                : (e.message.isNotEmpty ? e.message : l10n.inviteInvalid),
          ),
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
      title: l10n.inviteTitle,
      titleSize: 30,
      subtitle: l10n.inviteSubtitle,
      fallbackRoute: AppRoutes.login,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
          children: [
            label(l10n.inviteCodeLabel),
            const SizedBox(height: 8),
            TextFormField(
              controller: _codeCtrl,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              style: AppText.body(size: 15),
              decoration: InputDecoration(hintText: l10n.inviteCodeHint),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? l10n.inviteCodeRequired
                  : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label(l10n.inviteFirstName),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _firstCtrl,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        style: AppText.body(size: 15),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? l10n.inviteNameRequired
                            : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label(l10n.inviteLastName),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _lastCtrl,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        style: AppText.body(size: 15),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? l10n.inviteNameRequired
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            label(l10n.changePasswordNew),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passCtrl,
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
                if (v == null || v.isEmpty)
                  return l10n.validationNewPasswordRequired;
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
                  v == _passCtrl.text ? null : l10n.validationPasswordsMismatch,
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
                  : Text(l10n.inviteButton),
            ),
          ],
        ),
      ),
    );
  }
}
