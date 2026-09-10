import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/transaction_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/pdf/pokopay_pdf.dart';
import '../../../shared/pdf_share.dart';
import '../../../shared/widgets/card_brand_logo.dart';
import '../../../shared/widgets/pills.dart';
import '../../../shared/widgets/pokopay_logo.dart';
import '../../merchant/presentation/merchant_providers.dart';
import 'transaction_style.dart';

/// Opens the receipt for [t], fetching the full detail behind the row.
Future<void> showReceiptSheet(BuildContext context, TransactionResponse t) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.canvas,
    builder: (_) => ReceiptSheet(summary: t),
  );
}

class ReceiptSheet extends ConsumerStatefulWidget {
  const ReceiptSheet({super.key, required this.summary});
  final TransactionResponse summary;

  @override
  ConsumerState<ReceiptSheet> createState() => _ReceiptSheetState();
}

class _ReceiptSheetState extends ConsumerState<ReceiptSheet> {
  bool _sharing = false;

  Future<void> _share(TransactionResponse t) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _sharing = true);
    try {
      final style = transactionStyle(t, l10n);
      final bytes = await buildReceiptPdf(
        t: t,
        business: ref.read(businessNameProvider),
        l10n: l10n,
        statusLabel: style.statusLabel,
        approved: style.tone == PillTone.success,
      );
      await sharePdf(
        bytes,
        fileName: 'pokopay-receipt-${t.reference ?? 'txn'}.pdf',
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.receiptImageFailed)));
      }
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final ref_ = widget.summary.reference ?? '';
    final detail = ref_.isEmpty
        ? AsyncValue.data(widget.summary)
        : ref.watch(transactionDetailProvider(ref_));
    final t = detail.asData?.value ?? widget.summary;
    final business = ref.watch(businessNameProvider);
    final bottom = MediaQuery.paddingOf(context).bottom;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.86,
      maxChildSize: 0.96,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: EdgeInsets.fromLTRB(16, 10, 16, 20 + bottom),
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderStrong,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 14),
          ReceiptCard(t: t, business: business),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: _sharing ? null : () => _share(t),
            icon: const Icon(LucideIcons.share2, size: 18),
            label: Text(l10n.receiptShare),
          ),
        ],
      ),
    );
  }
}

/// The printable receipt. Everything on it is also what gets shared.
class ReceiptCard extends StatelessWidget {
  const ReceiptCard({super.key, required this.t, required this.business});
  final TransactionResponse t;
  final String business;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = transactionStyle(t, l10n);
    final d = DateTime.tryParse(t.transactionDate ?? '');

    Widget row(String k, String? v, {bool mono = false, Widget? lead}) {
      if ((v == null || v.isEmpty) && lead == null)
        return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 118,
              child: Text(
                k,
                style: AppText.body(size: 13, color: AppColors.textTertiary),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (lead != null) ...[lead, const SizedBox(width: 8)],
                  Flexible(
                    child: Text(
                      v ?? '',
                      textAlign: TextAlign.right,
                      style: AppText.body(
                        size: 13.5,
                        weight: FontWeight.w500,
                        letterSpacing: mono ? 0.3 : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            decoration: const BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const PokopaySymbol(size: 26),
                    const SizedBox(width: 8),
                    Text(
                      'pokopay',
                      style: AppText.display(
                        size: 18,
                        color: Colors.white,
                        letterSpacing: -0.4,
                        height: 1,
                      ),
                    ),
                    const Spacer(),
                    StatusPill(label: style.statusLabel, tone: style.tone),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.receiptTitle.toUpperCase(),
                  style: AppText.label(
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatMoney(t.amount),
                  style: AppText.display(
                    size: 34,
                    color: Colors.white,
                    height: 1,
                    decoration: style.muted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  [
                    business,
                    if (d != null)
                      '${formatDateShort(t.transactionDate)} · ${formatTime(d)}',
                  ].join(' · '),
                  style: AppText.body(
                    size: 12.5,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
          // Perforation
          const _Perforation(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                row(
                  l10n.receiptCard,
                  '${cardDescription(t, l10n)}\n${t.maskedPan ?? ''}',
                  lead: CardBrandLogo(scheme: t.scheme, size: 34),
                ),
                row(l10n.receiptBank, t.cardBank),
                row(l10n.receiptTerminal, t.tid, mono: true),
                const Divider(height: 18),
                row(l10n.receiptAmount, formatMoney(t.amount)),
                row(l10n.receiptFee, t.fee == null ? null : formatMoney(t.fee)),
                row(
                  l10n.receiptNet,
                  t.netAmount == null ? null : formatMoney(t.netAmount),
                ),
                const Divider(height: 18),
                row(l10n.receiptReference, t.reference, mono: true),
                row(l10n.receiptStan, t.stan, mono: true),
                row(l10n.receiptRrn, t.rrn, mono: true),
                row(l10n.receiptAuthCode, t.authCode, mono: true),
                row(
                  l10n.receiptResponse,
                  [
                    if ((t.responseCode ?? '').isNotEmpty) t.responseCode!,
                    if ((t.responseCodeDescription ?? '').isNotEmpty)
                      t.responseCodeDescription!,
                  ].join(' · '),
                  mono: true,
                ),
                if ((t.errorMessage ?? '').isNotEmpty)
                  row(l10n.settlementFailureReason, t.errorMessage),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    l10n.receiptPoweredBy,
                    style: AppText.body(
                      size: 11,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Perforation extends StatelessWidget {
  const _Perforation();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Stack(
        children: [
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, c) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  (c.maxWidth / 12).floor(),
                  (_) => Container(
                    width: 6,
                    height: 1,
                    color: AppColors.borderStrong,
                  ),
                ),
              ),
            ),
          ),
          Positioned(left: -10, top: 0, child: _Notch()),
          Positioned(right: -10, top: 0, child: _Notch()),
        ],
      ),
    );
  }
}

class _Notch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: AppColors.canvas,
        shape: BoxShape.circle,
      ),
    );
  }
}
