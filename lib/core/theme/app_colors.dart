import 'package:flutter/material.dart';

/// Pokopay brand and UI colour tokens, mirrored from the Figma design system.
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF317E3D);
  static const Color primaryBright = Color(0xFF3D9E4C);
  static const Color primaryDark = Color(0xFF2D7238);
  static const Color primaryGlow = Color(0xFF7FD48F);
  static const Color primaryLight = Color(0xFFE8F5EA);
  static const Color primaryTint = Color(0xFFDCFCE7);

  static const Color navy = Color(0xFF0C2545);
  static const Color navyMuted = Color(0xFF1A3A5F);
  static const Color navyDark = Color(0xFF061729);

  // Surfaces
  static const Color canvas = Color(0xFFF0EFEC);
  static const Color background = canvas;
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFE8E7E4);
  static const Color surfacePressed = Color(0xFFF8F8F7);
  static const Color divider = Color(0xFFF0EFEC);
  static const Color hairline = Color(0xFFE5E3E0);
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderStrong = Color(0xFFD1D5DB);

  // Text
  static const Color textPrimary = navy;
  static const Color textBody = Color(0xFF374151);
  static const Color textSecondary = Color(0xFF6B7280);

  /// Darkened from the design's #9CA3AF so small text passes WCAG AA (4.5:1).
  static const Color textTertiary = Color(0xFF6F7887);

  /// Decorative-only grey (icons, dividers), not for text.
  static const Color iconMuted = Color(0xFF9CA3AF);
  static const Color textDisabled = Color(0xFFD1D5DB);

  // Status
  static const Color success = primary;
  static const Color successBg = primaryLight;
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningBg = Color(0xFFFEF9C3);
  static const Color warningText = Color(0xFF92400E);
  static const Color danger = Color(0xFFEF4444);
  static const Color dangerBg = Color(0xFFFEE2E2);

  // Card brands
  static const Color visa = Color(0xFF1A1F71);
  static const Color mastercard = Color(0xFFEB001B);
}
