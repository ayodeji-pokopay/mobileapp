import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/transaction_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/error_text.dart';
import '../../../shared/format.dart';
import '../../../shared/pdf_share.dart';
import '../../../shared/widgets/pills.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../merchant/presentation/merchant_providers.dart';
import 'transaction_style.dart';

/// Opens the receipt for [t], fetching the full detail behind the row.
Future<void> showReceiptSheet(BuildContext context, TransactionResponse t) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => ReceiptSheet(summary: t),
  );
}

class ReceiptSheet extends ConsumerWidget {
  const ReceiptSheet({super.key, required this.summary});
  final TransactionResponse summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final ref_ = summary.reference ?? '';
    final detail = ref_.isEmpty
        ? AsyncValue.data(summary)
        : ref.watch(transactionDetailProvider(ref_));
    final t = detail.asData?.value ?? summary;
    final style = transactionStyle(t, l10n);
    final bottom = MediaQuery.paddingOf(context).bottom;

    Widget row(String k, String? v, {bool mono = false}) {
      if (v == null || v.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                k,
                style: AppText.body(size: 14, color: AppColors.textTertiary),
              ),
            ),
            Expanded(
              child: Text(
                v,
                textAlign: TextAlign.right,
                style: AppText.body(
                  size: 14,
                  weight: FontWeight.w500,
                  letterSpacing: mono ? 0.3 : null,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.72,
      maxChildSize: 0.95,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: EdgeInsets.fromLTRB(24, 12, 24, 24 + bottom),
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
          Row(
            children: [
              IconBubble(icon: style.icon, tone: style.tone, size: 44),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.receiptTitle, style: AppText.money(size: 17)),
                    const SizedBox(height: 4),
                    StatusPill(label: style.statusLabel, tone: style.tone),
                  ],
                ),
              ),
              Text(
                formatMoney(t.amount),
                style: AppText.money(
                  size: 22,
                  color: style.muted ? AppColors.textTertiary : AppColors.navy,
                  decoration: style.muted ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (detail.isLoading) ...[
            const Skeleton(height: 14, width: 200),
            const SizedBox(height: 10),
            const Skeleton(height: 14, width: 160),
            const SizedBox(height: 16),
          ] else if (detail.hasError)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                describeError(detail.error!, l10n),
                style: AppText.body(size: 13, color: AppColors.textSecondary),
              ),
            ),
          const Divider(),
          row(l10n.receiptDate, _dateTime(t.transactionDate)),
          row(
            l10n.receiptCard,
            (t.maskedPan ?? '').isEmpty
                ? null
                : l10n.cardLabel(
                    schemeName(t.cardScheme, l10n),
                    last4(t.maskedPan),
                  ),
          ),
          row(l10n.receiptStore, t.storeName),
          row(l10n.receiptTerminal, t.tid, mono: true),
          row(l10n.receiptChannel, _channel(t.channel, l10n)),
          const Divider(),
          row(l10n.receiptAmount, formatMoney(t.amount)),
          row(l10n.receiptFee, t.fee == null ? null : formatMoney(t.fee)),
          row(
            l10n.receiptNet,
            t.netAmount == null ? null : formatMoney(t.netAmount),
          ),
          const Divider(),
          row(l10n.receiptReference, t.reference, mono: true),
          row(l10n.receiptRrn, t.rrn, mono: true),
          row(l10n.receiptStan, t.stan, mono: true),
          row(l10n.receiptAuthCode, t.authCode, mono: true),
          row(l10n.receiptResponseCode, t.responseCode, mono: true),
          row(l10n.receiptOriginal, t.originalReference, mono: true),
          row(
            l10n.receiptSettlement,
            [
              if ((t.settlementReference ?? '').isNotEmpty)
                t.settlementReference!,
              if ((t.settlementStatus ?? '').isNotEmpty)
                _titleCase(t.settlementStatus!),
            ].join(' · '),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => shareText(
              l10n.receiptShareText(
                t.reference ?? '',
                formatMoney(t.amount),
                _dateTime(t.transactionDate) ?? '',
              ),
            ),
            icon: const Icon(LucideIcons.share2, size: 18),
            label: Text(l10n.receiptShare),
          ),
        ],
      ),
    );
  }

  String? _dateTime(String? iso) {
    if (iso == null || iso.isEmpty) return null;
    final d = DateTime.tryParse(iso);
    if (d == null) return iso;
    return '${formatDateShort(iso)} · ${formatTime(d)}';
  }

  String? _channel(String? c, AppLocalizations l10n) {
    return switch ((c ?? '').toUpperCase()) {
      'POS' => l10n.channelPos,
      'LINK' => l10n.channelLink,
      'TAP' => l10n.channelTap,
      '' => null,
      _ => _titleCase(c!),
    };
  }

  String _titleCase(String s) {
    final l = s.toLowerCase();
    return l.isEmpty ? s : l[0].toUpperCase() + l.substring(1);
  }
}
