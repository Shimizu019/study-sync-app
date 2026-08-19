import 'package:flutter/material.dart';

/// Comprehensive color palette for Study Sync
/// Follows WCAG AA contrast standards for accessibility
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF6366F1);
  static const Color primaryDark = Color(0xFF3730A3);
  static const Color primaryBg = Color(0xFFEEF2FF);

  // Soft design palette from mockup
  static const Color softBg = Color(0xFFF8FAFC);
  static const Color softSurface = Color(0xFFF1F5F9);
  static const Color softCard = Color(0xFFFFFFFF);
  static const Color softShadow = Color(0x140F172A);

  // Accent Colors
  static const Color accent = Color(0xFF2563EB);
  static const Color accentDark = Color(0xFF1D4ED8);

  // Status Colors
  static const Color success = Color(0xFF16A34A);
  static const Color successLight = Color(0xFFBBF7D0);
  static const Color successBg = Color(0xFFF0FDF4);

  static const Color warning = Color(0xFFD97706);
  static const Color warningLight = Color(0xFFFDE68A);
  static const Color warningBg = Color(0xFFFFFBEB);

  static const Color error = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFFECACA);
  static const Color errorBg = Color(0xFFFEF2F2);

  static const Color info = Color(0xFF2563EB);
  static const Color infoLight = Color(0xFFBFDBFE);
  static const Color infoBg = Color(0xFFEFF6FF);

  // Neutral Colors - Light Theme
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightCardBg = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightDivider = Color(0xFFE5E7EB);

  // Neutral Colors - Dark Theme
  static const Color darkBg = Color(0xFF0F172A);
  static const Color darkCardBg = Color(0xFF1E293B);
  static const Color darkText = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkBorder = Color(0xFF334155);
  static const Color darkDivider = Color(0xFF273449);

  // Subject Colors - used as tags
  static const List<Color> subjectColors = [
    Color(0xFF5B4FE9), // Purple (primary)
    Color(0xFFFF6B6B), // Red
    Color(0xFF4ECDC4), // Teal
    Color(0xFFFFD93D), // Yellow
    Color(0xFF6BCB77), // Green
    Color(0xFF4D96FF), // Blue
    Color(0xFFFF8C42), // Orange
    Color(0xFFB19CD9), // Lavender
  ];

  // Gamification Colors
  static const Color streakFire = Color(0xFFFF6B35);
  static const Color levelUp = Color(0xFFFFD700);
  static const Color pointsGold = Color(0xFFFFA500);

  // Utility method to get subject color with accessibility
  static Color getSubjectColor(int index) {
    return subjectColors[index % subjectColors.length];
  }

  // Get contrasting text color for a background
  static Color getContrastingTextColor(Color backgroundColor) {
    // Calculate luminance
        final luminance = (0.299 * backgroundColor.r * 255 +
          0.587 * backgroundColor.g * 255 +
          0.114 * backgroundColor.b * 255) /
        255;
    return luminance > 0.5 ? darkText : lightText;
  }

  // Get color based on theme
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkText
        : lightText;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCardBg
        : lightCardBg;
  }

  static Color getBgColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBg
        : lightBg;
  }
}
