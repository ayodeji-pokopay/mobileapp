import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../format.dart';

/// A preset window (7, 30, 90 days) or a custom range picked in a
/// Material date-range dialog.
class DateWindow {
  const DateWindow._(this.days, this.start, this.end);

  const factory DateWindow.days(int days) = DateWindow._preset;
  const DateWindow._preset(int days) : this._(days, null, null);
  const DateWindow.custom(DateTime start, DateTime end)
    : this._(null, start, end);

  final int? days;
  final DateTime? start;
  final DateTime? end;

  bool get isCustom => days == null;

  DateTime get from {
    if (start != null) return start!;
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: (days ?? 7) - 1));
  }

  /// End of today at day precision, so two windows built moments apart
  /// compare equal and don't churn the providers keyed on them.
  DateTime get to {
    if (end != null) return end!;
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59);
  }

  @override
  bool operator ==(Object other) =>
      other is DateWindow &&
      other.days == days &&
      other.start == start &&
      other.end == end;

  @override
  int get hashCode => Object.hash(days, start, end);
}

/// Preset chips plus a calendar chip that opens the range picker.
class DateWindowChips extends StatelessWidget {
  const DateWindowChips({
    super.key,
    required this.value,
    required this.onChanged,
    required this.presetLabels,
    this.presets = const [7, 30, 90],
    required this.customLabel,
  });

  final DateWindow value;
  final ValueChanged<DateWindow> onChanged;
  final List<String> presetLabels;
  final List<int> presets;
  final String customLabel;

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 3),
      lastDate: now,
      initialDateRange: value.isCustom
          ? DateTimeRange(start: value.from, end: value.to)
          : null,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: AppColors.primary,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (range == null) return;
    onChanged(
      DateWindow.custom(
        DateTime(range.start.year, range.start.month, range.start.day),
        DateTime(range.end.year, range.end.month, range.end.day, 23, 59, 59),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final customText = value.isCustom
        ? '${formatDateShort(value.from.toIso8601String())} – ${formatDateShort(value.to.toIso8601String())}'
        : customLabel;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (var i = 0; i < presets.length; i++) ...[
            _Chip(
              label: presetLabels[i],
              selected: !value.isCustom && value.days == presets[i],
              onTap: () => onChanged(DateWindow.days(presets[i])),
            ),
            const SizedBox(width: 8),
          ],
          _Chip(
            label: customText,
            icon: LucideIcons.calendarDays,
            selected: value.isCustom,
            onTap: () => _pick(context),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? AppColors.onNavy : AppColors.textBody;
    return Material(
      color: selected ? AppColors.navy : AppColors.surface,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14, color: fg),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: AppText.body(
                  size: 14,
                  weight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom-of-list footer: spinner while loading, quiet note at the end.
class LoadMoreFooter extends StatelessWidget {
  const LoadMoreFooter({
    super.key,
    required this.loading,
    required this.hasMore,
    required this.endLabel,
  });
  final bool loading;
  final bool hasMore;
  final String endLabel;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }
    if (hasMore) return const SizedBox(height: 8);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          endLabel,
          style: AppText.body(size: 12, color: AppColors.textTertiary),
        ),
      ),
    );
  }
}
