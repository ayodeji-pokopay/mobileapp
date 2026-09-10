import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/charts.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../../shared/widgets/pills.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../insights_stats.dart';

class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen> {
  static const _windows = [7, 30, 90];
  int _w = 1;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final days = _windows[_w];
    final txns = ref.watch(insightsProvider(days));
    final locale = Localizations.localeOf(context).toString();

    return BackScaffold(
      title: l10n.insightsTitle,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(insightsProvider(days));
          ref.invalidate(allTransactionsProvider(days));
          await ref.read(insightsProvider(days).future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            const OfflineBanner(),
            PillTabs(
              scrollable: true,
              inactiveColor: AppColors.surface,
              inactiveTextColor: AppColors.textBody,
              items: [
                l10n.salesWindow7,
                l10n.salesWindow30,
                l10n.salesWindow90,
              ],
              selected: _w,
              onChanged: (i) => setState(() => _w = i),
            ),
            const SizedBox(height: 16),
            AsyncSlot<InsightsStats>(
              value: txns,
              loadingHeight: 320,
              onRetry: () => ref.invalidate(insightsProvider(days)),
              data: (s) {
                if (s.isEmpty) {
                  return EmptyState(
                    icon: LucideIcons.chartNoAxesColumn,
                    title: l10n.insightsNoData,
                    subtitle: l10n.insightsNoDataHint,
                  );
                }
                final hourFmt = DateFormat('ha', locale);
                final dayFmt = DateFormat('EEEE', locale);
                final shortDay = DateFormat('E', locale);
                final peak = DateTime(2026, 1, 5, s.peakHour);
                final peakDay = DateTime(
                  2026,
                  1,
                  4 + s.peakWeekday,
                ); // 5 Jan 2026 is a Monday
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _Kpi(
                            label: l10n.salesGross,
                            value: formatMoney(s.totalSales),
                            delta: s.fromServer ? s.periodDelta : s.weekOnWeek,
                            isNew: s.periodIsNew,
                            newLabel: l10n.insightsNew,
                            deltaLabel: (v) => s.fromServer
                                ? l10n.salesVsPrevious(v)
                                : l10n.insightsWeekOnWeek(v),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _Kpi(
                            label: l10n.insightsAvgTicket,
                            value: formatMoney(s.averageTicket),
                            sub: l10n.salesTransactionsCount(s.approvedCount),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _Kpi(
                            label: l10n.insightsApprovalRate,
                            value:
                                '${(s.approvalRate * 100).toStringAsFixed(0)}%',
                            sub: l10n.salesCountItems(s.count),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _Kpi(
                            label: l10n.insightsBestDay,
                            value: s.bestDay == null
                                ? l10n.commonDash
                                : '${shortDay.format(s.bestDay!)} ${formatDateShort(s.bestDay!.toIso8601String())}',
                            sub: formatMoney(s.bestDayAmount),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _ChartCard(
                      title: l10n.insightsBestHours,
                      highlight: l10n.insightsPeak(hourFmt.format(peak)),
                      child: BarChart(
                        values: s.byHour,
                        xLabels: const ['12am', '6am', '12pm', '6pm', '11pm'],
                        yFormat: s.byHourIsCount
                            ? (v) => formatNumber(v.round())
                            : formatMoneyCompact,
                        height: 110,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _ChartCard(
                      title: l10n.insightsBestDays,
                      highlight: dayFmt.format(peakDay),
                      child: BarChart(
                        values: s.byWeekday,
                        xLabels: [
                          for (var i = 0; i < 7; i++)
                            shortDay.format(DateTime(2026, 1, 5 + i)),
                        ],
                        yFormat: formatMoneyCompact,
                        height: 110,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _ChartCard(
                      title: l10n.salesDailySales,
                      child: BarChart(
                        values: s.byDay,
                        xLabels: [
                          formatDayMonth(
                            DateTime.now()
                                .subtract(Duration(days: days - 1))
                                .toIso8601String(),
                          ).split(', ').last,
                          formatDayMonth(
                            DateTime.now().toIso8601String(),
                          ).split(', ').last,
                        ],
                        yFormat: formatMoneyCompact,
                        height: 110,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _MonthCard(s: s, l10n: l10n),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Kpi extends StatelessWidget {
  const _Kpi({
    required this.label,
    required this.value,
    this.sub,
    this.delta,
    this.deltaLabel,
    this.isNew = false,
    this.newLabel,
  });
  final String label;
  final String value;
  final String? sub;
  final double? delta;
  final String Function(String)? deltaLabel;
  final bool isNew;
  final String? newLabel;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      radius: 16,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppText.body(size: 12, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value, style: AppText.money(size: 20)),
          ),
          const SizedBox(height: 4),
          if (isNew && newLabel != null)
            StatusPill(label: newLabel!, tone: PillTone.success)
          else if (deltaLabel != null)
            DeltaPill(delta: delta, label: deltaLabel!)
          else if (sub != null)
            Text(
              sub!,
              style: AppText.body(size: 12, color: AppColors.textSecondary),
            ),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.title, required this.child, this.highlight});
  final String title;
  final Widget child;
  final String? highlight;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      radius: 18,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title.toUpperCase(), style: AppText.label()),
              ),
              if (highlight != null)
                StatusPill(label: highlight!, tone: PillTone.success),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _MonthCard extends StatelessWidget {
  const _MonthCard({required this.s, required this.l10n});
  final InsightsStats s;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final month = DateFormat(
      'MMMM yyyy',
      Localizations.localeOf(context).toString(),
    ).format(DateTime.now());
    Widget row(String k, String v) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              k,
              style: AppText.body(size: 14, color: AppColors.textSecondary),
            ),
          ),
          Text(v, style: AppText.body(size: 14, weight: FontWeight.w600)),
        ],
      ),
    );
    return SurfaceCard(
      radius: 18,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.insightsMonthToDate.toUpperCase(), style: AppText.label()),
          const SizedBox(height: 4),
          Text(
            month,
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 8),
          Text(
            formatMoney(s.monthToDate),
            style: AppText.display(size: 26, height: 1),
          ),
          const SizedBox(height: 10),
          const Divider(),
          row(l10n.settlementTransactions, formatNumber(s.monthCount)),
          row(
            l10n.insightsAvgTicket,
            formatMoney(s.monthCount == 0 ? 0 : s.monthToDate / s.monthCount),
          ),
          if (s.topTerminal != null)
            row(
              l10n.insightsTopTerminal,
              '${s.topTerminal} · ${formatMoney(s.topTerminalAmount)}',
            ),
        ],
      ),
    );
  }
}
