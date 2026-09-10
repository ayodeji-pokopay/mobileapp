import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/connectivity/offline_status.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../l10n/generated/app_localizations.dart';

/// Shown above merchant data when it was served from the local cache.
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  static String relative(AppLocalizations l10n, DateTime t, {DateTime? now}) {
    final diff = (now ?? DateTime.now()).difference(t);
    if (diff.inMinutes < 1) return l10n.relativeJustNow;
    if (diff.inMinutes < 60) return l10n.relativeMinutes(diff.inMinutes);
    if (diff.inHours < 24) return l10n.relativeHours(diff.inHours);
    return l10n.relativeDays(diff.inDays);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final since = ref.watch(offlineStatusProvider);
    if (since == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Semantics(
      liveRegion: true,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.warningBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(LucideIcons.wifiOff, size: 16, color: AppColors.warningText),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                l10n.offlineBanner(relative(l10n, since)),
                style: AppText.body(
                  size: 13,
                  weight: FontWeight.w500,
                  color: AppColors.warningText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
