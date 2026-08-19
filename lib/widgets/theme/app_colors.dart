import 'package:flutter/material.dart';

/// Comprehensive color palette for Study Sync
/// Follows WCAG AA contrast standards for accessibility
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6C52E6);
  static const Color primaryLight = Color(0xFF8C74F7);
  static const Color primaryDark = Color(0xFF5038C8);
  static const Color primaryBg = Color(0xFFF4F1FF);

  // Soft design palette from mockup
  static const Color softBg = Color(0xFFF5F1FF);
  static const Color softSurface = Color(0xFFF8F6FF);
  static const Color softCard = Color(0xFFFFFFFF);
  static const Color softShadow = Color(0x1A5E4BDA);

  // Accent Colors
  static const Color accent = Color(0xFF00D4FF);
  static const Color accentDark = Color(0xFF00A8D9);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFA7F3D0);
  static const Color successBg = Color(0xFFF0FDF4);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFCD34D);
  static const Color warningBg = Color(0xFFFEF3C7);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorBg = Color(0xFFFEF2F2);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoBg = Color(0xFFF0F9FF);

  // Neutral Colors - Light Theme
  static const Color lightBg = Color(0xFFF9F8FF);
  static const Color lightCardBg = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightBorder = Color(0xFFE8E6F0);
  static const Color lightDivider = Color(0xFFF0EFFF);

  // Neutral Colors - Dark Theme
  static const Color darkBg = Color(0xFF0F0F1E);
  static const Color darkCardBg = Color(0xFF1A1A2E);
  static const Color darkText = Color(0xFFFAFAFA);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkBorder = Color(0xFF2D2D4A);
  static const Color darkDivider = Color(0xFF252540);

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
    final luminance = (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
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
