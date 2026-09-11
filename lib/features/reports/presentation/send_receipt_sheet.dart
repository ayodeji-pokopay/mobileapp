import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/api/models/transaction_models.dart';
import '../../../core/config/app_config_provider.dart';
import '../../../core/printing/receipt_printer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/pills.dart';
import '../../merchant/presentation/merchant_providers.dart';
import 'transaction_style.dart';

Future<void> showSendReceiptSheet(BuildContext context, TransactionResponse t) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => SendReceiptSheet(t: t),
  );
}

/// Plain-text receipt for SMS / WhatsApp.
String receiptText(
  TransactionResponse t,
  String business,
  AppLocalizations l10n,
) {
  final d = DateTime.tryParse(t.transactionDate ?? '')?.toLocal();
  final lines = <String>[
    '${l10n.receiptTextHeader} · $business',
    if (d != null) '${formatDateShort(t.transactionDate)} ${formatTime(d)}',
    '${l10n.receiptAmount}: ${formatMoney(t.amount)}',
    if ((t.maskedPan ?? '').isNotEmpty)
      '${l10n.receiptCard}: ${cardDescription(t, l10n)} ${t.maskedPan}',
    if ((t.tid ?? '').isNotEmpty) '${l10n.receiptTerminal}: ${t.tid}',
    if ((t.reference ?? '').isNotEmpty)
      '${l10n.receiptReference}: ${t.reference}',
    if ((t.responseCode ?? '').isNotEmpty)
      '${l10n.receiptResponse}: ${t.responseCode} ${t.responseCodeDescription ?? ''}'
          .trim(),
    l10n.receiptPoweredBy,
  ];
  return lines.join('\n');
}

class SendReceiptSheet extends ConsumerStatefulWidget {
  const SendReceiptSheet({super.key, required this.t});
  final TransactionResponse t;

  @override
  ConsumerState<SendReceiptSheet> createState() => _SendReceiptSheetState();
}

class _SendReceiptSheetState extends ConsumerState<SendReceiptSheet> {
  final _phone = TextEditingController();
  bool _printing = false;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  /// Local numbers ("0803…") become international ("234803…") using the
  /// dial code from remote config; keeps digits only.
  String _normalised() {
    final dial = ref.read(appConfigProvider).asData?.value.dialCode ?? '234';
    var digits = _phone.text.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('0')) digits = '$dial${digits.substring(1)}';
    return digits;
  }

  Future<void> _open(Uri uri) async {
    final l10n = AppLocalizations.of(context);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.sendReceiptAppMissing)));
    }
  }

  Future<void> _whatsapp(String text) {
    final n = _normalised();
    return _open(
      Uri.parse(
        'https://wa.me/${n.isEmpty ? '' : n}?text=${Uri.encodeComponent(text)}',
      ),
    );
  }

  Future<void> _sms(String text) {
    final n = _normalised();
    final target = n.isEmpty ? '' : '+$n';
    // iOS wants "&body", Android "?body"; the "&" form works on both.
    return _open(
      Uri.parse(
        'sms:$target${Theme.of(context).platform == TargetPlatform.iOS ? '&' : '?'}body=${Uri.encodeComponent(text)}',
      ),
    );
  }

  Future<void> _print() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _printing = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final style = transactionStyle(widget.t, l10n);
      await ref
          .read(receiptPrinterProvider)
          .printReceipt(
            widget.t,
            business: ref.read(businessNameProvider),
            statusLabel: style.statusLabel,
          );
      messenger.showSnackBar(SnackBar(content: Text(l10n.printerPrinted)));
    } on PrinterException catch (e) {
      final msg = switch (e.code) {
        'BLUETOOTH_OFF' => l10n.printerBluetoothOff,
        'NOT_CONFIGURED' => l10n.printerNone,
        _ => l10n.printerConnectFailed,
      };
      messenger.showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: AppColors.danger),
      );
    } catch (_) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.printerConnectFailed),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _printing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final business = ref.watch(businessNameProvider);
    final printer = ref.watch(printerSettingsProvider).asData?.value;
    final text = receiptText(widget.t, business, l10n);
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
          const SizedBox(height: 18),
          Text(l10n.sendReceiptTitle, style: AppText.money(size: 17)),
          const SizedBox(height: 4),
          Text(
            '${formatMoney(widget.t.amount)} · ${widget.t.reference ?? ''}',
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            style: AppText.body(size: 15),
            decoration: InputDecoration(
              labelText: l10n.sendReceiptPhone,
              hintText: l10n.sendReceiptPhoneHint,
              fillColor: AppColors.canvas,
              prefixIcon: const Icon(LucideIcons.phone, size: 18),
            ),
          ),
          const SizedBox(height: 14),
          ListCard(
            children: [
              ListRow(
                leading: const IconBubble(
                  icon: LucideIcons.messageCircle,
                  tone: PillTone.success,
                ),
                title: l10n.sendReceiptWhatsApp,
                chevron: false,
                onTap: () => _whatsapp(text),
              ),
              ListRow(
                leading: const IconBubble(
                  icon: LucideIcons.messageSquare,
                  tone: PillTone.info,
                ),
                title: l10n.sendReceiptSms,
                chevron: false,
                onTap: () => _sms(text),
              ),
              ListRow(
                leading: const IconBubble(
                  icon: LucideIcons.copy,
                  tone: PillTone.neutral,
                ),
                title: l10n.sendReceiptCopy,
                chevron: false,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.sendReceiptCopied)),
                  );
                },
              ),
              ListRow(
                leading: const IconBubble(
                  icon: LucideIcons.printer,
                  tone: PillTone.neutral,
                ),
                title: l10n.sendReceiptPrint,
                subtitle: printer?.configured == true
                    ? printer!.name
                    : l10n.printerNone,
                chevron: false,
                trailing: _printing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
                onTap: _printing ? null : _print,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
