import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/merchant_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../../shared/widgets/section_label.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../../../l10n/generated/app_localizations.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  static const _periods = ['DAILY', 'WEEKLY', 'MONTHLY', 'YEARLY'];

  int _tab = 0;
  String _search = '';

  void _notYet(String what) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context).commonFeatureComingSoon(what),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final period = ref.watch(salesPeriodProvider);
    final sales = ref.watch(salesReportProvider);
    final periodIndex = _periods.indexOf(period);
    final periodLabels = [
      l10n.periodToday,
      l10n.periodLastWeek,
      l10n.periodLastMonth,
      l10n.periodLastYear,
    ];

    return Scaffold(
      backgroundColor: AppColors.canvas,
      bottomNavigationBar: const PokoBottomNav(active: NavTab.sales),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.salesTitle, style: AppText.display(size: 32)),
                      _PlusMenu(
                        tooltip: l10n.salesAdd,
                        newSale: l10n.salesNewSale,
                        newLink: l10n.salesNewPaymentLink,
                        onNewSale: () => _notYet(l10n.salesNewSale),
                        onNewLink: () => _notYet(l10n.salesPaymentLinks),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  UnderlineTabs(
                    items: [
                      l10n.salesTabOverview,
                      l10n.salesTabTransactions,
                      l10n.salesTabPaymentLinks,
                    ],
                    selected: _tab,
                    onChanged: (i) => setState(() => _tab = i),
                  ),
                ],
              ),
            ),
            Expanded(
              child: switch (_tab) {
                0 => _Overview(
                  sales: sales,
                  periodIndex: periodIndex < 0 ? 1 : periodIndex,
                  periodLabels: periodLabels,
                  onPeriod: (i) =>
                      ref.read(salesPeriodProvider.notifier).set(_periods[i]),
                  onRefresh: () async {
                    ref.invalidate(salesReportProvider);
                    await ref.read(salesReportProvider.future);
                  },
                  onRetry: () => ref.invalidate(salesReportProvider),
                  onGoTransactions: () => setState(() => _tab = 1),
                  onExport: () => _notYet(l10n.salesExportFeature),
                ),
                1 => _Transactions(
                  sales: sales,
                  search: _search,
                  onSearch: (v) => setState(() => _search = v.trim()),
                  onRetry: () => ref.invalidate(salesReportProvider),
                ),
                _ => const _PaymentLinks(),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PlusMenu extends StatelessWidget {
  const _PlusMenu({
    required this.tooltip,
    required this.newSale,
    required this.newLink,
    required this.onNewSale,
    required this.onNewLink,
  });
  final String tooltip;
  final String newSale;
  final String newLink;
  final VoidCallback onNewSale;
  final VoidCallback onNewLink;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: tooltip,
      offset: const Offset(0, 56),
      color: AppColors.surface,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (v) => v == 0 ? onNewSale() : onNewLink(),
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 0,
          child: _MenuRow(icon: LucideIcons.printer, label: newSale),
        ),
        PopupMenuItem(
          value: 1,
          child: _MenuRow(icon: LucideIcons.link, label: newLink),
        ),
      ],
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(LucideIcons.plus, size: 24, color: Colors.white),
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textBody),
        const SizedBox(width: 12),
        Text(label, style: AppText.body(size: 16, weight: FontWeight.w500)),
      ],
    );
  }
}

// ── Overview ────────────────────────────────────────────────────────────

class _Overview extends StatelessWidget {
  const _Overview({
    required this.sales,
    required this.periodIndex,
    required this.periodLabels,
    required this.onPeriod,
    required this.onRefresh,
    required this.onRetry,
    required this.onGoTransactions,
    required this.onExport,
  });

  final AsyncValue<MerchantSalesReportResponse> sales;
  final int periodIndex;
  final List<String> periodLabels;
  final ValueChanged<int> onPeriod;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;
  final VoidCallback onGoTransactions;
  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
        children: [
          const OfflineBanner(),
          PillTabs(
            scrollable: true,
            dropdown: true,
            inactiveColor: AppColors.surface,
            inactiveTextColor: AppColors.textBody,
            items: periodLabels,
            selected: periodIndex,
            onChanged: onPeriod,
          ),
          const SizedBox(height: 16),
          AsyncSlot<MerchantSalesReportResponse>(
            value: sales,
            loadingHeight: 300,
            onRetry: onRetry,
            data: (r) => _GrossSalesCard(r: r),
          ),
          const SizedBox(height: 16),
          SurfaceCard(
            radius: 16,
            padding: const EdgeInsets.symmetric(vertical: 16),
            onTap: onGoTransactions,
            child: Center(
              child: Text(
                l10n.salesGoToTransactions,
                style: AppText.body(size: 15, weight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AsyncSlot<MerchantSalesReportResponse>(
            value: sales,
            loadingHeight: 120,
            data: (r) => _FeesNetCard(r: r),
          ),
          const SizedBox(height: 16),
          AsyncSlot<MerchantSalesReportResponse>(
            value: sales,
            loadingHeight: 160,
            data: (r) => _BreakdownCard(r: r),
          ),
          const SizedBox(height: 16),
          AsyncSlot<MerchantSalesReportResponse>(
            value: sales,
            loadingHeight: 120,
            data: (r) => _ExportCard(r: r, onExport: onExport),
          ),
        ],
      ),
    );
  }
}

class _GrossSalesCard extends StatelessWidget {
  const _GrossSalesCard({required this.r});
  final MerchantSalesReportResponse r;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final count = r.totalTransactionCount ?? 0;
    final hasRange =
        (r.startDate ?? '').isNotEmpty && (r.endDate ?? '').isNotEmpty;
    final range = hasRange
        ? l10n.salesRange(
            formatDateShort(r.startDate),
            formatDateShort(r.endDate),
          )
        : '';
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.salesGross.toUpperCase(), style: AppText.label()),
              Text(
                l10n.salesTransactionsCount(count),
                style: AppText.body(size: 13, color: AppColors.textTertiary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              formatMoney(r.totalSales),
              style: AppText.display(size: 36, height: 1),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            range.isEmpty ? (r.reportPeriod ?? '') : range,
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _MiniStat(label: l10n.salesNet, value: formatMoney(r.netAmount)),
              const SizedBox(width: 24),
              _MiniStat(
                label: l10n.salesFeesShort,
                value: formatMoney(r.totalFees),
              ),
            ],
          ),
          if (r.dailyBreakdown.isNotEmpty) ...[
            const SizedBox(height: 20),
            _BarChart(rows: r.dailyBreakdown),
          ],
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppText.body(
            size: 13,
            weight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(value, style: AppText.money(size: 16)),
      ],
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart({required this.rows});
  final List<DailyBreakdown> rows;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final values = rows.map((d) => (d.totalAmount ?? 0).toDouble()).toList();
    final max = values.fold<double>(0, (a, b) => a > b ? a : b);
    final maxIndex = values.indexOf(max);
    final mid = rows.length ~/ 2;
    String xLabel(int i) => formatDayMonth(rows[i].date).split(', ').last;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 110,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final v in [max, max / 2, 0.0])
                      Text(
                        formatMoneyCompact(v),
                        style: AppText.body(
                          size: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 96,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (var i = 0; i < values.length; i++)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: values.length > 20 ? 0.5 : 1.5,
                              ),
                              child: FractionallySizedBox(
                                heightFactor: max == 0
                                    ? 0.03
                                    : (values[i] / max).clamp(0.03, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: i == maxIndex && max > 0
                                        ? AppColors.primary
                                        : AppColors.navy,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Divider(color: AppColors.surfaceAlt, height: 1),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final i in {0, mid, rows.length - 1})
                        Text(
                          xLabel(i),
                          style: AppText.body(
                            size: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _Legend(color: AppColors.navy, label: l10n.salesDailySales),
            const SizedBox(width: 16),
            _Legend(color: AppColors.primary, label: l10n.salesBestDay),
          ],
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppText.body(size: 12, color: AppColors.textTertiary),
        ),
      ],
    );
  }
}

class _FeesNetCard extends StatelessWidget {
  const _FeesNetCard({required this.r});
  final MerchantSalesReportResponse r;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final count = r.totalTransactionCount ?? 0;
    return SurfaceCard(
      child: Row(
        children: [
          Expanded(
            child: _BigStat(
              label: l10n.salesFees.toUpperCase(),
              value: (r.totalFees ?? 0) > 0
                  ? '-${formatMoney(r.totalFees)}'
                  : formatMoney(0),
              color: (r.totalFees ?? 0) > 0 ? AppColors.danger : AppColors.navy,
              sub: l10n.salesTransactionsCount(count),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _BigStat(
              label: l10n.salesNetAmount.toUpperCase(),
              value: formatMoney(r.netAmount),
              color: AppColors.navy,
              sub: l10n.salesAfterFees,
            ),
          ),
        ],
      ),
    );
  }
}

class _BigStat extends StatelessWidget {
  const _BigStat({
    required this.label,
    required this.value,
    required this.color,
    required this.sub,
  });
  final String label;
  final String value;
  final Color color;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.label()),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: AppText.display(size: 24, color: color, height: 1),
          ),
        ),
        const SizedBox(height: 8),
        Text(sub, style: AppText.body(size: 13, color: AppColors.textTertiary)),
      ],
    );
  }
}

class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard({required this.r});
  final MerchantSalesReportResponse r;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final total = (r.totalSales ?? 0).toDouble();
    final ranked = [...r.cardSchemeBreakdown]
      ..sort((a, b) => (b.totalAmount ?? 0).compareTo(a.totalAmount ?? 0));
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.salesBreakdown.toUpperCase(), style: AppText.label()),
          const SizedBox(height: 14),
          PillChip(
            label: l10n.salesCardBrands,
            selected: true,
            onTap: () {},
            activeColor: AppColors.primary,
          ),
          const SizedBox(height: 8),
          if (ranked.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                l10n.salesNoCardTransactions,
                style: AppText.body(size: 14, color: AppColors.textTertiary),
              ),
            )
          else
            for (var i = 0; i < ranked.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: i == ranked.length - 1
                      ? null
                      : const Border(
                          bottom: BorderSide(color: AppColors.divider),
                        ),
                ),
                child: Row(
                  children: [
                    InitialsTile(
                      text: _abbr(ranked[i].cardScheme),
                      foreground: _brandColor(ranked[i].cardScheme),
                      fontSize: 11,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _titleCase(ranked[i].cardScheme ?? l10n.salesOther),
                        style: AppText.body(size: 15, weight: FontWeight.w500),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatMoney(ranked[i].totalAmount),
                          style: AppText.money(size: 15),
                        ),
                        Text(
                          total == 0
                              ? l10n.settlementTxns(
                                  ranked[i].transactionCount ?? 0,
                                )
                              : '${((ranked[i].totalAmount ?? 0) / total * 100).toStringAsFixed(1)}%',
                          style: AppText.body(
                            size: 13,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  String _abbr(String? scheme) {
    final s = (scheme ?? '').toUpperCase();
    if (s.startsWith('MASTER')) return 'MC';
    if (s.startsWith('VISA')) return 'VS';
    if (s.startsWith('VERVE')) return 'VE';
    if (s.isEmpty) return '··';
    return s.length >= 2 ? s.substring(0, 2) : s;
  }

  Color _brandColor(String? scheme) {
    final s = (scheme ?? '').toUpperCase();
    if (s.startsWith('MASTER')) return AppColors.mastercard;
    if (s.startsWith('VISA')) return AppColors.visa;
    return AppColors.textBody;
  }

  String _titleCase(String s) {
    final lower = s.toLowerCase();
    return lower.isEmpty ? s : lower[0].toUpperCase() + lower.substring(1);
  }
}

class _ExportCard extends StatelessWidget {
  const _ExportCard({required this.r, required this.onExport});
  final MerchantSalesReportResponse r;
  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.salesReportSummary,
            style: AppText.body(size: 15, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 6),
          Text(
            formatMoney(r.netAmount),
            style: AppText.display(size: 28, height: 1),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.salesNetSettled(r.businessName ?? r.merchantName ?? ''),
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 20),
          Material(
            color: AppColors.canvas,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: onExport,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      LucideIcons.download,
                      size: 16,
                      color: AppColors.textBody,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.salesExport,
                      style: AppText.body(size: 15, weight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Transactions ────────────────────────────────────────────────────────

class _Transactions extends StatelessWidget {
  const _Transactions({
    required this.sales,
    required this.search,
    required this.onSearch,
    required this.onRetry,
  });

  final AsyncValue<MerchantSalesReportResponse> sales;
  final String search;
  final ValueChanged<String> onSearch;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      children: [
        TextField(
          onChanged: onSearch,
          style: AppText.body(size: 15),
          decoration: InputDecoration(
            hintText: l10n.salesSearchByDate,
            hintStyle: AppText.body(size: 15, color: AppColors.textTertiary),
            prefixIcon: const Icon(
              LucideIcons.search,
              size: 16,
              color: AppColors.textTertiary,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AsyncSlot<MerchantSalesReportResponse>(
          value: sales,
          loadingHeight: 200,
          onRetry: onRetry,
          data: (r) {
            final days = r.dailyBreakdown.where((d) {
              if (search.isEmpty) return true;
              final q = search.toLowerCase();
              return formatDayLabel(d.date).toLowerCase().contains(q) ||
                  (d.date ?? '').contains(q);
            }).toList()..sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));
            if (days.isEmpty) {
              return EmptyState(
                icon: LucideIcons.receipt,
                title: l10n.salesNoTransactions,
                subtitle: l10n.salesNoTransactionsHint,
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final d in days) ...[
                  SectionLabel(formatDayLabel(d.date)),
                  ListCard(children: [_DayRow(d)]),
                  const SizedBox(height: 20),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow(this.d);
  final DailyBreakdown d;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final count = d.transactionCount ?? 0;
    return ListRow(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surfacePressed,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEBEBEA)),
            ),
            child: const Icon(
              LucideIcons.creditCard,
              size: 18,
              color: AppColors.textBody,
            ),
          ),
          Positioned(
            right: -4,
            bottom: -4,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.check,
                size: 9,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      title: l10n.salesCardSales(count),
      subtitle: l10n.salesFeesNet(
        formatMoney(d.totalFees),
        formatMoney(d.netAmount),
      ),
      trailing: Text(
        formatMoney(d.totalAmount),
        style: AppText.money(size: 15),
      ),
    );
  }
}

// ── Payment links ───────────────────────────────────────────────────────

class _PaymentLinks extends StatelessWidget {
  const _PaymentLinks();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      children: [
        EmptyState(
          icon: LucideIcons.link,
          title: l10n.salesNoPaymentLinks,
          subtitle: l10n.salesNoPaymentLinksHint,
        ),
      ],
    );
  }
}
