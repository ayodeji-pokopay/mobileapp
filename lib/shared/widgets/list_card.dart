import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

/// White rounded container that separates its children with hairline
/// dividers, the primary list surface in the design.
class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.children,
    this.padding,
    this.radius = 16,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const Divider(height: 1, color: AppColors.divider),
          ],
        ],
      ),
    );
  }
}

/// Plain white card with inner padding for free-form content.
class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = 24,
    this.color = AppColors.surface,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Ink(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
    if (onTap == null) {
      return Material(color: Colors.transparent, child: card);
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: card,
      ),
    );
  }
}

/// A row inside a [ListCard]: leading widget, title, subtitle, trailing.
class ListRow extends StatelessWidget {
  const ListRow({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.titleColor = AppColors.navy,
    this.chevron,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  });

  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color titleColor;
  final bool? chevron;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final showChevron = chevron ?? (onTap != null && trailing == null);
    final row = Padding(
      padding: padding,
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 16)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.body(
                    size: 15,
                    weight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.body(
                      size: 13,
                      color: AppColors.textTertiary,
                      height: 1.35,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 12), trailing!],
          if (showChevron) ...[
            const SizedBox(width: 8),
            const Icon(LucideIcons.chevronRight,
                size: 20, color: AppColors.textDisabled),
          ],
        ],
      ),
    );
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        highlightColor: AppColors.surfacePressed,
        child: row,
      ),
    );
  }
}

/// Square initials tile used as a list avatar.
class InitialsTile extends StatelessWidget {
  const InitialsTile({
    super.key,
    required this.text,
    this.size = 40,
    this.radius = 12,
    this.background = AppColors.canvas,
    this.foreground = AppColors.navy,
    this.fontSize = 11,
  });

  final String text;
  final double size;
  final double radius;
  final Color background;
  final Color foreground;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        text,
        style: AppText.money(size: fontSize, color: foreground),
      ),
    );
  }
}

/// Small direction badge (money in / money out) overlaid on an avatar.
class DirectionBadge extends StatelessWidget {
  const DirectionBadge({super.key, required this.inbound, this.size = 16});

  final bool inbound;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: inbound ? AppColors.primary : AppColors.danger,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.surface, width: 1.5),
      ),
      child: Icon(
        inbound ? LucideIcons.arrowDownLeft : LucideIcons.arrowUpRight,
        size: size * 0.6,
        color: Colors.white,
      ),
    );
  }
}

String initialsOf(String name, {String fallback = 'P'}) {
  final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
  if (parts.isEmpty) return fallback;
  return parts.take(2).map((p) => p[0].toUpperCase()).join();
}
