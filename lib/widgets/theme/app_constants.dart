import 'package:flutter/material.dart';

/// Design system constants for consistent spacing, sizing, and styling
class AppConstants {
  // Spacing (8px base unit)
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacing2xl = 48.0;

  // Border Radius
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusRound = 100.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;
  static const double icon2xl = 64.0;

  // Button Sizes
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightMd = 48.0;
  static const double buttonHeightLg = 56.0;

  // Elevation / Shadow Depths
  static const double elevationXs = 1.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
  static const double elevationXl = 12.0;

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration animationVerySlow = Duration(milliseconds: 800);

  // Content Padding
  static const EdgeInsets paddingXs = EdgeInsets.all(spacingSm);
  static const EdgeInsets paddingSm = EdgeInsets.all(spacingMd);
  static const EdgeInsets paddingMd = EdgeInsets.all(spacingLg);
  static const EdgeInsets paddingLg = EdgeInsets.all(spacingXl);
  static const EdgeInsets paddingSymmetricH = EdgeInsets.symmetric(horizontal: spacingMd);
  static const EdgeInsets paddingSymmetricV = EdgeInsets.symmetric(vertical: spacingMd);
  static const EdgeInsets paddingCard = EdgeInsets.all(spacingMd);

  // Standard screen padding
  static const EdgeInsets screenPadding = EdgeInsets.all(spacingLg);

  // Input Field Properties
  static const double inputFieldHeight = buttonHeightMd;
  static const double inputBorderWidth = 1.5;
  static const double inputFocusedBorderWidth = 2.0;

  // Card Properties
  static const double cardBorderRadius = radiusMd;
  static const double cardElevation = elevationSm;

  // Minimum touch target size (Material Design 3: 48x48)
  static const double minTouchTarget = 48.0;

  // Gradient angle for backgrounds
  static const double gradientAngle = 0.0;
}

/// Typography scale for consistent font sizing
class AppTypography {
  // Display
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.25,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  // Headline
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.15,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.4,
  );

  // Label
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.5,
  );
}
