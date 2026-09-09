import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import 'round_icon_button.dart';
import '../../l10n/generated/app_localizations.dart';

/// Page chrome from the design: round white back button, oversized
/// Montserrat title, warm off-white canvas.
class BackScaffold extends StatelessWidget {
  const BackScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.bottomNav,
    this.titleSize = 42,
    this.showBack = true,
    this.fallbackRoute = '/dashboard',
    required this.child,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? bottomNav;
  final double titleSize;
  final bool showBack;
  final String fallbackRoute;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.canvas,
      bottomNavigationBar: bottomNav,
      body: SafeArea(
        bottom: bottomNav == null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showBack || trailing != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (showBack)
                          RoundIconButton(
                            icon: LucideIcons.arrowLeft,
                            semanticLabel: l10n.commonBack,
                            onTap: () => context.canPop()
                                ? context.pop()
                                : context.go(fallbackRoute),
                          )
                        else
                          const SizedBox.shrink(),
                        if (trailing != null) trailing!,
                      ],
                    ),
                  SizedBox(height: showBack || trailing != null ? 20 : 4),
                  Text(title, style: AppText.display(size: titleSize)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      subtitle!,
                      style: AppText.body(
                        size: 15,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
