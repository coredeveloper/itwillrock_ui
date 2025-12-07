import 'package:flutter/painting.dart';

/// Simple transparent color definition
const transparentColor = Color.fromARGB(0, 0, 0, 0);

/// Default background color for light mode
const defaultBackgroundLight = Color(0xFFE3E6EC);

/// Default background color for dark mode
const defaultBackgroundDark = Color(0xFF2A2D32);

/// Default accent color
const defaultAccentColor = Color(0xFFFC5C7D);

/// Default alternative accent color
const defaultAltAccentColor = Color(0xFF6A82FB);

/// Alternative text color for use on accent/gradient backgrounds
const altTextColor = Color(0xFFFFFFFF);

/// Dynamic color configuration for neumorphic design.
///
/// Colors are derived from a single background color:
/// - [mainColor]: The background color (user-provided or default)
/// - [lightShadowColor]: Computed lighter shade for highlights
/// - [darkShadowColor]: Computed darker shade for shadows
/// - [textColor]: Computed contrasting color for readability
/// - [accentColor]: User-provided accent color for highlights
///
/// Example usage:
/// ```dart
/// // Configure with custom background and accent
/// AppColors.configure(
///   backgroundColor: Color(0xFFE0E5EC),
///   accentColor: Colors.pink,
/// );
///
/// // Or use dark mode preset
/// AppColors.switchColorMode(darkMode: true);
/// ```
class AppColors {
  // Private backing field for background color
  static Color _backgroundColor = defaultBackgroundLight;

  /// The accent color used for highlights and active states
  static Color accentColor = defaultAccentColor;

  /// The alternative accent color for gradients
  static Color altAccentColor = defaultAltAccentColor;

  /// The main background color
  static Color get mainColor => _backgroundColor;

  /// Text color - automatically computed for contrast against background
  static Color get textColor => _computeTextColor(_backgroundColor);

  /// Light shadow color - computed lighter shade of background
  static Color get lightShadowColor => _computeLightShadow(_backgroundColor);

  /// Dark shadow color - computed darker shade of background
  static Color get darkShadowColor => _computeDarkShadow(_backgroundColor);

  /// Configure colors from a background color.
  ///
  /// Shadow colors and text color are automatically derived.
  /// Optionally provide accent colors for customization.
  static void configure({
    required Color backgroundColor,
    Color? accent,
    Color? altAccent,
  }) {
    _backgroundColor = backgroundColor;
    if (accent != null) accentColor = accent;
    if (altAccent != null) altAccentColor = altAccent;
  }

  /// Switches between light and dark color mode using default presets.
  ///
  /// For custom colors, use [configure] instead.
  static void switchColorMode(bool darkMode) {
    _backgroundColor = darkMode ? defaultBackgroundDark : defaultBackgroundLight;
  }

  /// Gradient from accent to alt accent color
  static Gradient get mainGradient => LinearGradient(
        stops: const [0, 1],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
        colors: [accentColor, altAccentColor],
      );

  /// Gradient from alt accent to accent color
  static Gradient get reversedGradient => LinearGradient(
        stops: const [0, 1],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
        colors: [altAccentColor, accentColor],
      );

  /// Gradient for shadow effects (light to dark)
  static Gradient get shadowGradient => LinearGradient(
        colors: [lightShadowColor, darkShadowColor],
        stops: const [0, 1],
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomRight,
      );

  /// Reversed gradient for shadow effects (dark to light)
  static Gradient get reversedShadowGradient => LinearGradient(
        colors: [darkShadowColor, lightShadowColor],
        stops: const [0, 1],
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomRight,
      );

  /// Generates outer shadows with configurable intensity
  static List<Shadow> currentShadows({
    double blurMultiplier = 1.0,
    double offsetMultiplier = 1.0,
  }) =>
      [
        Shadow(
          color: lightShadowColor,
          blurRadius: 20 * blurMultiplier,
          offset: Offset(-18 * offsetMultiplier, -18 * offsetMultiplier),
        ),
        Shadow(
          color: darkShadowColor,
          blurRadius: 20 * blurMultiplier,
          offset: Offset(18 * offsetMultiplier, 18 * offsetMultiplier),
        ),
      ];

  /// Generates inner shadows with configurable intensity
  static List<Shadow> currentInnerShadows({
    double blurMultiplier = 1.0,
    double offsetMultiplier = 1.0,
  }) =>
      [
        Shadow(
          color: lightShadowColor,
          blurRadius: 30 * blurMultiplier,
          offset: Offset(-18 * offsetMultiplier, -18 * offsetMultiplier),
        ),
        Shadow(
          color: darkShadowColor,
          blurRadius: 30 * blurMultiplier,
          offset: Offset(18 * offsetMultiplier, 18 * offsetMultiplier),
        ),
      ];

  // --- Private helper methods ---

  /// Computes contrasting text color based on background luminance
  static Color _computeTextColor(Color background) {
    return background.computeLuminance() > 0.5
        ? const Color(0xFF000000)
        : const Color(0xFFFFFFFF);
  }

  /// Computes light shadow color (lighter than background)
  static Color _computeLightShadow(Color background) {
    final hsl = HSLColor.fromColor(background);
    final isDark = hsl.lightness < 0.5;

    if (isDark) {
      // For dark backgrounds, light shadow is even darker (appears as absence of light)
      return hsl
          .withLightness((hsl.lightness - 0.05).clamp(0.0, 1.0))
          .toColor();
    } else {
      // For light backgrounds, light shadow is brighter
      return hsl
          .withLightness((hsl.lightness + 0.08).clamp(0.0, 1.0))
          .toColor();
    }
  }

  /// Computes dark shadow color (darker than background)
  static Color _computeDarkShadow(Color background) {
    final hsl = HSLColor.fromColor(background);
    final isDark = hsl.lightness < 0.5;

    if (isDark) {
      // For dark backgrounds, reduce lightness more subtly
      return hsl
          .withLightness((hsl.lightness - 0.03).clamp(0.0, 1.0))
          .toColor();
    } else {
      // For light backgrounds, darken noticeably
      return hsl
          .withLightness((hsl.lightness - 0.08).clamp(0.0, 1.0))
          .toColor();
    }
  }
}
