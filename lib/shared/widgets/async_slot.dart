import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../l10n/generated/app_localizations.dart';
import '../error_text.dart';
import 'list_card.dart';
import 'skeleton.dart';

/// Renders loading / error / data for an [AsyncValue] with the design's
/// white card treatment.
class AsyncSlot<T> extends StatelessWidget {
  const AsyncSlot({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
    this.loadingHeight = 120,
    this.skeleton,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;
  final double loadingHeight;
  final Widget? skeleton;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnRefresh: true,
      data: data,
      loading: () => skeleton ?? Skeleton.card(height: loadingHeight),
      error: (err, _) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: cardShadow,
        ),
        child: Row(
          children: [
            Icon(LucideIcons.triangleAlert, size: 20, color: AppColors.danger),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                describeError(err, AppLocalizations.of(context)),
                style: AppText.body(size: 14, color: AppColors.textBody),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(width: 8),
              TextButton(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(AppLocalizations.of(context).commonRetry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
