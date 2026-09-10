import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

enum PillTone { success, warning, danger, info, neutral, reversed }

/// Small status chip with a dot: "Approved", "Pending", "Reversed".
class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.label, required this.tone});

  final String label;
  final PillTone tone;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      PillTone.success => (AppColors.primaryLight, AppColors.primary),
      PillTone.warning => (AppColors.warningBg, AppColors.warningText),
      PillTone.danger => (AppColors.dangerBg, AppColors.danger),
      PillTone.info => (const Color(0xFFDBEAFE), const Color(0xFF1D4ED8)),
      PillTone.reversed => (const Color(0xFFECE7FB), const Color(0xFF6B4FD0)),
      PillTone.neutral => (AppColors.surfaceAlt, AppColors.textSecondary),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppText.body(size: 12, weight: FontWeight.w600, color: fg),
          ),
        ],
      ),
    );
  }
}

/// "+15.3% vs yesterday" with an arrow, tinted by direction.
class DeltaPill extends StatelessWidget {
  const DeltaPill({super.key, required this.delta, required this.label});

  /// Percentage change; null renders a neutral dash.
  final double? delta;
  final String Function(String formatted) label;

  @override
  Widget build(BuildContext context) {
    final d = delta;
    final up = (d ?? 0) >= 0;
    final fg = d == null
        ? AppColors.textTertiary
        : up
        ? AppColors.primary
        : AppColors.danger;
    final text = d == null ? '—' : '${up ? '+' : ''}${d.toStringAsFixed(1)}%';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (d != null)
          Icon(
            up ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
            size: 12,
            color: fg,
          ),
        if (d != null) const SizedBox(width: 2),
        Flexible(
          child: Text(
            label(text),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.body(size: 12, weight: FontWeight.w500, color: fg),
          ),
        ),
      ],
    );
  }
}

/// Circular tinted icon used as a list leading.
class IconBubble extends StatelessWidget {
  const IconBubble({
    super.key,
    required this.icon,
    this.tone = PillTone.neutral,
    this.size = 40,
  });

  final IconData icon;
  final PillTone tone;
  final double size;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      PillTone.success => (AppColors.primaryLight, AppColors.primary),
      PillTone.warning => (AppColors.warningBg, AppColors.warningText),
      PillTone.danger => (AppColors.dangerBg, AppColors.danger),
      PillTone.info => (const Color(0xFFDBEAFE), const Color(0xFF1D4ED8)),
      PillTone.reversed => (const Color(0xFFECE7FB), const Color(0xFF6B4FD0)),
      PillTone.neutral => (AppColors.canvas, AppColors.textBody),
    };
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, size: size * 0.45, color: fg),
    );
  }
}
