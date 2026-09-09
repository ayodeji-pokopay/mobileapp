import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Circular white button with a soft shadow (back, close, settings, bell).
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 40,
    this.iconSize = 20,
    this.background = AppColors.surface,
    this.iconColor = AppColors.textBody,
    this.badge = false,
    this.shadow = true,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final Color background;
  final Color iconColor;
  final bool badge;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
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
    );
  }
}
