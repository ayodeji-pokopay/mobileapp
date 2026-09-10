import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/merchant_models.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../../../l10n/generated/app_localizations.dart';

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
    final summary = ref.watch(summaryProvider);
    final settlements = ref.watch(settlementsProvider);

    return BackScaffold(
      title: l10n.walletTitle,
      bottomNav: const PokoBottomNav(active: NavTab.money),
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(summaryProvider);
          ref.invalidate(settlementsProvider);
          await Future.wait([
            ref.read(summaryProvider.future),
            ref.read(settlementsProvider.future),
          ]);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
          children: [
            const OfflineBanner(),
            AsyncSlot<MerchantSettlementSummary>(
              value: summary,
              loadingHeight: 240,
              onRetry: () => ref.invalidate(summaryProvider),
              data: (s) => _BalanceCard(
                summary: s,
                onWithdraw: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.walletWithdrawHint)),
                  );
                },
                onStatement: () => context.push(AppRoutes.settlements),
              ),
            ),
            const SizedBox(height: 16),
            AsyncSlot<PageSettlementResponse>(
              value: settlements,
              loadingHeight: 76,
              data: (page) {
                final next =
                    page.content
                        .where(
                          (s) => (s.status ?? '').toUpperCase() != 'COMPLETED',
                        )
                        .firstOrNull ??
                    page.content.firstOrNull;
                if (next == null) return const SizedBox.shrink();
                return _NextPayoutCard(
                  s: next,
                  onTap: () => context.push(AppRoutes.settlements),
                );
              },
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
            const SizedBox(height: 16),
            AsyncSlot<PageSettlementResponse>(
              value: settlements,
              loadingHeight: 200,
              onRetry: () => ref.invalidate(settlementsProvider),
              data: (page) {
                final entries = _entriesFor(page.content, _tab);
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

  List<_Entry> _entriesFor(List<SettlementResponse> list, int tab) {
    final l10n = AppLocalizations.of(context);
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
    required this.summary,
    required this.onWithdraw,
    required this.onStatement,
  });

  final MerchantSettlementSummary summary;
  final VoidCallback onWithdraw;
  final VoidCallback onStatement;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dashboardAvailableBalance,
            style: AppText.body(
              size: 13,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 5),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              formatMoney(summary.totalSettledAmount),
              style: AppText.display(size: 30, color: Colors.white, height: 1),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: LucideIcons.trendingUp,
                  iconColor: AppColors.primaryBright,
                  label: l10n.walletSettlements,
                  value: formatNumber(summary.totalSettlements),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  icon: LucideIcons.clock,
                  iconColor: Colors.white.withValues(alpha: 0.6),
                  label: l10n.walletPending,
                  value: formatMoneyCompact(summary.pendingAmount),
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
                  icon: LucideIcons.download,
                  label: l10n.walletStatement,
                  color: Colors.white.withValues(alpha: 0.1),
                  onTap: onStatement,
                ),
              ),
            ],
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
                  color: Colors.white.withValues(alpha: 0.6),
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
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
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

class _NextPayoutCard extends StatelessWidget {
  const _NextPayoutCard({required this.s, required this.onTap});
  final SettlementResponse s;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = (s.status ?? 'PENDING').toLowerCase();
    final pending = status != 'completed';
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.clock,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pending ? l10n.walletNextPayout : l10n.walletLatestPayout,
                  style: AppText.body(size: 13, color: AppColors.textTertiary),
                ),
                const SizedBox(height: 2),
                Text(formatMoney(s.netAmount), style: AppText.money(size: 18)),
                const SizedBox(height: 2),
                Text(
                  '${formatDateShort(s.settlementDate)} · '
                  '${status[0].toUpperCase()}${status.substring(1)}',
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

class _TxnRow extends StatelessWidget {
  const _TxnRow(this.e);
  final _Entry e;

  @override
  Widget build(BuildContext context) {
    final inbound = e.inbound && !e.failed;
    return ListRow(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: inbound
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.dangerBg,
          shape: BoxShape.circle,
        ),
        child: Icon(
          inbound ? LucideIcons.arrowDownLeft : LucideIcons.arrowUpRight,
          size: 16,
          color: inbound ? AppColors.primary : AppColors.danger,
        ),
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
