import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/merchant_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../../shared/widgets/section_label.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../../../l10n/generated/app_localizations.dart';

class SettlementsScreen extends ConsumerStatefulWidget {
  const SettlementsScreen({super.key});

  @override
  ConsumerState<SettlementsScreen> createState() => _SettlementsScreenState();
}

class _SettlementsScreenState extends ConsumerState<SettlementsScreen> {
  int _segment = 0;
  int _status = 0;
  static const _statuses = ['ALL', 'COMPLETED', 'PENDING', 'FAILED'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final data = ref.watch(settlementsProvider);

    return BackScaffold(
      title: l10n.settlementsTitle,
      titleSize: 30,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(settlementsProvider);
          ref.invalidate(summaryProvider);
          await ref.read(settlementsProvider.future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            const OfflineBanner(),
            SegmentedControl(
              items: [l10n.settlementsTab, l10n.invoicesTab],
              selected: _segment,
              onChanged: (i) => setState(() => _segment = i),
            ),
            const SizedBox(height: 20),
            if (_segment == 1)
              EmptyState(
                icon: LucideIcons.receipt,
                title: l10n.invoicesEmpty,
                subtitle: l10n.invoicesEmptyHint,
              )
            else ...[
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
                selected: _status,
                onChanged: (i) => setState(() => _status = i),
              ),
              const SizedBox(height: 20),
              AsyncSlot<PageSettlementResponse>(
                value: data,
                loadingHeight: 240,
                onRetry: () => ref.invalidate(settlementsProvider),
                data: (page) {
                  final filter = _statuses[_status];
                  final items = page.content
                      .where(
                        (s) =>
                            filter == 'ALL' ||
                            (s.status ?? 'PENDING').toUpperCase() == filter,
                      )
                      .toList();
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
                  final years = groups.keys.toList()
                    ..sort((a, b) => b.compareTo(a));
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
                                onTap: () => _showDetail(context, s),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showDetail(BuildContext context, SettlementResponse s) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _SettlementSheet(s: s),
    );
  }
}

(IconData, Color, Color, String) _statusStyle(
  String? status,
  AppLocalizations l10n,
) {
  final st = (status ?? 'PENDING').toUpperCase();
  return switch (st) {
    'COMPLETED' => (
      LucideIcons.circleCheck,
      AppColors.primary,
      AppColors.primaryLight,
      l10n.statusCompleted,
    ),
    'FAILED' => (
      LucideIcons.circleX,
      AppColors.danger,
      AppColors.dangerBg,
      l10n.statusFailed,
    ),
    _ => (
      LucideIcons.clock,
      AppColors.warning,
      AppColors.warningBg,
      l10n.statusPending,
    ),
  };
}

class _SettlementRow extends StatelessWidget {
  const _SettlementRow({required this.s, required this.onTap});
  final SettlementResponse s;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (icon, fg, bg, _) = _statusStyle(s.status, l10n);
    final count = s.transactionCount ?? 0;
    return ListRow(
      onTap: onTap,
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: fg),
      ),
      title: formatDateShort(s.settlementDate),
      subtitle: [
        if ((s.settlementReference ?? '').isNotEmpty) s.settlementReference!,
        l10n.settlementTxns(count),
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
    final (icon, fg, bg, label) = _statusStyle(s.status, l10n);
    final bottom = MediaQuery.paddingOf(context).bottom;
    Widget row(String k, String? v, {bool mono = false}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
              (v ?? '').isEmpty ? '—' : v!,
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: fg),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settlementDetailTitle,
                      style: AppText.money(size: 17),
                    ),
                    Text(
                      '$label · ${formatDateShort(s.settlementDate)}',
                      style: AppText.body(size: 13, color: fg),
                    ),
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
