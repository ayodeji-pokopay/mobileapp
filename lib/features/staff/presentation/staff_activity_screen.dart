import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/staff_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/date_range_chip.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/pills.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/data/merchant_repository.dart';

class _ActivityState {
  const _ActivityState({
    required this.items,
    required this.page,
    required this.last,
    this.loadingMore = false,
  });
  final List<StaffActivity> items;
  final int page;
  final bool last;
  final bool loadingMore;
}

class _ActivityController extends AsyncNotifier<_ActivityState> {
  @override
  Future<_ActivityState> build() async {
    final mid = ref.watch(authControllerProvider).mid;
    if (mid == null)
      return const _ActivityState(items: [], page: 0, last: true);
    final p = await ref
        .watch(merchantRepositoryProvider)
        .fetchStaffActivity(mid: mid, page: 0);
    return _ActivityState(items: p.items, page: 0, last: p.last);
  }

  Future<void> loadMore() async {
    final cur = state.asData?.value;
    final mid = ref.read(authControllerProvider).mid;
    if (cur == null || cur.last || cur.loadingMore || mid == null) return;
    state = AsyncData(
      _ActivityState(
        items: cur.items,
        page: cur.page,
        last: cur.last,
        loadingMore: true,
      ),
    );
    try {
      final p = await ref
          .read(merchantRepositoryProvider)
          .fetchStaffActivity(mid: mid, page: cur.page + 1);
      state = AsyncData(
        _ActivityState(
          items: [...cur.items, ...p.items],
          page: cur.page + 1,
          last: p.last,
        ),
      );
    } catch (_) {
      state = AsyncData(
        _ActivityState(items: cur.items, page: cur.page, last: cur.last),
      );
    }
  }
}

final _activityProvider =
    AsyncNotifierProvider<_ActivityController, _ActivityState>(
      _ActivityController.new,
    );

/// Settings › Staff › Activity: who invited, changed or removed whom.
class StaffActivityScreen extends ConsumerWidget {
  const StaffActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(_activityProvider);
    return BackScaffold(
      title: l10n.staffActivityTitle,
      subtitle: l10n.staffActivityHint,
      fallbackRoute: '/settings/staff',
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(_activityProvider);
          await ref.read(_activityProvider.future);
        },
        child: AsyncSlot<_ActivityState>(
          value: state,
          loadingHeight: 240,
          onRetry: () => ref.invalidate(_activityProvider),
          data: (s) {
            if (s.items.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                children: [
                  EmptyState(
                    icon: LucideIcons.history,
                    title: l10n.staffActivityEmpty,
                  ),
                ],
              );
            }
            return NotificationListener<ScrollNotification>(
              onNotification: (n) {
                if (n.metrics.pixels > n.metrics.maxScrollExtent - 200) {
                  ref.read(_activityProvider.notifier).loadMore();
                }
                return false;
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                children: [
                  ListCard(children: [for (final a in s.items) _Row(a: a)]),
                  LoadMoreFooter(
                    hasMore: !s.last,
                    loading: s.loadingMore,
                    endLabel: l10n.staffActivityEnd,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.a});
  final StaffActivity a;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (icon, tone, title) = switch (a.action) {
      'INVITED' => (
        LucideIcons.userPlus,
        PillTone.info,
        l10n.staffActionInvited,
      ),
      'RESENT_INVITE' => (
        LucideIcons.mailCheck,
        PillTone.info,
        l10n.staffActionResent,
      ),
      'ACCEPTED' => (
        LucideIcons.userCheck,
        PillTone.success,
        l10n.staffActionAccepted,
      ),
      'ROLE_CHANGED' => (
        LucideIcons.shield,
        PillTone.warning,
        l10n.staffActionRoleChanged,
      ),
      'ACTIVATED' => (
        LucideIcons.userCheck,
        PillTone.success,
        l10n.staffActionActivated,
      ),
      'DEACTIVATED' => (
        LucideIcons.userX,
        PillTone.danger,
        l10n.staffActionDeactivated,
      ),
      'REMOVED' => (
        LucideIcons.trash2,
        PillTone.danger,
        l10n.staffActionRemoved,
      ),
      _ => (LucideIcons.activity, PillTone.neutral, a.action),
    };
    final sub = [
      if (a.targetEmail.isNotEmpty) a.targetEmail,
      if (a.detail.isNotEmpty) a.detail,
      if (a.actorEmail.isNotEmpty) l10n.staffActivityBy(a.actorEmail),
      if (a.createdAt != null) formatRelativeTime(a.createdAt!),
    ].join(' · ');
    return ListRow(
      leading: IconBubble(icon: icon, tone: tone),
      title: title,
      subtitle: sub,
      chevron: false,
      titleColor: AppColors.navy,
    );
  }
}
