import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/merchant_models.dart';
import '../../../core/api/models/wallet_models.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../../shared/widgets/pills.dart';
import '../../merchant/presentation/merchant_providers.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  int _tab = 0; // 0 all, 1 payouts, 2 fees

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final wallet = ref.watch(walletProvider);
    final summary = ref.watch(summaryProvider);
    final settlements = ref.watch(settlementsProvider);

    return BackScaffold(
      title: l10n.walletTitle,
      bottomNav: const PokoBottomNav(active: NavTab.money),
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(walletProvider);
          ref.invalidate(summaryProvider);
          ref.invalidate(settlementsProvider);
          await Future.wait([
            ref.read(walletProvider.future),
            ref.read(settlementsProvider.future),
          ]);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            const OfflineBanner(),
            AsyncSlot<WalletResponse>(
              value: wallet,
              loadingHeight: 230,
              onRetry: () => ref.invalidate(walletProvider),
              data: (w) => _BalanceCard(
                wallet: w,
                monthToDate: summary.asData?.value.monthToDateSales,
                onWithdraw: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.walletWithdrawHint)),
                  );
                },
                onStatements: () =>
                    context.push('${AppRoutes.settlements}?tab=statements'),
              ),
            ),
            if (wallet.asData?.value.isFrozen == true) ...[
              const SizedBox(height: 12),
              _FrozenBanner(text: l10n.walletFrozen),
            ],
            const SizedBox(height: 12),
            AsyncSlot<WalletResponse>(
              value: wallet,
              loadingHeight: 76,
              data: (w) => _NextPayoutCard(
                wallet: w,
                onTap: () => context.push(AppRoutes.settlements),
              ),
            ),
            const SizedBox(height: 12),
            AsyncSlot<WalletResponse>(
              value: wallet,
              loadingHeight: 76,
              data: (w) =>
                  (w.bankName ?? '').isEmpty && (w.accountNumber ?? '').isEmpty
                  ? const SizedBox.shrink()
                  : _AccountCard(wallet: w),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 12),
              child: Text(l10n.walletHistory, style: AppText.money(size: 16)),
            ),
            PillTabs(
              items: [
                l10n.walletTabAll,
                l10n.walletTabPayouts,
                l10n.walletTabFees,
              ],
              selected: _tab,
              onChanged: (i) => setState(() => _tab = i),
            ),
            const SizedBox(height: 14),
            AsyncSlot<PageSettlementResponse>(
              value: settlements,
              loadingHeight: 200,
              onRetry: () => ref.invalidate(settlementsProvider),
              data: (page) {
                final entries = _entriesFor(page.content, _tab, l10n);
                if (entries.isEmpty) {
                  return EmptyState(
                    icon: LucideIcons.wallet,
                    title: l10n.walletEmpty,
                    subtitle: l10n.walletEmptyHint,
                  );
                }
                return ListCard(
                  children: [for (final e in entries) _TxnRow(e)],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<_Entry> _entriesFor(
    List<SettlementResponse> list,
    int tab,
    AppLocalizations l10n,
  ) {
    final out = <_Entry>[];
    for (final s in list) {
      final failed = (s.status ?? '').toUpperCase() == 'FAILED';
      if (tab != 2) {
        out.add(
          _Entry(
            inbound: true,
            title: failed
                ? l10n.activitySettlementFailed
                : l10n.walletDailySettlement,
            date: formatDayLabel(s.settlementDate),
            amount: s.netAmount,
            failed: failed,
          ),
        );
      }
      if (tab != 1 && (s.settlementFee ?? 0) > 0) {
        out.add(
          _Entry(
            inbound: false,
            title: l10n.walletProcessingFee,
            date: formatDayLabel(s.settlementDate),
            amount: s.settlementFee,
          ),
        );
      }
    }
    return out;
  }
}

class _Entry {
  const _Entry({
    required this.inbound,
    required this.title,
    required this.date,
    required this.amount,
    this.failed = false,
  });
  final bool inbound;
  final String title;
  final String date;
  final num? amount;
  final bool failed;
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({
    required this.wallet,
    required this.monthToDate,
    required this.onWithdraw,
    required this.onStatements,
  });

  final WalletResponse wallet;
  final num? monthToDate;
  final VoidCallback onWithdraw;
  final VoidCallback onStatements;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navyMuted, AppColors.navy, AppColors.navyDark],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.3),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.dashboardAvailableBalance,
                  style: AppText.body(
                    size: 13,
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),
              ),
              if ((wallet.currency ?? '').isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    wallet.currency!,
                    style: AppText.body(
                      size: 11,
                      weight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              formatMoney(wallet.availableNaira),
              style: AppText.display(size: 30, color: Colors.white, height: 1),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: LucideIcons.clock,
                  iconColor: const Color(0xFFFFD166),
                  label: l10n.walletPending,
                  value: formatMoneyCompact(wallet.pendingNaira),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatTile(
                  icon: LucideIcons.trendingUp,
                  iconColor: AppColors.primaryBright,
                  label: l10n.walletThisMonth,
                  value: monthToDate == null
                      ? l10n.commonDash
                      : formatMoneyCompact(monthToDate),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _DarkButton(
                  icon: LucideIcons.send,
                  label: l10n.walletWithdraw,
                  color: AppColors.primary,
                  onTap: onWithdraw,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _DarkButton(
                  icon: LucideIcons.fileDown,
                  label: l10n.walletStatement,
                  color: Colors.white.withValues(alpha: 0.12),
                  onTap: onStatements,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FrozenBanner extends StatelessWidget {
  const _FrozenBanner({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.dangerBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            LucideIcons.circleAlert,
            size: 18,
            color: AppColors.danger,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppText.body(size: 13, color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppText.body(
                  size: 12,
                  color: Colors.white.withValues(alpha: 0.65),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(value, style: AppText.money(size: 16, color: Colors.white)),
        ],
      ),
    );
  }
}

class _DarkButton extends StatelessWidget {
  const _DarkButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppText.body(
                  size: 14,
                  weight: FontWeight.w600,
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

String cycleLabel(String? cycle, AppLocalizations l10n) {
  return switch ((cycle ?? '').toUpperCase()) {
    'T0' => l10n.cycleT0,
    'T1' => l10n.cycleT1,
    'T2' => l10n.cycleT2,
    'WEEKLY' => l10n.cycleWeekly,
    'INSTANT' => l10n.cycleInstant,
    'MANUAL' => l10n.cycleManual,
    'T_PLUS_0' => l10n.cycleT0,
    'T_PLUS_1' => l10n.cycleT1,
    'T_PLUS_2' => l10n.cycleT2,
    _ => cycle ?? '',
  };
}

class _NextPayoutCard extends StatelessWidget {
  const _NextPayoutCard({required this.wallet, required this.onTap});
  final WalletResponse wallet;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pending = wallet.pendingNaira ?? 0;
    final parts = <String>[
      if ((wallet.cycle ?? '').isNotEmpty) cycleLabel(wallet.cycle, l10n),
      if (wallet.autoSettlement == true) l10n.cycleInstant,
    ];
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onTap: onTap,
      child: Row(
        children: [
          const IconBubble(icon: LucideIcons.clock, tone: PillTone.success),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.walletNextPayout,
                  style: AppText.body(size: 13, color: AppColors.textTertiary),
                ),
                const SizedBox(height: 2),
                Text(
                  pending > 0 ? formatMoney(pending) : l10n.commonDash,
                  style: AppText.money(size: 18),
                ),
                const SizedBox(height: 2),
                Text(
                  parts.isEmpty ? l10n.walletSchedule : parts.join(' · '),
                  style: AppText.body(size: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(
            LucideIcons.chevronRight,
            size: 20,
            color: AppColors.textDisabled,
          ),
        ],
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({required this.wallet});
  final WalletResponse wallet;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const IconBubble(icon: LucideIcons.landmark, tone: PillTone.info),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.walletSettlementAccount,
                  style: AppText.body(size: 13, color: AppColors.textTertiary),
                ),
                const SizedBox(height: 2),
                Text(
                  [
                    wallet.bankName,
                    wallet.accountNumber,
                  ].where((e) => (e ?? '').isNotEmpty).join(' · '),
                  style: AppText.body(size: 15, weight: FontWeight.w600),
                ),
                if ((wallet.accountName ?? '').isNotEmpty)
                  Text(
                    wallet.accountName!,
                    style: AppText.body(
                      size: 12,
                      color: AppColors.textSecondary,
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

class _TxnRow extends StatelessWidget {
  const _TxnRow(this.e);
  final _Entry e;

  @override
  Widget build(BuildContext context) {
    final inbound = e.inbound && !e.failed;
    return ListRow(
      leading: IconBubble(
        icon: inbound ? LucideIcons.arrowDownLeft : LucideIcons.arrowUpRight,
        tone: inbound ? PillTone.success : PillTone.danger,
      ),
      title: e.title,
      subtitle: e.date,
      trailing: Text(
        '${e.inbound ? '+' : '-'}${formatMoney(e.amount)}',
        style: AppText.money(
          size: 15,
          color: inbound ? AppColors.navy : AppColors.danger,
        ),
      ),
    );
  }
}
