import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/business_models.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/error_text.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pills.dart';
import '../../../shared/widgets/section_label.dart';
import '../../merchant/presentation/merchant_providers.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // Opening the feed counts as reading it; mark once the list is loaded.
    ref.listenManual(notificationsProvider, (prev, next) {
      if (next.hasValue && (next.value?.unreadCount ?? 0) > 0) {
        ref.read(notificationsProvider.notifier).markAllRead();
      }
    }, fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final feed = ref.watch(notificationsProvider);
    return BackScaffold(
      title: l10n.notificationsTitle,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(notificationsProvider);
          await ref.read(notificationsProvider.future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            const OfflineBanner(),
            AsyncSlot<NotificationFeed>(
              value: feed,
              loadingHeight: 220,
              onRetry: () => ref.invalidate(notificationsProvider),
              data: (f) {
                if (f.content.isEmpty) {
                  return EmptyState(
                    icon: LucideIcons.bellRing,
                    title: l10n.notificationsEmpty,
                    subtitle: l10n.notificationsEmptyHint,
                  );
                }
                final alerts = f.content.where((n) => n.needsReview).toList();
                final rest = f.content.where((n) => !n.needsReview).toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (alerts.isNotEmpty) ...[
                      SectionLabel(
                        l10n.alertsNeedsReview,
                        color: AppColors.danger,
                      ),
                      for (final n in alerts) _AlertCard(n: n),
                      const SizedBox(height: 10),
                    ],
                    if (rest.isNotEmpty)
                      ListCard(
                        children: [
                          for (final n in rest) _NotificationRow(n: n),
                        ],
                      ),
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

/// A suspicious-activity alert awaiting review.
class _AlertCard extends ConsumerStatefulWidget {
  const _AlertCard({required this.n});
  final NotificationItem n;

  @override
  ConsumerState<_AlertCard> createState() => _AlertCardState();
}

class _AlertCardState extends ConsumerState<_AlertCard> {
  bool _busy = false;

  Future<void> _acknowledge() async {
    final l10n = AppLocalizations.of(context);
    final id = widget.n.id;
    if (id == null) return;
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(notificationsProvider.notifier).acknowledge(id);
      messenger.showSnackBar(SnackBar(content: Text(l10n.alertsReviewed)));
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(describeError(e, l10n)),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final n = widget.n;
    final high = (n.severity ?? '').toUpperCase() == 'HIGH';
    final tone = high ? PillTone.danger : PillTone.warning;
    final when = DateTime.tryParse(n.createdAt ?? '');
    final evidence = alertEvidence(n, l10n);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SurfaceCard(
        radius: 16,
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconBubble(icon: LucideIcons.shieldAlert, tone: tone),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              n.title ?? l10n.alertsTitle,
                              style: AppText.body(
                                size: 14.5,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          StatusPill(
                            label: high
                                ? l10n.alertsSeverityHigh
                                : (n.severity ?? ''),
                            tone: tone,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        n.body ?? '',
                        style: AppText.body(
                          size: 13,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                      if (evidence != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          evidence,
                          style: AppText.body(
                            size: 12.5,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                      if (when != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          formatRelativeTime(when),
                          style: AppText.body(
                            size: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: (n.reference ?? '').isEmpty
                        ? null
                        : () => context.push(AppRoutes.stores),
                    child: Text(l10n.alertsViewTerminal),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _busy ? null : _acknowledge,
                    child: _busy
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(l10n.alertsMarkReviewed),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Human line from the alert's evidence map, per rule.
String? alertEvidence(NotificationItem n, AppLocalizations l10n) {
  final e = n.evidence;
  if (e == null) return null;
  switch ((n.rule ?? '').toUpperCase()) {
    case 'REVERSAL_BURST':
      final count = (e['reversals'] as num?)?.toInt() ?? 0;
      final mins = (e['windowMinutes'] as num?)?.toInt() ?? 60;
      final tid = (e['tid'] ?? n.reference ?? '').toString();
      return l10n.alertsReversalBurst(count, mins, tid);
    default:
      return e.entries.map((x) => '${x.key}: ${x.value}').join(' · ');
  }
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({required this.n});
  final NotificationItem n;

  @override
  Widget build(BuildContext context) {
    final (icon, tone) = switch ((n.type ?? '').toUpperCase()) {
      'SUSPICIOUS_ACTIVITY' => (LucideIcons.shieldCheck, PillTone.neutral),
      'SETTLEMENT_COMPLETED' => (LucideIcons.banknote, PillTone.success),
      'SETTLEMENT_FAILED' => (LucideIcons.circleAlert, PillTone.danger),
      'TERMINAL_INACTIVE' => (LucideIcons.printer, PillTone.warning),
      'KEY_EXPIRING' => (LucideIcons.lock, PillTone.warning),
      _ => (LucideIcons.bell, PillTone.info),
    };
    final when = DateTime.tryParse(n.createdAt ?? '');
    return ListRow(
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          IconBubble(icon: icon, tone: tone),
          if (!n.read)
            Positioned(
              right: -1,
              top: -1,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: n.title ?? '',
      subtitle: [
        if ((n.body ?? '').isNotEmpty) n.body!,
        if (when != null) formatRelativeTime(when),
      ].join('\n'),
      chevron: false,
      trailing: null,
      titleColor: n.read ? AppColors.textBody : AppColors.navy,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    );
  }
}
