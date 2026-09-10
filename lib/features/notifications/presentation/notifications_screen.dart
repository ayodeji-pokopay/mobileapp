import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/business_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/pills.dart';
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
                return ListCard(
                  children: [for (final n in f.content) _NotificationRow(n: n)],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({required this.n});
  final NotificationItem n;

  @override
  Widget build(BuildContext context) {
    final (icon, tone) = switch ((n.type ?? '').toUpperCase()) {
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
