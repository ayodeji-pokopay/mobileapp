import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/api/models/merchant_models.dart';
import '../../../core/api/models/transaction_models.dart';
import '../../../core/config/app_config.dart';
import '../../../core/config/app_config_provider.dart';
import '../../../core/lock/app_lock.dart';
import '../../../core/security/device_integrity.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../../shared/widgets/charts.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pills.dart';
import '../../../shared/widgets/section_label.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../../reports/presentation/receipt_sheet.dart';
import '../../reports/presentation/transaction_style.dart';
import 'dashboard_widgets.dart';
import 'dashboard_providers.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _balanceHidden = false;
  bool _showFeedback = true;
  bool _pinPromptDismissed = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(summaryProvider);
    final wallet = ref.watch(walletProvider);
    final weekly = ref.watch(periodTransactionsProvider('WEEKLY'));
    final recent = ref.watch(recentTransactionsProvider);
    final unread =
        ref.watch(notificationsProvider).asData?.value.unreadCount ?? 0;
    final alerts =
        ref
            .watch(notificationsProvider)
            .asData
            ?.value
            .content
            .where((n) => n.needsReview)
            .length ??
        0;
    final businessName = ref.watch(businessNameProvider);
    final auth = ref.watch(authControllerProvider);
    final staffView = auth.isStaffView;
    final lock = ref.watch(appLockProvider);
    final integrity = ref.watch(deviceIntegrityProvider).asData?.value;
    final goal = ref.watch(salesGoalProvider);
    final lastWeek = ref.watch(sameWeekdayLastWeekProvider).asData?.value;
    final filter = ref.watch(activityFilterProvider);
    final todaySales = (summary.asData?.value.todaySales ?? 0).toDouble();

    final balance =
        wallet.asData?.value.availableNaira ??
        summary.asData?.value.totalSettledAmount;
    final balanceLoading = wallet.isLoading && summary.isLoading;
    final balanceUnavailable = wallet.hasError && summary.hasError;

    return Scaffold(
      backgroundColor: AppColors.canvas,
      drawer: const AppDrawer(),
      bottomNavigationBar: const PokoBottomNav(active: NavTab.home),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(summaryProvider);
            ref.invalidate(walletProvider);
            ref.invalidate(periodTransactionsProvider('WEEKLY'));
            ref.invalidate(recentTransactionsProvider);
            ref.invalidate(notificationsProvider);
            ref.invalidate(terminalsProvider);
            ref.invalidate(sameWeekdayLastWeekProvider);
            ref.invalidate(approvalHealthProvider);
            ref.invalidate(allTransactionsProvider(1));
            await Future.wait([
              ref.read(summaryProvider.future),
              ref.read(recentTransactionsProvider.future),
            ]);
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              const OfflineBanner(),
              _HeroCard(
                businessName: businessName,
                balance: staffView ? todaySales : balance,
                staffView: staffView,
                loading: staffView ? summary.isLoading : balanceLoading,
                unavailable: staffView ? summary.hasError : balanceUnavailable,
                hidden: _balanceHidden,
                unread: unread,
                goalDone: todaySales,
                goalTarget: goal.daily,
                onGoal: () => showGoalSheet(context),
                onToggleHidden: () =>
                    setState(() => _balanceHidden = !_balanceHidden),
                onWallet: () => context.go(AppRoutes.wallet),
                onSettlements: () => context.push(AppRoutes.settlements),
                onNotifications: () => context.push(AppRoutes.notifications),
              ),
              const SizedBox(height: 12),
              const QuickActionsRow(),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _SalesTodayCard(
                      summary: summary,
                      weekly: weekly,
                      lastWeekSameDay: lastWeek,
                      onTap: () => context.go(AppRoutes.reports),
                    ),
                  ),
                  if (!staffView) ...[
                    const SizedBox(width: 10),
                    Expanded(
                      child: SettlementTracker(
                        summary: summary,
                        onTap: () => context.push(AppRoutes.settlements),
                      ),
                    ),
                  ],
                ],
              ),
              const ApprovalWarningCard(),
              const SizedBox(height: 12),
              const TerminalStrip(),
              if (integrity?.compromised == true) ...[
                const SizedBox(height: 12),
                const DeviceWarningBanner(),
              ],
              if (lock.loaded &&
                  lock.settings.enabled &&
                  !lock.hasPin &&
                  !_pinPromptDismissed) ...[
                const SizedBox(height: 12),
                SetPinCard(
                  onDismiss: () => setState(() => _pinPromptDismissed = true),
                ),
              ],
              if (alerts > 0) ...[
                const SizedBox(height: 12),
                _AlertBanner(
                  count: alerts,
                  onTap: () => context.push(AppRoutes.notifications),
                ),
              ],
              if (_showFeedback) ...[
                const SizedBox(height: 12),
                _FeedbackBanner(
                  onDismiss: () => setState(() => _showFeedback = false),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionLabel(l10n.dashboardRecentActivity, uppercase: true),
                  GestureDetector(
                    onTap: () => context.go(AppRoutes.reports),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12, right: 4),
                      child: Text(
                        l10n.commonSeeAll,
                        style: AppText.body(
                          size: 13,
                          weight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const ActivityFilterChips(),
              const SizedBox(height: 10),
              AsyncSlot<PageTransactionResponse>(
                value: recent,
                loadingHeight: 220,
                onRetry: () => ref.invalidate(recentTransactionsProvider),
                data: (page) {
                  final items = page.content
                      .where((t) => matchesActivityFilter(t, filter))
                      .take(8)
                      .toList();
                  if (items.isEmpty) {
                    return EmptyState(
                      icon: LucideIcons.receipt,
                      title: l10n.dashboardNoRecentActivity,
                      subtitle: l10n.dashboardNoRecentActivityHint,
                    );
                  }
                  return ListCard(
                    children: [
                      for (final t in items)
                        _ActivityRow(
                          t: t,
                          onTap: () => showReceiptSheet(context, t),
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
    required this.unread,
    required this.onToggleHidden,
    required this.onWallet,
    required this.onSettlements,
    required this.onNotifications,
    required this.goalDone,
    required this.goalTarget,
    required this.onGoal,
    this.staffView = false,
  });

  final String businessName;
  final num? balance;
  final bool staffView;
  final double goalDone;
  final double? goalTarget;
  final VoidCallback onGoal;
  final bool loading;
  final bool unavailable;
  final bool hidden;
  final int unread;
  final VoidCallback onToggleHidden;
  final VoidCallback onWallet;
  final VoidCallback onSettlements;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final amount = hidden
        ? '₦ ••••••'
        : loading || unavailable
        ? '₦ —'
        : formatMoney(balance).replaceFirst('₦', '₦ ');

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandNavyMuted,
            AppColors.brandNavy,
            AppColors.brandNavyDark,
          ],
          stops: [0, 0.55, 1],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandNavy.withValues(alpha: 0.32),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(top: -70, right: -50, child: _Orb(size: 220, alpha: 0.22)),
          Positioned(
            bottom: -90,
            left: -40,
            child: _Orb(size: 200, alpha: 0.12),
          ),
          Positioned(
            top: 24,
            right: 40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryBright.withValues(alpha: 0.22),
                  width: 1.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
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
                          badge: unread > 0,
                          onTap: onNotifications,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffView
                                ? l10n.dashboardTakingsToday
                                : l10n.dashboardAvailableBalance,
                            style: AppText.body(
                              size: 13,
                              color: Colors.white.withValues(alpha: 0.78),
                            ),
                          ),
                          const SizedBox(height: 4),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              amount,
                              key: ValueKey(amount),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.display(
                                size: 34,
                                color: Colors.white,
                                letterSpacing: -1,
                                height: 1,
                              ),
                            ),
                          ),
                          if (goalTarget != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              l10n.dashboardGoalProgress(
                                formatMoneyCompact(goalDone),
                                formatMoneyCompact(goalTarget),
                              ),
                              style: AppText.body(
                                size: 12,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    GoalRing(done: goalDone, target: goalTarget, onTap: onGoal),
                  ],
                ),
                const SizedBox(height: 18),
                if (!staffView)
                  Row(
                    children: [
                      _GreenPill(
                        icon: LucideIcons.wallet,
                        label: l10n.dashboardPay,
                        onTap: onWallet,
                      ),
                      const SizedBox(width: 10),
                      Semantics(
                        button: true,
                        label: l10n.dashboardAdd,
                        child: Material(
                          color: Colors.white,
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: onSettlements,
                            customBorder: const CircleBorder(),
                            child: SizedBox(
                              width: 36,
                              height: 36,
                              child: Icon(
                                LucideIcons.arrowLeftRight,
                                size: 18,
                                color: AppColors.navy,
                              ),
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

class _Orb extends StatelessWidget {
  const _Orb({required this.size, required this.alpha});
  final double size;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.primaryGlow.withValues(alpha: alpha),
            AppColors.primaryGlow.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}

class _GreenPill extends StatelessWidget {
  const _GreenPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppText.body(
                  size: 14,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
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
            padding: const EdgeInsets.fromLTRB(5, 5, 12, 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    initialsOf(name),
                    style: AppText.money(size: 11, color: Colors.white),
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
                        size: 13,
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
            width: 34,
            height: 34,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon, size: 16, color: Colors.white),
                if (badge)
                  Positioned(
                    top: 7,
                    right: 7,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBright,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.navy, width: 1),
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

class _SalesTodayCard extends StatelessWidget {
  const _SalesTodayCard({
    required this.summary,
    required this.weekly,
    required this.onTap,
    this.lastWeekSameDay,
  });

  final AsyncValue<MerchantSettlementSummary> summary;
  final AsyncValue<PageTransactionResponse> weekly;
  final VoidCallback onTap;

  /// Approved sales on this weekday last week, when the backend has it.
  final double? lastWeekSameDay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = summary.asData?.value;
    final points = weekly.asData == null
        ? const <double>[]
        : dailyTotals(weekly.asData!.value.content, 7);
    final today = (s?.todaySales ?? 0).toDouble();
    // Prefer the same weekday last week (steadier for shops with weekly
    // rhythms); fall back to yesterday when the backend can't provide it.
    final baseline = lastWeekSameDay ?? s?.yesterdaySales?.toDouble();
    final vsLastWeek = lastWeekSameDay != null;
    final double? delta = baseline == null
        ? null
        : baseline == 0
        ? (today == 0 ? 0 : null)
        : (today - baseline) / baseline * 100;
    final txns = s?.todayTransactions ?? 0;
    final weekday = DateFormat(
      'EEEE',
      Localizations.localeOf(context).toString(),
    ).format(DateTime.now());

    return SurfaceCard(
      radius: 16,
      padding: const EdgeInsets.all(14),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dashboardGrossSalesToday,
            style: AppText.body(size: 12, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 4),
          if (summary.isLoading)
            const Skeleton(height: 20, width: 90)
          else
            Text(
              summary.hasValue ? formatMoney(s?.todaySales) : '—',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.money(size: 18),
            ),
          const SizedBox(height: 4),
          if (s != null && (baseline != null || txns > 0))
            DeltaPill(
              delta: delta,
              label: (v) => delta == null
                  ? l10n.dashboardTransactionsToday(txns)
                  : vsLastWeek
                  ? l10n.dashboardVsLastWeekday(v, weekday)
                  : l10n.dashboardVsYesterday(v),
            )
          else
            Text(
              l10n.dashboardFirstSale,
              maxLines: 2,
              style: AppText.body(
                size: 12,
                color: AppColors.primary,
                height: 1.25,
              ),
            ),
          const SizedBox(height: 10),
          Sparkline(values: points, height: 30),
        ],
      ),
    );
  }
}

/// Unreviewed suspicious-activity alerts. Tapping opens the feed.
class _AlertBanner extends StatelessWidget {
  const _AlertBanner({required this.count, required this.onTap});
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.all(12),
      color: AppColors.dangerBg,
      onTap: onTap,
      child: Row(
        children: [
          const IconBubble(
            icon: LucideIcons.shieldAlert,
            tone: PillTone.danger,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.alertsBannerTitle(count),
                  style: AppText.body(
                    size: 14,
                    weight: FontWeight.w600,
                    color: AppColors.danger,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.alertsBannerBody,
                  style: AppText.body(
                    size: 12.5,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Icon(LucideIcons.chevronRight, size: 18, color: AppColors.danger),
        ],
      ),
    );
  }
}

class _FeedbackBanner extends ConsumerWidget {
  const _FeedbackBanner({required this.onDismiss});
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final support = ref.watch(appConfigProvider).asData?.value.support;
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IconBubble(icon: LucideIcons.star, tone: PillTone.warning),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.feedbackTitle,
                  style: AppText.body(size: 14, weight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.feedbackBody,
                  style: AppText.body(
                    size: 12.5,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () async {
                    final email = support?.email ?? const SupportInfo().email;
                    final version =
                        ref.read(packageInfoProvider).asData?.value.version ??
                        '';
                    final uri = Uri(
                      scheme: 'mailto',
                      path: email,
                      query:
                          'subject=${Uri.encodeComponent('Pokopay app feedback ($version)')}',
                    );
                    final ok = await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    );
                    if (!ok && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.feedbackEmailFailed(email)),
                        ),
                      );
                    }
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
              child: Padding(
                padding: EdgeInsets.all(6),
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
  const _ActivityRow({required this.t, required this.onTap});
  final TransactionResponse t;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = transactionStyle(t, l10n);
    final local = DateTime.tryParse(t.transactionDate ?? '')?.toLocal();
    final subtitle = [
      if (local != null)
        '${formatDayLabel(local.toIso8601String()).split(' · ').first} ${formatTime(local)}',
      if ((t.tid ?? '').isNotEmpty) t.tid!,
      if ((t.maskedPan ?? '').length >= 4)
        '${schemeName(t.scheme, l10n)} ···· ${t.last4}',
    ].join(' · ');
    return ListRow(
      onTap: onTap,
      chevron: false,
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          IconBubble(icon: style.icon, tone: style.tone),
          Positioned(
            right: -2,
            bottom: -2,
            child: DirectionBadge(inbound: style.inbound),
          ),
        ],
      ),
      title: style.title,
      subtitle: subtitle,
      trailing: Text(
        '${style.inbound ? '+' : '-'}${formatMoney(t.amount)}',
        style: AppText.money(
          size: 15,
          color: style.muted ? AppColors.textTertiary : AppColors.navy,
          decoration: style.muted ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
