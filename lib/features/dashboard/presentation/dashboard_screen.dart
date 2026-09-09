import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/merchant_models.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/section_label.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../../../l10n/generated/app_localizations.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _balanceHidden = false;
  bool _showFeedback = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(summaryProvider);
    final settlements = ref.watch(settlementsProvider);
    final weekly = ref.watch(weeklySalesProvider);
    final businessName = ref.watch(businessNameProvider);

    return Scaffold(
      backgroundColor: AppColors.canvas,
      drawer: const AppDrawer(),
      bottomNavigationBar: const PokoBottomNav(active: NavTab.home),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(summaryProvider);
            ref.invalidate(settlementsProvider);
            ref.invalidate(weeklySalesProvider);
            await Future.wait([
              ref.read(summaryProvider.future),
              ref.read(settlementsProvider.future),
            ]);
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              const OfflineBanner(),
              _HeroCard(
                businessName: businessName,
                balance: summary.asData?.value.totalSettledAmount,
                loading: summary.isLoading,
                unavailable: summary.hasError,
                hidden: _balanceHidden,
                onToggleHidden: () =>
                    setState(() => _balanceHidden = !_balanceHidden),
                onOpenAccount: () => Scaffold.of(context).openDrawer(),
                onPay: () => context.go(AppRoutes.wallet),
                onAdd: () => context.push(AppRoutes.settlements),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _GrossSalesCard(
                      summary: summary,
                      weekly: weekly,
                      onTap: () => context.go(AppRoutes.reports),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SettlementsCard(
                      summary: summary,
                      onTap: () => context.push(AppRoutes.settlements),
                    ),
                  ),
                ],
              ),
              if (_showFeedback) ...[
                const SizedBox(height: 16),
                _FeedbackBanner(
                  onDismiss: () => setState(() => _showFeedback = false),
                ),
              ],
              const SizedBox(height: 24),
              SectionLabel(l10n.dashboardActivity, uppercase: true),
              AsyncSlot<PageSettlementResponse>(
                value: settlements,
                loadingHeight: 200,
                onRetry: () => ref.invalidate(settlementsProvider),
                data: (page) {
                  final items = page.content.take(8).toList();
                  if (items.isEmpty) {
                    return EmptyState(
                      icon: LucideIcons.receipt,
                      title: l10n.dashboardNoActivity,
                      subtitle: l10n.dashboardNoActivityHint,
                    );
                  }
                  return ListCard(
                    children: [
                      for (final s in items)
                        _ActivityRow(
                          s: s,
                          onTap: () => context.push(AppRoutes.settlements),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.businessName,
    required this.balance,
    required this.loading,
    required this.unavailable,
    required this.hidden,
    required this.onToggleHidden,
    required this.onOpenAccount,
    required this.onPay,
    required this.onAdd,
  });

  final String businessName;
  final num? balance;
  final bool loading;
  final bool unavailable;
  final bool hidden;
  final VoidCallback onToggleHidden;
  final VoidCallback onOpenAccount;
  final VoidCallback onPay;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final amount = hidden
        ? '₦ ••••••'
        : loading || unavailable
        ? '₦ —'
        : formatMoney(balance, compact: true).replaceFirst('₦', '₦ ');

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryBright,
            AppColors.primaryDark,
          ],
          stops: [0, 0.5, 1],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -48,
            right: -48,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryGlow.withValues(alpha: 0.25),
                    AppColors.primaryGlow.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Builder(
                        builder: (context) => _AccountPill(
                          name: businessName,
                          onTap: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        _GlassButton(
                          icon: hidden ? LucideIcons.eyeOff : LucideIcons.eye,
                          label: hidden
                              ? l10n.dashboardShowBalance
                              : l10n.dashboardHideBalance,
                          onTap: onToggleHidden,
                        ),
                        const SizedBox(width: 8),
                        _GlassButton(
                          icon: LucideIcons.bell,
                          label: l10n.commonNotifications,
                          badge: true,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.commonNoNewNotifications),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.dashboardAvailableBalance,
                  style: AppText.body(
                    size: 14,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  amount,
                  style: AppText.display(
                    size: 42,
                    color: Colors.white,
                    letterSpacing: -1.3,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      child: InkWell(
                        onTap: onPay,
                        borderRadius: BorderRadius.circular(999),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                LucideIcons.arrowUpRight,
                                size: 16,
                                color: AppColors.navy,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l10n.dashboardPay,
                                style: AppText.body(
                                  size: 15,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: onAdd,
                        customBorder: const CircleBorder(),
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            LucideIcons.plus,
                            size: 20,
                            color: AppColors.navy,
                          ),
                        ),
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
}

class _AccountPill extends StatelessWidget {
  const _AccountPill({required this.name, required this.onTap});
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: l10n.dashboardOpenAccount,
      child: Material(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    initialsOf(name),
                    style: AppText.money(size: 12, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 140),
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.body(
                        size: 14,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  LucideIcons.chevronRight,
                  size: 16,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  const _GlassButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: Colors.white.withValues(alpha: 0.18),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 36,
            height: 36,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon, size: 18, color: Colors.white),
                if (badge)
                  Positioned(
                    top: 7,
                    right: 7,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GrossSalesCard extends StatelessWidget {
  const _GrossSalesCard({
    required this.summary,
    required this.weekly,
    required this.onTap,
  });

  final AsyncValue<MerchantSettlementSummary> summary;
  final AsyncValue<MerchantSalesReportResponse> weekly;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = summary.asData?.value;
    final bars =
        weekly.asData?.value.dailyBreakdown
            .map((d) => (d.totalAmount ?? 0).toDouble())
            .toList() ??
        const <double>[];
    final txns = s?.todayTransactions ?? 0;

    return SurfaceCard(
      radius: 16,
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dashboardGrossSalesToday,
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 6),
          Text(
            summary.hasValue ? formatMoney(s?.todaySales) : '—',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.money(size: 22),
          ),
          const SizedBox(height: 4),
          Text(
            txns == 0
                ? l10n.dashboardFirstSale
                : l10n.dashboardTransactionsToday(txns),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.body(size: 12, color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          _Sparkline(values: bars),
        ],
      ),
    );
  }
}

class _Sparkline extends StatelessWidget {
  const _Sparkline({required this.values});
  final List<double> values;

  @override
  Widget build(BuildContext context) {
    final data = values.length > 10
        ? values.sublist(values.length - 10)
        : values.isEmpty
        ? List<double>.filled(10, 0)
        : values;
    final max = data.fold<double>(0, (a, b) => a > b ? a : b);
    return SizedBox(
      height: 28,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < data.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: FractionallySizedBox(
                  heightFactor: max == 0
                      ? 0.08
                      : (data[i] / max).clamp(0.08, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: i == data.length - 1
                          ? AppColors.primary
                          : AppColors.surfaceAlt,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SettlementsCard extends StatelessWidget {
  const _SettlementsCard({required this.summary, required this.onTap});

  final AsyncValue<MerchantSettlementSummary> summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = summary.asData?.value;
    final pending = (s?.pendingAmount ?? 0) > 0;
    return SurfaceCard(
      radius: 16,
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dashboardTodaysSettlements,
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 6),
          Text(
            summary.hasValue ? formatMoney(s?.pendingAmount) : '—',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.money(size: 22),
          ),
          const SizedBox(height: 4),
          Text(
            pending ? l10n.dashboardPending : l10n.dashboardSettled,
            style: AppText.body(
              size: 12,
              color: pending ? AppColors.warning : AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(LucideIcons.zap, size: 12, color: AppColors.primary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  l10n.dashboardSettlementsCount(s?.totalSettlements ?? 0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.body(size: 12, color: AppColors.textBody),
                ),
              ),
            ],
          ),
          Text(
            l10n.dashboardTotalToDate,
            style: AppText.body(size: 12, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.dashboardMoreDetails,
                style: AppText.body(size: 12, weight: FontWeight.w600),
              ),
              const Icon(
                LucideIcons.chevronRight,
                size: 14,
                color: AppColors.textDisabled,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  const _FeedbackBanner({required this.onDismiss});
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SurfaceCard(
      radius: 16,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.canvas,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              LucideIcons.star,
              size: 24,
              color: AppColors.warning,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.feedbackTitle,
                  style: AppText.body(size: 15, weight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.feedbackBody,
                  style: AppText.body(
                    size: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.feedbackThanks)),
                    );
                  },
                  child: Text(
                    l10n.feedbackAction,
                    style: AppText.body(
                      size: 13,
                      weight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Semantics(
            button: true,
            label: l10n.feedbackDismiss,
            child: GestureDetector(
              onTap: onDismiss,
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  LucideIcons.x,
                  size: 16,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.s, required this.onTap});
  final SettlementResponse s;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = (s.status ?? 'PENDING').toUpperCase();
    final (title, bg, fg) = switch (status) {
      'COMPLETED' => (
        l10n.activitySettlementReceived,
        AppColors.primaryTint,
        AppColors.primary,
      ),
      'FAILED' => (
        l10n.activitySettlementFailed,
        AppColors.dangerBg,
        AppColors.danger,
      ),
      _ => (
        l10n.activitySettlementPending,
        AppColors.warningBg,
        AppColors.warningText,
      ),
    };
    final ref = s.settlementReference ?? '';
    return ListRow(
      onTap: onTap,
      chevron: false,
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          InitialsTile(text: 'ST', background: bg, foreground: fg),
          const Positioned(
            right: -2,
            bottom: -2,
            child: DirectionBadge(inbound: true),
          ),
        ],
      ),
      title: title,
      subtitle: [
        formatDayLabel(s.settlementDate),
        if (ref.isNotEmpty) ref,
      ].join(' · '),
      trailing: Text(
        '+${formatMoney(s.netAmount)}',
        style: AppText.money(
          size: 15,
          color: status == 'FAILED' ? AppColors.danger : AppColors.navy,
        ),
      ),
    );
  }
}
