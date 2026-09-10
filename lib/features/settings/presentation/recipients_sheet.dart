import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/api_error.dart';
import '../../../core/api/models/business_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/error_text.dart';
import '../../../shared/widgets/pills.dart';
import '../../merchant/presentation/merchant_providers.dart';

Future<void> showRecipientsSheet(
  BuildContext context,
  MerchantPreferences prefs,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => RecipientsSheet(initial: prefs.reportRecipients),
  );
}

/// Edit the list of report e-mail recipients (max 5), saved server-side.
class RecipientsSheet extends ConsumerStatefulWidget {
  const RecipientsSheet({super.key, required this.initial});
  final List<String> initial;

  @override
  ConsumerState<RecipientsSheet> createState() => _RecipientsSheetState();
}

class _RecipientsSheetState extends ConsumerState<RecipientsSheet> {
  static const _max = 5;
  late final List<String> _emails = [...widget.initial];
  final _ctrl = TextEditingController();
  String? _fieldError;
  bool _saving = false;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _add() {
    final l10n = AppLocalizations.of(context);
    final v = _ctrl.text.trim().toLowerCase();
    if (v.isEmpty) return;
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)) {
      setState(() => _fieldError = l10n.validationEmailInvalid);
      return;
    }
    if (_emails.contains(v)) {
      _ctrl.clear();
      return;
    }
    if (_emails.length >= _max) {
      setState(() => _fieldError = l10n.recipientsHint);
      return;
    }
    setState(() {
      _emails.add(v);
      _fieldError = null;
      _ctrl.clear();
    });
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _saving = true);
    try {
      await ref
          .read(preferencesProvider.notifier)
          .save(reportRecipients: _emails);
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.recipientsSaved)));
    } catch (e) {
      if (!mounted) return;
      final err = ApiError.from(e);
      setState(() {
        _saving = false;
        _fieldError =
            err.fieldErrors['reportRecipients'] ?? describeError(e, l10n);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final inset = MediaQuery.viewInsetsOf(context).bottom;
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        20 + (inset > 0 ? inset : bottom),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 20),
          Text(l10n.recipientsTitle, style: AppText.money(size: 17)),
          const SizedBox(height: 4),
          Text(
            l10n.recipientsHint,
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),
          if (_emails.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                l10n.settingsRecipientsCount(0),
                style: AppText.body(size: 14, color: AppColors.textTertiary),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final e in _emails)
                  InputChip(
                    label: Text(e, style: AppText.body(size: 13)),
                    avatar: const IconBubble(
                      icon: LucideIcons.mail,
                      tone: PillTone.info,
                      size: 22,
                    ),
                    deleteIcon: const Icon(LucideIcons.x, size: 14),
                    deleteButtonTooltipMessage: l10n.recipientsRemove(e),
                    onDeleted: () => setState(() => _emails.remove(e)),
                    backgroundColor: AppColors.canvas,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  onSubmitted: (_) => _add(),
                  style: AppText.body(size: 15),
                  decoration: InputDecoration(
                    hintText: l10n.recipientsEmailHint,
                    fillColor: AppColors.canvas,
                    errorText: _fieldError,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: _emails.length >= _max ? null : _add,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 48),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    backgroundColor: AppColors.canvas,
                  ),
                  child: Text(l10n.commonAdd),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Text(l10n.commonSave),
          ),
        ],
      ),
    );
  }
}
