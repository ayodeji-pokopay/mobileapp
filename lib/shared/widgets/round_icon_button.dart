import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Circular white button with a soft shadow (back, close, settings, bell).
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
    this.size = 36,
    this.iconSize = 18,
    this.background,
    this.iconColor,
    this.badge = false,
    this.shadow = true,
  });

  final IconData icon;
  final VoidCallback onTap;

  /// Read by screen readers; the button has no visible text.
  final String semanticLabel;
  final double size;
  final double iconSize;
  final Color? background;
  final Color? iconColor;
  final bool badge;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final background = this.background ?? AppColors.surface;
    final iconColor = this.iconColor ?? AppColors.textBody;
    // Keep the visual at [size] but guarantee a 44pt touch target.
    final hitPad = size < 44 ? (44 - size) / 2 : 0.0;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: EdgeInsets.all(hitPad),
            child: Ink(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
                boxShadow: shadow
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(icon, size: iconSize, color: iconColor),
                  if (badge)
                    Positioned(
                      top: size * 0.17,
                      right: size * 0.17,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: iconColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
