import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_constants.dart';

/// Comprehensive theme configuration for Study Sync
/// Includes light and dark themes with Material 3 design
class AppTheme {
  // Private constructor
  AppTheme._();

  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.lightCardBg,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.softBg,
    
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.softBg,
      foregroundColor: AppColors.lightText,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.headlineMedium,
    ),

    // Text Themes
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: AppColors.lightText),
      displayMedium: AppTypography.displayMedium.copyWith(color: AppColors.lightText),
      displaySmall: AppTypography.displaySmall.copyWith(color: AppColors.lightText),
      headlineLarge: AppTypography.headlineLarge.copyWith(color: AppColors.lightText),
      headlineMedium: AppTypography.headlineMedium.copyWith(color: AppColors.lightText),
      headlineSmall: AppTypography.headlineSmall.copyWith(color: AppColors.lightText),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColors.lightText),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: AppColors.lightText),
      bodySmall: AppTypography.bodySmall.copyWith(color: AppColors.lightTextSecondary),
      labelLarge: AppTypography.labelLarge.copyWith(color: AppColors.lightText),
      labelMedium: AppTypography.labelMedium.copyWith(color: AppColors.lightTextSecondary),
      labelSmall: AppTypography.labelSmall.copyWith(color: AppColors.lightTextSecondary),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.softSurface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingMd,
      ),
      labelStyle: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
      hintStyle: TextStyle(
        color: AppColors.lightTextSecondary,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: AppColors.primary,
      suffixIconColor: AppColors.primary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: const BorderSide(
          color: AppColors.lightBorder,
          width: AppConstants.inputBorderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: const BorderSide(
          color: AppColors.lightBorder,
          width: AppConstants.inputBorderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: AppConstants.inputFocusedBorderWidth,
        ),
      ),
      errorStyle: const TextStyle(color: Color(0xFF991B1B), fontWeight: FontWeight.w600),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: AppConstants.inputBorderWidth,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: AppConstants.inputFocusedBorderWidth,
        ),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: AppConstants.elevationMd,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLg,
          vertical: AppConstants.spacingMd,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        textStyle: AppTypography.labelLarge.copyWith(color: Colors.white),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.lightCardBg,
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      margin: EdgeInsets.zero,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightCardBg,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightTextSecondary,
      elevation: AppConstants.elevationMd,
      type: BottomNavigationBarType.fixed,
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: AppConstants.elevationLg,
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.lightBorder,
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.lightDivider,
      thickness: 1,
      space: AppConstants.spacingMd,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightBorder,
      labelStyle: AppTypography.labelMedium.copyWith(color: AppColors.lightText),
      secondaryLabelStyle: AppTypography.labelMedium.copyWith(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingSm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusRound),
      ),
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkCardBg,
      contentTextStyle: AppTypography.bodyMedium.copyWith(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: AppConstants.elevationLg,
    ),
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      secondary: AppColors.accent,
      surface: AppColors.darkCardBg,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.darkBg,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkCardBg,
      foregroundColor: AppColors.darkText,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.headlineMedium,
    ),

    // Text Themes
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: AppColors.darkText),
      displayMedium: AppTypography.displayMedium.copyWith(color: AppColors.darkText),
      displaySmall: AppTypography.displaySmall.copyWith(color: AppColors.darkText),
      headlineLarge: AppTypography.headlineLarge.copyWith(color: AppColors.darkText),
      headlineMedium: AppTypography.headlineMedium.copyWith(color: AppColors.darkText),
      headlineSmall: AppTypography.headlineSmall.copyWith(color: AppColors.darkText),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColors.darkText),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: AppColors.darkText),
      bodySmall: AppTypography.bodySmall.copyWith(color: AppColors.darkTextSecondary),
      labelLarge: AppTypography.labelLarge.copyWith(color: AppColors.darkText),
      labelMedium: AppTypography.labelMedium.copyWith(color: AppColors.darkTextSecondary),
      labelSmall: AppTypography.labelSmall.copyWith(color: AppColors.darkTextSecondary),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF273449),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingMd,
      ),
      labelStyle: const TextStyle(
        color: AppColors.primaryLight,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: const TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.w600),
      hintStyle: TextStyle(
        color: AppColors.darkTextSecondary,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: AppColors.primaryLight,
      suffixIconColor: AppColors.primaryLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: const BorderSide(
          color: AppColors.darkBorder,
          width: AppConstants.inputBorderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: const BorderSide(
          color: AppColors.darkBorder,
          width: AppConstants.inputBorderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: const BorderSide(
          color: AppColors.primaryLight,
          width: AppConstants.inputFocusedBorderWidth,
        ),
      ),
      errorStyle: const TextStyle(color: Color(0xFFFCA5A5), fontWeight: FontWeight.w600),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: AppConstants.inputBorderWidth,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: AppConstants.inputFocusedBorderWidth,
        ),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: AppConstants.elevationMd,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLg,
          vertical: AppConstants.spacingMd,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        textStyle: AppTypography.labelLarge.copyWith(color: Colors.white),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        side: const BorderSide(color: AppColors.primaryLight, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.darkCardBg,
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      margin: EdgeInsets.zero,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkCardBg,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.darkTextSecondary,
      elevation: AppConstants.elevationMd,
      type: BottomNavigationBarType.fixed,
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: AppConstants.elevationLg,
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryLight,
      linearTrackColor: AppColors.darkBorder,
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.darkDivider,
      thickness: 1,
      space: AppConstants.spacingMd,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkBorder,
      labelStyle: AppTypography.labelMedium.copyWith(color: AppColors.darkText),
      secondaryLabelStyle: AppTypography.labelMedium.copyWith(color: AppColors.primaryLight),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingSm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusRound),
      ),
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkCardBg,
      contentTextStyle: AppTypography.bodyMedium.copyWith(color: AppColors.darkText),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: AppConstants.elevationLg,
    ),
  );
}
