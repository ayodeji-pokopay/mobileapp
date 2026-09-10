import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

/// Small caption above a list card, e.g. "ACCOUNT ACTIVITY" or "2026".
class SectionLabel extends StatelessWidget {
  const SectionLabel(
    this.text, {
    super.key,
    this.uppercase = false,
    this.color,
    this.padding = const EdgeInsets.only(left: 4, bottom: 12),
  });

  final String text;
  final bool uppercase;
  final Color? color;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? AppColors.textTertiary;
    return Padding(
      padding: padding,
      child: Text(
        uppercase ? text.toUpperCase() : text,
        style: uppercase
            ? AppText.label(color: color)
            : AppText.body(size: 13, weight: FontWeight.w600, color: color),
      ),
    );
  }
}
