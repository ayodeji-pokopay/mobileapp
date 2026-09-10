import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_text.dart';

class AppTheme {
  AppTheme._();

  static TextStyle tagline(TextStyle? base, {double size = 12}) =>
      AppText.tagline(size: size);

  /// Light theme. Kept for callers and tests; [build] is the general form.
  static ThemeData light() => build(dark: false);

  /// Builds the theme for one brightness. Applies the matching palette
  /// first so every `AppColors` getter used below resolves correctly.
  static ThemeData build({required bool dark}) {
    AppColors.apply(dark: dark);
    final base = dark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);
    final body = GoogleFonts.dmSansTextTheme(base.textTheme);
    final display = GoogleFonts.montserratTextTheme(base.textTheme);

    final textTheme = body
        .copyWith(
          displayLarge: display.displayLarge,
          displayMedium: display.displayMedium,
          displaySmall: display.displaySmall,
          headlineLarge: display.headlineLarge,
          headlineMedium: display.headlineMedium,
          headlineSmall: display.headlineSmall,
          titleLarge: display.titleLarge,
        )
        .apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        );

    final pill = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(999),
    );
    InputBorder inputBorder([Color? color, double width = 0]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: color == null
              ? BorderSide.none
              : BorderSide(color: color, width: width),
        );

    return base.copyWith(
      brightness: dark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: AppColors.canvas,
      canvasColor: AppColors.canvas,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.brandNavy,
        onSecondary: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.danger,
        outline: AppColors.hairline,
      ),
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.canvas,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppText.body(size: 17, weight: FontWeight.w600),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: AppText.body(size: 16, color: AppColors.textTertiary),
        labelStyle: AppText.body(size: 14, color: AppColors.textBody),
        errorStyle: AppText.body(size: 12, color: AppColors.danger),
        border: inputBorder(),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(
          AppColors.primary.withValues(alpha: 0.35),
          2,
        ),
        errorBorder: inputBorder(AppColors.danger, 1),
        focusedErrorBorder: inputBorder(AppColors.danger, 1.5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
          disabledForegroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: AppText.body(size: 16, weight: FontWeight.w700),
          shape: pill,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size.fromHeight(50),
          side: BorderSide.none,
          shape: pill,
          textStyle: AppText.body(size: 16, weight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppText.body(size: 14, weight: FontWeight.w600),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.primary
              : AppColors.borderStrong,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: BorderSide(color: AppColors.borderStrong, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.primary
              : Colors.transparent,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: dark ? AppColors.surfaceAlt : AppColors.brandNavy,
        contentTextStyle: AppText.body(size: 14, color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      dialogTheme: DialogThemeData(backgroundColor: AppColors.surface),
      popupMenuTheme: PopupMenuThemeData(color: AppColors.surface),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
    );
  }
}
