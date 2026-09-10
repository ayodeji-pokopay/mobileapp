import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/api/models/business_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/error_text.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/data/merchant_repository.dart' show merchantRepositoryProvider;
import '../../merchant/presentation/merchant_providers.dart';

Future<void> showRenameTerminalSheet(BuildContext context, TerminalResponse t) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _RenameTerminalSheet(t: t),
  );
}

class _RenameTerminalSheet extends ConsumerStatefulWidget {
  const _RenameTerminalSheet({required this.t});
  final TerminalResponse t;

  @override
  ConsumerState<_RenameTerminalSheet> createState() =>
      _RenameTerminalSheetState();
}

class _RenameTerminalSheetState extends ConsumerState<_RenameTerminalSheet> {
  late final _ctrl = TextEditingController(text: widget.t.label ?? '');
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final label = _ctrl.text.trim();
    if (label.isEmpty) return;
    final mid = ref.read(authControllerProvider).mid;
    final id = widget.t.id ?? widget.t.tid;
    if (mid == null || id == null) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(merchantRepositoryProvider)
          .updateTerminalLabel(mid: mid, id: id, label: label);
      ref.invalidate(terminalsProvider);
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.terminalRenamed)));
    } catch (e) {
      final status = e is ApiError ? e.status : null;
      setState(() {
        _error = status != null && status >= 500
            ? l10n.terminalRenameUnavailable
            : describeError(e, l10n);
      });
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final inset = MediaQuery.viewInsetsOf(context).bottom;
    final bottom = MediaQuery.paddingOf(context).bottom;
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
          Text(l10n.terminalRename, style: AppText.money(size: 17)),
          const SizedBox(height: 4),
          Text(
            [
              if ((widget.t.tid ?? '').isNotEmpty) l10n.tidLabel(widget.t.tid!),
              if ((widget.t.serialNumber ?? '').isNotEmpty)
                l10n.terminalSerial(widget.t.serialNumber!),
            ].join(' · '),
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _ctrl,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            maxLength: 40,
            style: AppText.body(size: 15),
            decoration: InputDecoration(
              labelText: l10n.terminalRenameLabel,
              hintText: l10n.terminalRenameHint,
              fillColor: AppColors.canvas,
              counterText: '',
            ),
            onSubmitted: (_) => _save(),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(
              _error!,
              style: AppText.body(size: 13, color: AppColors.danger),
            ),
          ],
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(l10n.commonSave),
          ),
        ],
      ),
    );
  }
}
