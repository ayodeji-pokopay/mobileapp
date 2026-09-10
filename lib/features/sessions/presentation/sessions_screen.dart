import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/error_text.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/pills.dart';
import '../../../shared/widgets/section_label.dart';
import '../../auth/data/auth_repository.dart';

final sessionsProvider = FutureProvider<List<SessionInfo>>((ref) async {
  final list = await ref.watch(authRepositoryProvider).fetchSessions();
  list.sort((a, b) {
    if (a.current != b.current) return a.current ? -1 : 1;
    return (b.lastActivity ?? DateTime(0)).compareTo(
      a.lastActivity ?? DateTime(0),
    );
  });
  return list.where((s) => s.active).toList();
});

class SessionsScreen extends ConsumerStatefulWidget {
  const SessionsScreen({super.key});

  @override
  ConsumerState<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends ConsumerState<SessionsScreen> {
  String? _busyId;
  bool _busyAll = false;

  Future<void> _run(Future<void> Function() action, {String? id}) async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busyId = id;
      _busyAll = id == null;
    });
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
      ref.invalidate(sessionsProvider);
      messenger.showSnackBar(SnackBar(content: Text(l10n.sessionsRevoked)));
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(describeError(e, l10n)),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _busyId = null;
          _busyAll = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sessions = ref.watch(sessionsProvider);
    return BackScaffold(
      title: l10n.sessionsTitle,
      subtitle: l10n.sessionsHint,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(sessionsProvider);
          await ref.read(sessionsProvider.future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            AsyncSlot<List<SessionInfo>>(
              value: sessions,
              loadingHeight: 200,
              onRetry: () => ref.invalidate(sessionsProvider),
              data: (list) {
                final current = list.where((s) => s.current).toList();
                final others = list.where((s) => !s.current).toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (current.isNotEmpty) ...[
                      SectionLabel(
                        l10n.sessionsCurrent,
                        color: AppColors.textSecondary,
                      ),
                      ListCard(
                        children: [
                          for (final s in current) _Row(s: s, l10n: l10n),
                        ],
                      ),
                      const SizedBox(height: 18),
                    ],
                    SectionLabel(
                      l10n.sessionsOthers,
                      color: AppColors.textSecondary,
                    ),
                    if (others.isEmpty)
                      EmptyState(
                        icon: LucideIcons.smartphone,
                        title: l10n.sessionsEmpty,
                      )
                    else
                      ListCard(
                        children: [
                          for (final s in others)
                            _Row(
                              s: s,
                              l10n: l10n,
                              busy: _busyId == s.tokenId,
                              onRevoke: () => _run(
                                () => ref
                                    .read(authRepositoryProvider)
                                    .revokeSession(s.tokenId),
                                id: s.tokenId,
                              ),
                            ),
                        ],
                      ),
                    if (others.isNotEmpty) ...[
                      const SizedBox(height: 18),
                      OutlinedButton.icon(
                        onPressed: _busyAll
                            ? null
                            : () => _run(
                                () => ref
                                    .read(authRepositoryProvider)
                                    .revokeOtherSessions(),
                              ),
                        icon: Icon(
                          LucideIcons.logOut,
                          size: 18,
                          color: AppColors.danger,
                        ),
                        label: Text(
                          l10n.sessionsRevokeOthers,
                          style: AppText.body(
                            size: 16,
                            weight: FontWeight.w600,
                            color: AppColors.danger,
                          ),
                        ),
                      ),
                    ],
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

class _Row extends StatelessWidget {
  const _Row({
    required this.s,
    required this.l10n,
    this.onRevoke,
    this.busy = false,
  });
  final SessionInfo s;
  final AppLocalizations l10n;
  final VoidCallback? onRevoke;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final name = (s.deviceName ?? '').isNotEmpty
        ? s.deviceName!
        : s.isApp
        ? l10n.sessionsUnknownDevice
        : s.deviceInfo.split(' ').first;
    final where = s.location.isNotEmpty && s.location != s.ipAddress
        ? s.location
        : s.ipAddress;
    final sub = [
      if (s.lastActivity != null)
        l10n.sessionsLastActive(formatRelativeTime(s.lastActivity!)),
      if (where.isNotEmpty) where,
    ].join(' · ');
    return ListRow(
      leading: IconBubble(
        icon: s.isApp ? LucideIcons.smartphone : LucideIcons.globe,
        tone: s.current ? PillTone.success : PillTone.neutral,
      ),
      title: name,
      subtitle: sub,
      chevron: false,
      trailing: s.current
          ? StatusPill(label: l10n.sessionsCurrent, tone: PillTone.success)
          : busy
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : TextButton(
              onPressed: onRevoke,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.danger,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: const Size(0, 36),
              ),
              child: Text(l10n.sessionsRevoke),
            ),
    );
  }
}
