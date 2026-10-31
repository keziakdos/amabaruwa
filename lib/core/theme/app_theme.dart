import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.solar,
      brightness: Brightness.light,
      primary: AppColors.solar,
      onPrimary: AppColors.night,
      secondary: AppColors.gold,
      onSecondary: AppColors.night,
      surface: AppColors.white,
      onSurface: AppColors.night,
      error: AppColors.danger,
    );

    return _base(scheme, AppColors.white, AppColors.night).copyWith(
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.night,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.solar,
      brightness: Brightness.dark,
      primary: AppColors.solar,
      onPrimary: AppColors.night,
      secondary: AppColors.gold,
      onSecondary: AppColors.night,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
      error: const Color(0xFFFFB4AB),
    );

    return _base(scheme, AppColors.darkBackground, AppColors.darkText).copyWith(
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkText,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static ThemeData _base(ColorScheme scheme, Color background, Color text) {
    final border = scheme.brightness == Brightness.dark
        ? AppColors.darkLine
        : AppColors.line;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Lato',
      splashFactory: InkSparkle.splashFactory,
      textTheme: _textTheme(text),
      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: border),
        ),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.brightness == Brightness.dark
            ? AppColors.darkSurface
            : AppColors.mist,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        hintStyle: TextStyle(color: AppColors.muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gold, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.solar,
          foregroundColor: AppColors.night,
          minimumSize: const Size(48, 48),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: text,
          minimumSize: const Size(48, 48),
          side: BorderSide(color: text.withValues(alpha: 0.24)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.amberText,
          minimumSize: const Size(48, 48),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(48, 48),
          foregroundColor: text,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: AppColors.glow,
        height: 72,
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 23,
            color: selected ? AppColors.night : AppColors.muted,
          );
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.night,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.gold,
        linearTrackColor: AppColors.mist,
      ),
    );
  }

  static TextTheme _textTheme(Color color) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w300,
        fontSize: 34,
        height: 1.2,
        color: color,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        fontSize: 26,
        height: 1.3,
        color: color,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w900,
        fontSize: 20,
        height: 1.35,
        color: color,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
        fontSize: 17,
        height: 1.4,
        color: color,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.55,
        color: color,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.5,
        color: color,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.45,
        color: color.withValues(alpha: 0.7),
      ),
      labelLarge: TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: color,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
        fontSize: 11,
        letterSpacing: 0.6,
        color: color.withValues(alpha: 0.72),
      ),
    );
  }
}
