import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/business_models.dart';
import '../../../core/api/models/merchant_models.dart';
import '../../../core/config/app_config_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/error_text.dart';
import '../../../shared/format.dart';
import '../../../shared/pdf_share.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../../shared/widgets/pills.dart';
import '../../../shared/widgets/section_label.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/data/merchant_repository.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../../wallet/presentation/wallet_screen.dart' show cycleLabel;

class SettlementsScreen extends ConsumerStatefulWidget {
  const SettlementsScreen({super.key, this.initialTab});

  /// "history", "statements" or "invoices".
  final String? initialTab;

  @override
  ConsumerState<SettlementsScreen> createState() => _SettlementsScreenState();
}

class _SettlementsScreenState extends ConsumerState<SettlementsScreen> {
  static const _statuses = [null, 'COMPLETED', 'PENDING', 'FAILED'];
  late int _segment = switch (widget.initialTab) {
    'statements' => 1,
    'invoices' => 2,
    _ => 0,
  };
  late int _year = DateTime.now().year;
  String? _downloading;

  Future<void> _download(StatementResponse s) async {
    final l10n = AppLocalizations.of(context);
    final mid = ref.read(authControllerProvider).mid;
    final id = s.id;
    if (mid == null || id == null || _downloading != null) return;
    setState(() => _downloading = id);
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(SnackBar(content: Text(l10n.statementDownloading)));
    try {
      final bytes = await ref
          .read(merchantRepositoryProvider)
          .downloadStatementPdf(id, mid: mid);
      await sharePdf(
        bytes,
        fileName: 'pokopay-statement-${s.period ?? id}.pdf',
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            '${l10n.statementDownloadFailed} ${describeError(e, l10n)}',
          ),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _downloading = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final invoices =
        ref.watch(appConfigProvider).asData?.value.features.invoices ?? false;
    final segments = [
      l10n.settlementsTab,
      l10n.statementsTab,
      if (invoices) l10n.invoicesTab,
    ];
    final segment = _segment.clamp(0, segments.length - 1);

    return BackScaffold(
      title: l10n.settlementsTitle,
      titleSize: 30,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(filteredSettlementsProvider);
          ref.invalidate(statementsProvider(_year));
          await ref.read(filteredSettlementsProvider.future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            const OfflineBanner(),
            SegmentedControl(
              items: segments,
              selected: segment,
              onChanged: (i) => setState(() => _segment = i),
            ),
            const SizedBox(height: 18),
            switch (segment) {
              0 => _history(l10n),
              1 => _statements(l10n),
              _ => EmptyState(
                icon: LucideIcons.receipt,
                title: l10n.invoicesEmpty,
                subtitle: l10n.invoicesEmptyHint,
              ),
            },
          ],
        ),
      ),
    );
  }

  Widget _history(AppLocalizations l10n) {
    final status = ref.watch(settlementStatusProvider);
    final data = ref.watch(filteredSettlementsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PillTabs(
          scrollable: true,
          inactiveColor: AppColors.surface,
          inactiveTextColor: AppColors.textBody,
          items: [
            l10n.filterAll,
            l10n.filterCompleted,
            l10n.filterPending,
            l10n.filterFailed,
          ],
          selected: _statuses.indexOf(status),
          onChanged: (i) =>
              ref.read(settlementStatusProvider.notifier).set(_statuses[i]),
        ),
        const SizedBox(height: 18),
        AsyncSlot<PageSettlementResponse>(
          value: data,
          loadingHeight: 240,
          onRetry: () => ref.invalidate(filteredSettlementsProvider),
          data: (page) {
            final items = page.content;
            if (items.isEmpty) {
              return EmptyState(
                icon: LucideIcons.fileText,
                title: l10n.settlementsEmpty,
                subtitle: l10n.settlementsEmptyHint,
              );
            }
            final groups = <int, List<SettlementResponse>>{};
            for (final s in items) {
              groups
                  .putIfAbsent(yearOf(s.settlementDate) ?? 0, () => [])
                  .add(s);
            }
            final years = groups.keys.toList()..sort((a, b) => b.compareTo(a));
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final y in years) ...[
                  SectionLabel(y == 0 ? l10n.commonUndated : '$y'),
                  ListCard(
                    children: [
                      for (final s in groups[y]!)
                        _SettlementRow(
                          s: s,
                          onTap: () => showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => _SettlementSheet(s: s),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 18),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _statements(AppLocalizations l10n) {
    final now = DateTime.now().year;
    final years = [now, now - 1, now - 2];
    final data = ref.watch(statementsProvider(_year));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PillTabs(
          scrollable: true,
          inactiveColor: AppColors.surface,
          inactiveTextColor: AppColors.textBody,
          items: [for (final y in years) '$y'],
          selected: years.indexOf(_year),
          onChanged: (i) => setState(() => _year = years[i]),
        ),
        const SizedBox(height: 18),
        AsyncSlot<List<StatementResponse>>(
          value: data,
          loadingHeight: 200,
          onRetry: () => ref.invalidate(statementsProvider(_year)),
          data: (list) {
            if (list.isEmpty) {
              return EmptyState(
                icon: LucideIcons.fileText,
                title: l10n.statementsEmpty,
                subtitle: l10n.statementsEmptyHint,
              );
            }
            final sorted = [...list]
              ..sort((a, b) => (b.period ?? '').compareTo(a.period ?? ''));
            return ListCard(
              children: [
                for (final s in sorted)
                  ListRow(
                    onTap: () => _download(s),
                    leading: const IconBubble(
                      icon: LucideIcons.fileText,
                      tone: PillTone.neutral,
                    ),
                    title: formatPeriod(s.period),
                    subtitle: [
                      l10n.statementSettlements(s.settlementCount ?? 0),
                      formatMoney(s.netSettled),
                    ].join(' · '),
                    chevron: false,
                    trailing: _downloading == s.id
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(
                            LucideIcons.fileDown,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

(IconData, PillTone, String) _statusStyle(
  String? status,
  AppLocalizations l10n,
) {
  return switch ((status ?? 'PENDING').toUpperCase()) {
    'COMPLETED' => (
      LucideIcons.circleCheck,
      PillTone.success,
      l10n.statusCompleted,
    ),
    'FAILED' => (LucideIcons.circleX, PillTone.danger, l10n.statusFailed),
    _ => (LucideIcons.clock, PillTone.warning, l10n.statusPending),
  };
}

class _SettlementRow extends StatelessWidget {
  const _SettlementRow({required this.s, required this.onTap});
  final SettlementResponse s;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (icon, tone, _) = _statusStyle(s.status, l10n);
    final count = s.transactionCount ?? 0;
    return ListRow(
      onTap: onTap,
      leading: IconBubble(icon: icon, tone: tone, size: 36),
      title: formatDateShort(s.settlementDate),
      subtitle: [
        if ((s.settlementReference ?? '').isNotEmpty) s.settlementReference!,
        l10n.settlementTxns(count),
        if ((s.cycle ?? '').isNotEmpty) cycleLabel(s.cycle, l10n),
      ].join(' · '),
      trailing: Text(formatMoney(s.netAmount), style: AppText.money(size: 15)),
      chevron: true,
    );
  }
}

class _SettlementSheet extends StatelessWidget {
  const _SettlementSheet({required this.s});
  final SettlementResponse s;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (icon, tone, label) = _statusStyle(s.status, l10n);
    final bottom = MediaQuery.paddingOf(context).bottom;
    Widget row(String k, String? v, {bool mono = false}) {
      if (v == null || v.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
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

    final settledAt = DateTime.tryParse(s.settledAt ?? '');

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 24 + bottom),
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
          Row(
            children: [
              IconBubble(icon: icon, tone: tone, size: 44),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settlementDetailTitle,
                      style: AppText.money(size: 17),
                    ),
                    const SizedBox(height: 4),
                    StatusPill(label: label, tone: tone),
                  ],
                ),
              ),
              Text(formatMoney(s.netAmount), style: AppText.money(size: 20)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          row(l10n.settlementReference, s.settlementReference, mono: true),
          row(l10n.settlementBatch, s.batchReference, mono: true),
          row(l10n.settlementCycle, cycleLabel(s.cycle, l10n)),
          row(
            l10n.settlementSettledAt,
            settledAt == null
                ? null
                : '${formatDateShort(s.settledAt)} · ${formatTime(settledAt)}',
          ),
          row(l10n.settlementFailureReason, s.failureReason),
          row(l10n.settlementTransactions, formatNumber(s.transactionCount)),
          row(
            l10n.settlementGross,
            formatMoney(s.grossAmount ?? s.totalTransactionAmount),
          ),
          row(
            l10n.settlementTransactionFees,
            formatMoney(s.totalTransactionFees),
          ),
          row(l10n.settlementFee, formatMoney(s.settlementFee)),
          row(l10n.settlementNet, formatMoney(s.netAmount)),
          const Divider(),
          row(l10n.settlementBank, s.bankName),
          row(l10n.settlementAccountName, s.accountName),
          row(l10n.settlementAccountNumber, s.accountNumber, mono: true),
        ],
      ),
    );
  }
}
