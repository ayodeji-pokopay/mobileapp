import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/merchant_models.dart';
import '../../../core/api/models/transaction_models.dart';
import '../../../core/config/app_config_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/error_text.dart';
import '../../../shared/format.dart';
import '../../../shared/pdf/pokopay_pdf.dart';
import '../../../shared/pdf_share.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../../shared/widgets/card_brand_logo.dart';
import '../../../shared/widgets/charts.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../../shared/widgets/pills.dart';
import '../../merchant/presentation/merchant_providers.dart';
import 'receipt_sheet.dart';
import 'transaction_style.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  static const _periods = ['DAILY', 'WEEKLY', 'MONTHLY', 'YEARLY'];

  int _tab = 0;
  bool _exporting = false;

  void _notYet(String what) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context).commonFeatureComingSoon(what),
        ),
      ),
    );
  }

  Future<void> _export() async {
    final l10n = AppLocalizations.of(context);
    final report = ref.read(salesReportProvider).asData?.value;
    if (report == null || _exporting) return;
    setState(() => _exporting = true);
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(SnackBar(content: Text(l10n.salesDownloading)));
    try {
      final period = ref.read(salesPeriodProvider);
      final labels = {
        'DAILY': l10n.periodToday,
        'WEEKLY': l10n.periodLastWeek,
        'MONTHLY': l10n.periodLastMonth,
        'YEARLY': l10n.periodLastYear,
      };
      final bytes = await buildSalesReportPdf(
        r: report,
        business: ref.read(businessNameProvider),
        l10n: l10n,
        periodLabel: labels[period] ?? period,
      );
      await sharePdf(
        bytes,
        fileName: 'pokopay-sales-${period.toLowerCase()}.pdf',
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            '${l10n.salesDownloadFailed} ${describeError(e, l10n)}',
          ),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final period = ref.watch(salesPeriodProvider);
    final sales = ref.watch(salesReportProvider);
    final paymentLinks =
        ref.watch(appConfigProvider).asData?.value.features.paymentLinks ??
        false;
    final periodIndex = _periods.indexOf(period);
    final periodLabels = [
      l10n.periodToday,
      l10n.periodLastWeek,
      l10n.periodLastMonth,
      l10n.periodLastYear,
    ];
    final tabs = [
      l10n.salesTabOverview,
      l10n.salesTabTransactions,
      if (paymentLinks) l10n.salesTabPaymentLinks,
    ];
    final tab = _tab.clamp(0, tabs.length - 1);

    return Scaffold(
      backgroundColor: AppColors.canvas,
      bottomNavigationBar: const PokoBottomNav(active: NavTab.sales),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.salesTitle, style: AppText.display(size: 28)),
                      _PlusMenu(
                        tooltip: l10n.salesAdd,
                        newSale: l10n.salesNewSale,
                        newLink: paymentLinks ? l10n.salesNewPaymentLink : null,
                        onNewSale: () => _notYet(l10n.salesNewSale),
                        onNewLink: () => _notYet(l10n.salesPaymentLinks),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  UnderlineTabs(
                    items: tabs,
                    selected: tab,
                    onChanged: (i) => setState(() => _tab = i),
                  ),
                ],
              ),
            ),
            Expanded(
              child: switch (tab) {
                0 => _Overview(
                  sales: sales,
                  period: period,
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
                  onExport: _exporting ? null : _export,
                ),
                1 => const _Transactions(),
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
  final String? newLink;
  final VoidCallback onNewSale;
  final VoidCallback onNewLink;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: tooltip,
      offset: const Offset(0, 52),
      color: AppColors.surface,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (v) => v == 0 ? onNewSale() : onNewLink(),
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 0,
          child: _MenuRow(icon: LucideIcons.printer, label: newSale),
        ),
        if (newLink != null)
          PopupMenuItem(
            value: 1,
            child: _MenuRow(icon: LucideIcons.link, label: newLink!),
          ),
      ],
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(LucideIcons.plus, size: 22, color: Colors.white),
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

class _Overview extends ConsumerWidget {
  const _Overview({
    required this.sales,
    required this.period,
    required this.periodIndex,
    required this.periodLabels,
    required this.onPeriod,
    required this.onRefresh,
    required this.onRetry,
    required this.onGoTransactions,
    required this.onExport,
  });

  final AsyncValue<MerchantSalesReportResponse> sales;
  final String period;
  final int periodIndex;
  final List<String> periodLabels;
  final ValueChanged<int> onPeriod;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;
  final VoidCallback onGoTransactions;
  final VoidCallback? onExport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final txns = ref.watch(periodTransactionsProvider(period));
    final days = periodDays(period);
    final series = txns.asData == null
        ? const <double>[]
        : dailyTotals(txns.asData!.value.content, days);
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
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
          const SizedBox(height: 14),
          AsyncSlot<MerchantSalesReportResponse>(
            value: sales,
            loadingHeight: 300,
            onRetry: onRetry,
            data: (r) => _GrossSalesCard(r: r, series: series, days: days),
          ),
          const SizedBox(height: 12),
          SurfaceCard(
            radius: 14,
            padding: const EdgeInsets.symmetric(vertical: 13),
            onTap: onGoTransactions,
            child: Center(
              child: Text(
                l10n.salesGoToTransactions,
                style: AppText.body(size: 15, weight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 12),
          AsyncSlot<MerchantSalesReportResponse>(
            value: sales,
            loadingHeight: 120,
            data: (r) => _FeesNetCard(r: r),
          ),
          const SizedBox(height: 12),
          AsyncSlot<MerchantSalesReportResponse>(
            value: sales,
            loadingHeight: 160,
            data: (r) => _BreakdownCard(r: r),
          ),
          AsyncSlot<MerchantSalesReportResponse>(
            value: sales,
            loadingHeight: 0,
            skeleton: const SizedBox.shrink(),
            data: (r) {
              final refunds = r.refunds?.count ?? 0;
              final chargebacks = r.chargebacks?.count ?? 0;
              if (refunds == 0 && chargebacks == 0) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: _RefundsCard(r: r),
              );
            },
          ),
          const SizedBox(height: 12),
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
  const _GrossSalesCard({
    required this.r,
    required this.series,
    required this.days,
  });
  final MerchantSalesReportResponse r;
  final List<double> series;
  final int days;

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
    final delta = percentDelta(r.totalSales, r.previousPeriod?.totalSales);
    final values = series;
    final today = DateTime.now();
    String xLabel(int i) {
      final d = today.subtract(Duration(days: days - 1 - i));
      return formatDayMonth(d.toIso8601String()).split(', ').last;
    }

    return SurfaceCard(
      radius: 18,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.salesGross.toUpperCase(), style: AppText.label()),
              if (r.previousPeriod != null)
                DeltaPill(delta: delta, label: (v) => l10n.salesVsPrevious(v))
              else
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
              style: AppText.display(size: 28, height: 1),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            [
              l10n.salesTransactionsCount(count),
              if (range.isNotEmpty) range,
            ].join(' · '),
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
          if (values.length > 1) ...[
            const SizedBox(height: 20),
            BarChart(
              values: values,
              xLabels: [
                xLabel(0),
                if (values.length > 2) xLabel(values.length ~/ 2),
                xLabel(values.length - 1),
              ],
              yFormat: formatMoneyCompact,
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
    final fees = r.totalFees ?? 0;
    return SurfaceCard(
      radius: 18,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _BigStat(
              label: l10n.salesFees.toUpperCase(),
              value: fees > 0 ? '-${formatMoney(fees)}' : formatMoney(0),
              color: fees > 0 ? AppColors.danger : AppColors.navy,
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

class _RefundsCard extends StatelessWidget {
  const _RefundsCard({required this.r});
  final MerchantSalesReportResponse r;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SurfaceCard(
      radius: 18,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _BigStat(
              label: l10n.salesRefunds.toUpperCase(),
              value: '-${formatMoney(r.refunds?.amount)}',
              color: AppColors.danger,
              sub: l10n.salesCountItems(r.refunds?.count ?? 0),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _BigStat(
              label: l10n.salesChargebacks.toUpperCase(),
              value: formatMoney(r.chargebacks?.amount),
              color: AppColors.navy,
              sub: l10n.salesCountItems(r.chargebacks?.count ?? 0),
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
            style: AppText.display(size: 20, color: color, height: 1),
          ),
        ),
        const SizedBox(height: 8),
        Text(sub, style: AppText.body(size: 13, color: AppColors.textTertiary)),
      ],
    );
  }
}

class _BreakdownCard extends StatefulWidget {
  const _BreakdownCard({required this.r});
  final MerchantSalesReportResponse r;

  @override
  State<_BreakdownCard> createState() => _BreakdownCardState();
}

class _BreakdownCardState extends State<_BreakdownCard> {
  int _mode = 0; // 0 card brands, 1 channels

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final r = widget.r;
    final total = (r.totalSales ?? 0).toDouble();
    final channels = r.channelBreakdown;
    final terminals = r.terminalBreakdown;
    final modes = <String>[
      l10n.salesCardBrands,
      if (terminals.isNotEmpty) l10n.salesByTerminal,
      if (channels.length > 1) l10n.salesChannels,
    ];
    final mode = _mode.clamp(0, modes.length - 1);
    final modeLabel = modes[mode];

    final List<
      ({
        String? scheme,
        String abbr,
        String name,
        num? amount,
        int? count,
        Color color,
      })
    >
    rows;
    if (modeLabel == l10n.salesByTerminal) {
      rows =
          ([...terminals]..sort(
                (a, b) => (b.totalSales ?? 0).compareTo(a.totalSales ?? 0),
              ))
              .map(
                (t) => (
                  scheme: null,
                  abbr: 'POS',
                  name: (t.terminalLocation ?? '').isNotEmpty
                      ? '${t.terminalLocation} · ${t.tid}'
                      : l10n.terminalLabel(t.tid ?? ''),
                  amount: t.totalSales,
                  count: t.transactionCount,
                  color: AppColors.navy,
                ),
              )
              .toList();
    } else if (modeLabel == l10n.salesChannels) {
      rows =
          ([...channels]..sort(
                (a, b) => (b.totalAmount ?? 0).compareTo(a.totalAmount ?? 0),
              ))
              .map(
                (c) => (
                  scheme: null,
                  abbr: _channelAbbr(c.channel),
                  name: _channelName(c.channel, l10n),
                  amount: c.totalAmount,
                  count: c.transactionCount,
                  color: AppColors.textBody,
                ),
              )
              .toList();
    } else {
      rows =
          ([...r.cardSchemeBreakdown]
                ..sort((a, b) => (b.amount ?? 0).compareTo(a.amount ?? 0)))
              .map(
                (c) => (
                  scheme: c.cardScheme,
                  abbr: schemeAbbr(c.cardScheme),
                  name: schemeName(c.cardScheme, l10n),
                  amount: c.amount,
                  count: c.transactionCount,
                  color: _brandColor(c.cardScheme),
                ),
              )
              .toList();
    }

    return SurfaceCard(
      radius: 18,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.salesBreakdown.toUpperCase(), style: AppText.label()),
          const SizedBox(height: 12),
          PillTabs(
            scrollable: true,
            items: modes,
            selected: mode,
            onChanged: (i) => setState(() => _mode = i),
            activeColor: AppColors.primary,
            inactiveColor: AppColors.canvas,
            inactiveTextColor: AppColors.textBody,
          ),
          const SizedBox(height: 6),
          if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                l10n.salesNoCardTransactions,
                style: AppText.body(size: 14, color: AppColors.textTertiary),
              ),
            )
          else
            for (var i = 0; i < rows.length; i++) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    if (rows[i].scheme != null)
                      CardBrandLogo(scheme: rows[i].scheme, size: 40)
                    else
                      InitialsTile(
                        text: rows[i].abbr,
                        foreground: rows[i].color,
                        fontSize: 11,
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rows[i].name,
                            style: AppText.body(
                              size: 15,
                              weight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: total == 0
                                  ? 0
                                  : ((rows[i].amount ?? 0) / total)
                                        .clamp(0, 1)
                                        .toDouble(),
                              minHeight: 4,
                              backgroundColor: AppColors.canvas,
                              valueColor: AlwaysStoppedAnimation(rows[i].color),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatMoney(rows[i].amount),
                          style: AppText.money(size: 15),
                        ),
                        Text(
                          total == 0
                              ? l10n.settlementTxns(rows[i].count ?? 0)
                              : '${((rows[i].amount ?? 0) / total * 100).toStringAsFixed(1)}%',
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
              if (i != rows.length - 1) const Divider(color: AppColors.divider),
            ],
        ],
      ),
    );
  }

  Color _brandColor(String? scheme) {
    final s = (scheme ?? '').toUpperCase();
    if (s.startsWith('MASTER')) return AppColors.mastercard;
    if (s.startsWith('VISA')) return AppColors.visa;
    if (s.startsWith('VERVE')) return AppColors.primary;
    return AppColors.textBody;
  }

  String _channelAbbr(String? c) => switch ((c ?? '').toUpperCase()) {
    'POS' => 'POS',
    'LINK' => 'LNK',
    'TAP' => 'TAP',
    _ => '··',
  };

  String _channelName(String? c, AppLocalizations l10n) =>
      switch ((c ?? '').toUpperCase()) {
        'POS' => l10n.channelPos,
        'LINK' => l10n.channelLink,
        'TAP' => l10n.channelTap,
        _ => c ?? l10n.salesOther,
      };
}

class _ExportCard extends StatelessWidget {
  const _ExportCard({required this.r, required this.onExport});
  final MerchantSalesReportResponse r;
  final VoidCallback? onExport;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SurfaceCard(
      radius: 18,
      padding: const EdgeInsets.all(16),
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
            style: AppText.display(size: 22, height: 1),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.salesNetSettled(r.businessName ?? r.merchantName ?? ''),
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),
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
                    Icon(
                      LucideIcons.fileDown,
                      size: 16,
                      color: onExport == null
                          ? AppColors.textTertiary
                          : AppColors.textBody,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.salesExport,
                      style: AppText.body(
                        size: 15,
                        weight: FontWeight.w600,
                        color: onExport == null
                            ? AppColors.textTertiary
                            : AppColors.navy,
                      ),
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

class _Transactions extends ConsumerStatefulWidget {
  const _Transactions();

  @override
  ConsumerState<_Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends ConsumerState<_Transactions> {
  static const _statuses = [null, 'APPROVED', 'FAILED', 'REVERSED', 'REFUNDED'];
  static const _windows = [7, 30, 90];
  int _status = 0;
  int _window = 0;
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final digits = RegExp(r'^\d{4}$').hasMatch(_search);
    final query = (
      status: _statuses[_status],
      last4: digits ? _search : null,
      days: _windows[_window],
    );
    final txns = ref.watch(transactionsProvider(query));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(transactionsProvider(query));
        await ref.read(transactionsProvider(query).future);
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          TextField(
            onChanged: (v) => setState(() => _search = v.trim()),
            keyboardType: TextInputType.text,
            style: AppText.body(size: 15),
            decoration: InputDecoration(
              hintText: l10n.salesSearchLast4,
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
          const SizedBox(height: 10),
          PillTabs(
            scrollable: true,
            dropdown: true,
            inactiveColor: AppColors.surface,
            inactiveTextColor: AppColors.textBody,
            items: [l10n.salesWindow7, l10n.salesWindow30, l10n.salesWindow90],
            selected: _window,
            onChanged: (i) => setState(() => _window = i),
          ),
          const SizedBox(height: 8),
          PillTabs(
            scrollable: true,
            inactiveColor: AppColors.surface,
            inactiveTextColor: AppColors.textBody,
            items: [
              l10n.filterAll,
              l10n.filterApproved,
              l10n.filterDeclined,
              l10n.filterReversed,
              l10n.filterRefunded,
            ],
            selected: _status,
            onChanged: (i) => setState(() => _status = i),
          ),
          const SizedBox(height: 16),
          AsyncSlot<PageTransactionResponse>(
            value: txns,
            loadingHeight: 220,
            onRetry: () => ref.invalidate(transactionsProvider(query)),
            data: (page) {
              var items = page.content;
              if (_search.isNotEmpty && !digits) {
                final q = _search.toLowerCase();
                items = items
                    .where(
                      (t) =>
                          (t.reference ?? '').toLowerCase().contains(q) ||
                          (t.storeName ?? '').toLowerCase().contains(q),
                    )
                    .toList();
              }
              if (items.isEmpty) {
                return EmptyState(
                  icon: LucideIcons.receipt,
                  title: l10n.salesNoTransactions,
                  subtitle: l10n.salesNoTransactionsHint,
                );
              }
              final groups = <String, List<TransactionResponse>>{};
              for (final t in items) {
                final local = DateTime.tryParse(
                  t.transactionDate ?? '',
                )?.toLocal();
                final day = local == null
                    ? ''
                    : local.toIso8601String().split('T').first;
                groups.putIfAbsent(day, () => []).add(t);
              }
              final days = groups.keys.toList()..sort((a, b) => b.compareTo(a));
              num approvedTotal(List<TransactionResponse> list) => list
                  .where((t) => (t.status ?? '').toUpperCase() == 'APPROVED')
                  .fold<num>(0, (a, t) => a + (t.amount ?? 0));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 14),
                    child: Text(
                      l10n.salesTransactionsSummary(
                        items.length,
                        formatMoney(approvedTotal(items)),
                      ),
                      style: AppText.body(
                        size: 13,
                        weight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  for (final d in days) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDayLabel(d),
                            style: AppText.body(
                              size: 13,
                              weight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            l10n.dayTotal(
                              groups[d]!.length,
                              formatMoney(approvedTotal(groups[d]!)),
                            ),
                            style: AppText.body(
                              size: 12,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListCard(
                      children: [
                        for (final t in groups[d]!)
                          _TxnRow(
                            t: t,
                            onTap: () => showReceiptSheet(context, t),
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
      ),
    );
  }
}

class _TxnRow extends StatelessWidget {
  const _TxnRow({required this.t, required this.onTap});
  final TransactionResponse t;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = transactionStyle(t, l10n);
    final d = DateTime.tryParse(t.transactionDate ?? '');
    final title = (t.maskedPan ?? '').isNotEmpty
        ? l10n.cardLabel(cardDescription(t, l10n), last4(t.maskedPan))
        : style.title;
    final subtitle = [
      if (d != null) formatTime(d),
      if ((t.tid ?? '').isNotEmpty) l10n.tidLabel(t.tid!),
      if ((t.cardBank ?? '').isNotEmpty) t.cardBank!,
    ].join(' · ');
    return ListRow(
      onTap: onTap,
      chevron: false,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          CardBrandLogo(scheme: t.scheme, size: 44),
          Positioned(
            right: -4,
            bottom: -4,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: switch (style.tone) {
                  PillTone.success => AppColors.primary,
                  PillTone.reversed => const Color(0xFF6B4FD0),
                  _ => AppColors.danger,
                },
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 1.5),
              ),
              child: Icon(
                style.tone == PillTone.success ? LucideIcons.check : style.icon,
                size: 9,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      title: title,
      subtitle: subtitle,
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatMoney(t.amount),
            style: AppText.money(
              size: 15,
              color: style.muted ? AppColors.textTertiary : AppColors.navy,
              decoration: style.muted ? TextDecoration.lineThrough : null,
            ),
          ),
          if (style.tone != PillTone.success) ...[
            const SizedBox(height: 4),
            StatusPill(label: style.statusLabel, tone: style.tone),
          ],
        ],
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
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
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
