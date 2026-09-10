import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography helpers. Montserrat carries headings and money figures,
/// DM Sans carries body copy, matching the Figma design.
class AppText {
  AppText._();

  static TextStyle display({
    double size = 42,
    FontWeight weight = FontWeight.w800,
    Color color = AppColors.navy,
    double? letterSpacing,
    double height = 1.05,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.montserrat(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing ?? -size * 0.025,
      height: height,
      decoration: decoration,
      decorationColor: color,
    );
  }

  static TextStyle money({
    double size = 15,
    FontWeight weight = FontWeight.w700,
    Color color = AppColors.navy,
    double? letterSpacing,
    double height = 1.0,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.montserrat(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing ?? (size >= 24 ? -size * 0.025 : 0),
      height: height,
      decoration: decoration,
      decorationColor: color,
    );
  }

  static TextStyle body({
    double size = 15,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.navy,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.dmSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  /// Small uppercase section label, e.g. "ACCOUNT ACTIVITY".
  static TextStyle label({Color color = AppColors.textTertiary}) {
    return GoogleFonts.dmSans(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.7,
    );
  }

  static TextStyle tagline({double size = 12}) {
    return GoogleFonts.josefinSans(
      fontSize: size,
      fontWeight: FontWeight.w400,
      letterSpacing: 2.0,
      color: AppColors.primary,
    );
  }
}
