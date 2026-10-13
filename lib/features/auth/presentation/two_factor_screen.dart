import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../data/auth_repository.dart';
import '../password_policy.dart';
import 'auth_controller.dart';

/// Second step of sign-in. Two-factor authentication is required for every
/// Pokopay account, so after a correct password the user either enters the
/// code from their authenticator app, or — the first time — adds Pokopay to an
/// authenticator app, confirms a code and saves their recovery codes.
/// Store pages for Microsoft Authenticator, the app we point users to.
const _msAuthenticatorIos =
    'https://apps.apple.com/app/microsoft-authenticator/id983156458';
const _msAuthenticatorAndroid =
    'https://play.google.com/store/apps/details?id=com.azure.authenticator';

class TwoFactorScreen extends ConsumerStatefulWidget {
  const TwoFactorScreen({super.key});

  @override
  ConsumerState<TwoFactorScreen> createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends ConsumerState<TwoFactorScreen> {
  final _codeCtrl = TextEditingController();
  bool _submitting = false;
  bool _useRecoveryCode = false;
  MfaSetupInfo? _setup;
  String? _setupError;
  List<String>? _recoveryCodes;

  bool get _isSetup => ref.read(pendingMfaProvider)?.setup ?? false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (ref.read(pendingMfaProvider) == null) {
        context.go(AppRoutes.login);
      } else if (_isSetup) {
        _loadSetup();
      }
    });
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadSetup() async {
    try {
      final info = await ref
          .read(authControllerProvider.notifier)
          .startMfaSetup();
      if (mounted) setState(() => _setup = info);
    } on AuthException catch (e) {
      if (!mounted) return;
      if (e.code == AuthException.mfaExpired) return _expired();
      setState(
        () => _setupError = authMessage(e, AppLocalizations.of(context)),
      );
    }
  }

  void _expired() {
    ref.read(authControllerProvider.notifier).cancelMfa();
    _snack(AppLocalizations.of(context).twoFactorExpired);
    context.go(AppRoutes.login);
  }

  void _snack(String message, {bool error = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? AppColors.danger : AppColors.primary,
      ),
    );
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final code = _codeCtrl.text.replaceAll(RegExp(r'\s'), '');
    if (code.isEmpty || (!_useRecoveryCode && code.length != 6)) {
      _snack(l10n.twoFactorCodeInvalidFormat);
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() => _submitting = true);
    final auth = ref.read(authControllerProvider.notifier);
    try {
      if (_isSetup) {
        final codes = await auth.confirmMfaSetup(code);
        if (mounted) setState(() => _recoveryCodes = codes);
      } else {
        await auth.completeMfa(
          code: _useRecoveryCode ? null : code,
          recoveryCode: _useRecoveryCode ? code : null,
        );
        // The router moves a signed-in user to the dashboard.
      }
    } on AuthException catch (e) {
      if (!mounted) return;
      if (e.code == AuthException.mfaExpired) return _expired();
      _codeCtrl.clear();
      _snack(
        e.code == AuthException.mfaInvalidCode
            ? l10n.twoFactorCodeWrong
            : authMessage(e, l10n),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _openAuthenticator() async {
    final uri = Uri.tryParse(_setup?.otpauthUri ?? '');
    final opened =
        uri != null &&
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        ).catchError((_) => false);
    if (!opened && mounted) {
      _snack(AppLocalizations.of(context).twoFactorNoAuthenticatorApp);
      await _getAuthenticator();
    }
  }

  Future<void> _getAuthenticator() async {
    final store = defaultTargetPlatform == TargetPlatform.iOS
        ? _msAuthenticatorIos
        : _msAuthenticatorAndroid;
    await launchUrl(
      Uri.parse(store),
      mode: LaunchMode.externalApplication,
    ).catchError((_) => false);
  }

  Future<void> _copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      _snack(AppLocalizations.of(context).twoFactorCopied, error: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final setup = ref.watch(pendingMfaProvider)?.setup ?? false;
    if (_recoveryCodes != null) return _recoveryCodesView(l10n);

    return BackScaffold(
      title: setup ? l10n.twoFactorSetupTitle : l10n.twoFactorTitle,
      titleSize: 28,
      subtitle: setup
          ? l10n.twoFactorSetupSubtitle
          : (_useRecoveryCode
                ? l10n.twoFactorRecoverySubtitle
                : l10n.twoFactorSubtitle),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          if (setup) ..._setupSteps(l10n),
          _Label(
            _useRecoveryCode
                ? l10n.twoFactorRecoveryLabel
                : l10n.twoFactorCodeLabel,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _codeCtrl,
            autofocus: !setup,
            keyboardType: _useRecoveryCode
                ? TextInputType.visiblePassword
                : TextInputType.number,
            autofillHints: const [AutofillHints.oneTimeCode],
            inputFormatters: _useRecoveryCode
                ? null
                : [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            style: AppText.body(size: 20, weight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: _useRecoveryCode ? 'xxxx-xxxx' : '123456',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitting || (setup && _setup == null)
                ? null
                : _submit,
            child: _submitting
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    setup
                        ? l10n.twoFactorConfirmButton
                        : l10n.twoFactorVerifyButton,
                  ),
          ),
          if (!setup) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => setState(() {
                _useRecoveryCode = !_useRecoveryCode;
                _codeCtrl.clear();
              }),
              child: Text(
                _useRecoveryCode
                    ? l10n.twoFactorUseApp
                    : l10n.twoFactorUseRecovery,
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _setupSteps(AppLocalizations l10n) {
    if (_setupError != null) {
      return [
        Text(
          _setupError!,
          style: AppText.body(size: 14, color: AppColors.danger),
        ),
        const SizedBox(height: 24),
      ];
    }
    final info = _setup;
    if (info == null) {
      return const [
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 24),
      ];
    }
    return [
      Text(
        l10n.twoFactorSetupStep1,
        style: AppText.body(size: 14, color: AppColors.textBody),
      ),
      const SizedBox(height: 12),
      OutlinedButton.icon(
        onPressed: _openAuthenticator,
        icon: const Icon(LucideIcons.externalLink, size: 18),
        label: Text(l10n.twoFactorOpenAuthenticator),
      ),
      TextButton.icon(
        onPressed: _getAuthenticator,
        icon: const Icon(LucideIcons.download, size: 18),
        label: Text(l10n.twoFactorGetAuthenticator),
      ),
      const SizedBox(height: 16),
      Text(
        l10n.twoFactorSetupKeyHint,
        style: AppText.body(size: 13, color: AppColors.textSecondary),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: SelectableText(
              _grouped(info.secret),
              style: AppText.body(size: 15, weight: FontWeight.w600),
            ),
          ),
          IconButton(
            tooltip: l10n.twoFactorCopy,
            icon: const Icon(LucideIcons.copy, size: 18),
            onPressed: () => _copy(info.secret),
          ),
        ],
      ),
      const SizedBox(height: 24),
      Text(
        l10n.twoFactorSetupStep2,
        style: AppText.body(size: 14, color: AppColors.textBody),
      ),
      const SizedBox(height: 12),
    ];
  }

  Widget _recoveryCodesView(AppLocalizations l10n) {
    final codes = _recoveryCodes!;
    return BackScaffold(
      title: l10n.twoFactorRecoveryCodesTitle,
      titleSize: 28,
      subtitle: l10n.twoFactorRecoveryCodesSubtitle,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              for (final c in codes)
                SelectableText(
                  c,
                  style: AppText.body(size: 15, weight: FontWeight.w600),
                ),
            ],
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => _copy(codes.join('\n')),
            icon: const Icon(LucideIcons.copy, size: 18),
            label: Text(l10n.twoFactorCopyAll),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () =>
                ref.read(authControllerProvider.notifier).finishMfaSetup(),
            child: Text(l10n.twoFactorSavedCodesButton),
          ),
        ],
      ),
    );
  }

  /// "JBSWY3DPEHPK3PXP" -> "JBSW Y3DP EHPK 3PXP", easier to type by hand.
  static String _grouped(String secret) =>
      secret.replaceAllMapped(RegExp(r'.{4}'), (m) => '${m.group(0)} ').trim();
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
