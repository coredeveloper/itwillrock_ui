import "package:flutter/material.dart";
import "package:itwillrock_neumorphism/constants/colors.dart";

/// A utility class for managing app themes.
///
/// Provides methods to create light and dark themes with the appropriate color schemes.
class MaterialTheme {
  /// Creates a light color scheme using AppColors values.
  static ColorScheme lightScheme() {
    // Initialize AppColors for light mode if needed
    AppColors.switchColorMode(false);

    return ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.accentColor,
      onPrimary: AppColors.altAccentColor,
      primaryContainer: AppColors.lightShadowColor,
      onPrimaryContainer: AppColors.textColor,
      secondary: AppColors.accentColor,
      onSecondary: AppColors.altAccentColor,
      secondaryContainer: AppColors.lightShadowColor,
      onSecondaryContainer: AppColors.textColor,
      surface: AppColors.mainColor,
      onSurface: AppColors.textColor,
      error: const Color(0xFFBA1A1A),
      onError: AppColors.altAccentColor,
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF410002),
    );
  }

  /// Creates a dark color scheme using AppColors values.
  static ColorScheme darkScheme() {
    // Initialize AppColors for dark mode
    AppColors.switchColorMode(true);

    return ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.accentColor,
      onPrimary: AppColors.darkShadowColor,
      primaryContainer: AppColors.darkShadowColor,
      onPrimaryContainer: AppColors.lightShadowColor,
      secondary: AppColors.altAccentColor,
      onSecondary: AppColors.darkShadowColor,
      secondaryContainer: AppColors.darkShadowColor,
      onSecondaryContainer: AppColors.lightShadowColor,
      surface: AppColors.mainColor,
      onSurface: AppColors.textColor,
      error: const Color(0xFFFFB4AB),
      onError: const Color(0xFF690005),
      errorContainer: const Color(0xFF93000A),
      onErrorContainer: const Color(0xFFFFDAD6),
    );
  }

  /// Creates a light theme using AppColors light mode values.
  static ThemeData light() {
    return theme(lightScheme());
  }

  /// Creates a dark theme using AppColors dark mode values.
  static ThemeData dark() {
    return theme(darkScheme());
  }

  /// Creates a ThemeData object from the specified color scheme.
  static ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        fontFamily: 'Manrope',
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: colorScheme.onSurface),
          bodyMedium: TextStyle(color: colorScheme.onSurface),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
        ),
        iconTheme: IconThemeData(
          color: colorScheme.onSurface,
        ),
      );

  /// Updates the theme based on dark mode setting and returns appropriate ThemeData.
  static ThemeData updateTheme(bool isDarkMode) {
    AppColors.switchColorMode(isDarkMode);
    return isDarkMode ? dark() : light();
  }
}
