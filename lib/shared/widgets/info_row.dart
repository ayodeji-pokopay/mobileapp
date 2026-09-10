import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../l10n/generated/app_localizations.dart';

/// Label-over-value row for detail screens, with optional copy action.
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.mono = false,
    this.copyable = false,
  });

  final String label;
  final String? value;
  final bool mono;
  final bool copyable;

  @override
  Widget build(BuildContext context) {
    final v = (value ?? '').trim();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppText.body(size: 13, color: AppColors.textTertiary),
                ),
                const SizedBox(height: 3),
                Text(
                  v.isEmpty ? '—' : v,
                  style: AppText.body(
                    size: 15,
                    weight: FontWeight.w500,
                    letterSpacing: mono ? 0.4 : null,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (copyable && v.isNotEmpty)
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: v));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context).commonCopied(label),
                    ),
                  ),
                );
              },
              icon: const Icon(
                LucideIcons.copy,
                size: 18,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}
