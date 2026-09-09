import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../l10n/generated/app_localizations.dart';

enum NavTab { home, sales, money, settings }

/// Bottom navigation from the design: the active tab expands into a
/// grey chip with icon and label, inactive tabs are stacked icon + label.
class PokoBottomNav extends StatelessWidget {
  const PokoBottomNav({super.key, required this.active});

  final NavTab active;

  static const _items = [
    (NavTab.home, LucideIcons.house, AppRoutes.dashboard),
    (NavTab.sales, LucideIcons.chartNoAxesColumn, AppRoutes.reports),
    (NavTab.money, LucideIcons.wallet, AppRoutes.wallet),
    (NavTab.settings, LucideIcons.settings, AppRoutes.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottom = MediaQuery.paddingOf(context).bottom;
    final labels = [
      l10n.navHome,
      l10n.navSales,
      l10n.navMoney,
      l10n.navSettings,
    ];
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(16, 8, 16, bottom > 0 ? bottom : 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final (i, (tab, icon, route)) in _items.indexed)
            _NavItem(
              icon: icon,
              label: labels[i],
              active: tab == active,
              onTap: () {
                if (tab != active) context.go(route);
              },
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: active,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: active
              ? Container(
                  key: const ValueKey('active'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 20, color: AppColors.navy),
                      const SizedBox(width: 6),
                      Text(
                        label,
                        style: AppText.body(size: 14, weight: FontWeight.w700),
                      ),
                    ],
                  ),
                )
              : Padding(
                  key: const ValueKey('inactive'),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 20, color: AppColors.textTertiary),
                      const SizedBox(height: 3),
                      Text(
                        label,
                        style: AppText.body(
                          size: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
