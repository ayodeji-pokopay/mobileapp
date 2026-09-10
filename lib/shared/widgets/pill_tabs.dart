import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

/// Row of pill chips; the active one is filled navy.
class PillTabs extends StatelessWidget {
  const PillTabs({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.inactiveTextColor,
    this.scrollable = false,
    this.dropdown = false,
  });

  final List<String> items;
  final int selected;
  final ValueChanged<int> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? inactiveTextColor;
  final bool scrollable;
  final bool dropdown;

  @override
  Widget build(BuildContext context) {
    final activeColor = this.activeColor ?? AppColors.navy;
    final inactiveColor = this.inactiveColor ?? AppColors.surfaceAlt;
    final inactiveTextColor = this.inactiveTextColor ?? AppColors.textSecondary;
    final chips = [
      for (var i = 0; i < items.length; i++)
        Padding(
          padding: EdgeInsets.only(right: i == items.length - 1 ? 0 : 8),
          child: PillChip(
            label: items[i],
            selected: i == selected,
            onTap: () => onChanged(i),
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            inactiveTextColor: inactiveTextColor,
            dropdown: dropdown,
          ),
        ),
    ];
    if (scrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(children: chips),
      );
    }
    return Row(children: chips);
  }
}

class PillChip extends StatelessWidget {
  const PillChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.activeColor,
    this.inactiveColor,
    this.inactiveTextColor,
    this.dropdown = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? inactiveTextColor;
  final bool dropdown;

  @override
  Widget build(BuildContext context) {
    final activeColor = this.activeColor ?? AppColors.navy;
    final inactiveColor = this.inactiveColor ?? AppColors.surfaceAlt;
    final inactiveTextColor = this.inactiveTextColor ?? AppColors.textSecondary;
    final fg = selected ? AppColors.onNavy : inactiveTextColor;
    return Material(
      color: selected ? activeColor : inactiveColor,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppText.body(
                  size: 14,
                  weight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: fg,
                ),
              ),
              if (dropdown) ...[
                const SizedBox(width: 4),
                Icon(
                  LucideIcons.chevronDown,
                  size: 14,
                  color: fg.withValues(alpha: 0.6),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// iOS-style segmented control on a grey track with a white sliding pill.
class SegmentedControl extends StatelessWidget {
  const SegmentedControl({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
  });

  final List<String> items;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == selected
                        ? AppColors.surface
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: i == selected
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.10),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    items[i],
                    style: AppText.body(
                      size: 15,
                      weight: i == selected ? FontWeight.w600 : FontWeight.w400,
                      color: i == selected
                          ? AppColors.navy
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Text tabs with an underline indicator (Sales screen).
class UnderlineTabs extends StatelessWidget {
  const UnderlineTabs({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
  });

  final List<String> items;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.hairline)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++)
            GestureDetector(
              onTap: () => onChanged(i),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        items[i],
                        style: AppText.body(
                          size: 15,
                          weight: i == selected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: i == selected
                              ? AppColors.navy
                              : AppColors.textTertiary,
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: i == selected
                            ? AppColors.navy
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
