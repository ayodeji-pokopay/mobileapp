import 'package:flutter/material.dart';

/// Pokopay colour tokens. Every accessor is a getter over the active
/// [Palette], so widgets keep writing `AppColors.surface` and pick up
/// dark mode automatically when [AppColors.apply] switches the palette.
///
/// Brand constants that never change (the navy and green themselves) are
/// exposed as `brand*` consts for gradients and logos.
class AppColors {
  AppColors._();

  static Palette _p = Palette.light;
  static bool get isDark => _p.isDark;

  /// Switch the active palette. Callers must rebuild the widget tree
  /// afterwards (the app does this by re-keying MaterialApp).
  static void apply({required bool dark}) {
    _p = dark ? Palette.dark : Palette.light;
  }

  // Brand (constant, usable in const contexts)
  static const Color brandNavy = Color(0xFF0C2545);
  static const Color brandNavyMuted = Color(0xFF1A3A5F);
  static const Color brandNavyDark = Color(0xFF061729);
  static const Color brandGreen = Color(0xFF317E3D);

  // Brand accents
  static Color get primary => _p.primary;
  static Color get primaryBright => _p.primaryBright;
  static Color get primaryDark => _p.primaryDark;
  static Color get primaryGlow => _p.primaryGlow;
  static Color get primaryLight => _p.primaryLight;
  static Color get primaryTint => _p.primaryTint;

  /// Ink: the dark navy in light mode, near-white in dark mode. Use for
  /// text and strokes. For navy *surfaces* use [brandNavy].
  static Color get navy => _p.ink;
  static Color get navyMuted => _p.inkMuted;
  static Color get navyDark => _p.inkDark;

  /// Text placed on a [brandNavy] or [navy]-filled surface.
  static Color get onNavy => _p.onInk;

  // Surfaces
  static Color get canvas => _p.canvas;
  static Color get background => _p.canvas;
  static Color get surface => _p.surface;
  static Color get surfaceAlt => _p.surfaceAlt;
  static Color get surfacePressed => _p.surfacePressed;
  static Color get divider => _p.divider;
  static Color get hairline => _p.hairline;
  static Color get border => _p.border;
  static Color get borderStrong => _p.borderStrong;
  static Color get shadow => _p.shadow;

  // Text
  static Color get textPrimary => _p.ink;
  static Color get textBody => _p.textBody;
  static Color get textSecondary => _p.textSecondary;
  static Color get textTertiary => _p.textTertiary;
  static Color get textDisabled => _p.textDisabled;
  static Color get iconMuted => _p.textDisabled;

  // Status
  static Color get success => _p.primary;
  static Color get successBg => _p.primaryLight;
  static Color get warning => _p.warning;
  static Color get warningBg => _p.warningBg;
  static Color get warningText => _p.warningText;
  static Color get danger => _p.danger;
  static Color get dangerBg => _p.dangerBg;
  static Color get info => _p.info;
  static Color get infoBg => _p.infoBg;
  static Color get reversed => _p.reversed;
  static Color get reversedBg => _p.reversedBg;

  // Card brands
  static const Color visa = Color(0xFF1A1F71);
  static const Color mastercard = Color(0xFFEB001B);
}

class Palette {
  const Palette({
    required this.isDark,
    required this.primary,
    required this.primaryBright,
    required this.primaryDark,
    required this.primaryGlow,
    required this.primaryLight,
    required this.primaryTint,
    required this.ink,
    required this.inkMuted,
    required this.inkDark,
    required this.onInk,
    required this.canvas,
    required this.surface,
    required this.surfaceAlt,
    required this.surfacePressed,
    required this.divider,
    required this.hairline,
    required this.border,
    required this.borderStrong,
    required this.shadow,
    required this.textBody,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.warning,
    required this.warningBg,
    required this.warningText,
    required this.danger,
    required this.dangerBg,
    required this.info,
    required this.infoBg,
    required this.reversed,
    required this.reversedBg,
  });

  final bool isDark;
  final Color primary,
      primaryBright,
      primaryDark,
      primaryGlow,
      primaryLight,
      primaryTint;
  final Color ink, inkMuted, inkDark, onInk;
  final Color canvas,
      surface,
      surfaceAlt,
      surfacePressed,
      divider,
      hairline,
      border,
      borderStrong,
      shadow;
  final Color textBody, textSecondary, textTertiary, textDisabled;
  final Color warning,
      warningBg,
      warningText,
      danger,
      dangerBg,
      info,
      infoBg,
      reversed,
      reversedBg;

  static const light = Palette(
    isDark: false,
    primary: Color(0xFF317E3D),
    primaryBright: Color(0xFF3D9E4C),
    primaryDark: Color(0xFF2D7238),
    primaryGlow: Color(0xFF7FD48F),
    primaryLight: Color(0xFFE8F5EA),
    primaryTint: Color(0xFFDCFCE7),
    ink: Color(0xFF0C2545),
    inkMuted: Color(0xFF1A3A5F),
    inkDark: Color(0xFF061729),
    onInk: Colors.white,
    canvas: Color(0xFFF0EFEC),
    surface: Colors.white,
    surfaceAlt: Color(0xFFE8E7E4),
    surfacePressed: Color(0xFFF8F8F7),
    divider: Color(0xFFF0EFEC),
    hairline: Color(0xFFE5E3E0),
    border: Color(0xFFE5E7EB),
    borderStrong: Color(0xFFD1D5DB),
    shadow: Color(0xFF0C2545),
    textBody: Color(0xFF374151),
    textSecondary: Color(0xFF6B7280),
    textTertiary: Color(0xFF6F7887),
    textDisabled: Color(0xFFB4BAC4),
    warning: Color(0xFFF59E0B),
    warningBg: Color(0xFFFEF9C3),
    warningText: Color(0xFF92400E),
    danger: Color(0xFFEF4444),
    dangerBg: Color(0xFFFEE2E2),
    info: Color(0xFF1D4ED8),
    infoBg: Color(0xFFDBEAFE),
    reversed: Color(0xFF6B4FD0),
    reversedBg: Color(0xFFECE7FB),
  );

  static const dark = Palette(
    isDark: true,
    primary: Color(0xFF4CAF5E),
    primaryBright: Color(0xFF62C876),
    primaryDark: Color(0xFF2F8A3F),
    primaryGlow: Color(0xFF7FD48F),
    primaryLight: Color(0xFF17301F),
    primaryTint: Color(0xFF14301C),
    ink: Color(0xFFE8EDF5),
    inkMuted: Color(0xFFC6D0DF),
    inkDark: Color(0xFFF5F7FB),
    onInk: Color(0xFF0F1624),
    canvas: Color(0xFF0F1624),
    surface: Color(0xFF172033),
    surfaceAlt: Color(0xFF243048),
    surfacePressed: Color(0xFF1C2639),
    divider: Color(0xFF212C42),
    hairline: Color(0xFF2B3750),
    border: Color(0xFF2B3750),
    borderStrong: Color(0xFF3C4A66),
    shadow: Colors.black,
    textBody: Color(0xFFC9D2E0),
    textSecondary: Color(0xFF9AA6B8),
    textTertiary: Color(0xFF8792A5),
    textDisabled: Color(0xFF55627A),
    warning: Color(0xFFF2B34C),
    warningBg: Color(0xFF3A2C10),
    warningText: Color(0xFFF6CB7A),
    danger: Color(0xFFF07A70),
    dangerBg: Color(0xFF3B1A19),
    info: Color(0xFF8AB4FF),
    infoBg: Color(0xFF172846),
    reversed: Color(0xFFB09CF5),
    reversedBg: Color(0xFF241D3E),
  );
}
