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

/// Flexible color configuration for neumorphic design.
///
/// All colors can be set individually or auto-derived from background.
///
/// **Quick setup:**
/// ```dart
/// // Set background, rest auto-derives
/// AppColors.mainColor = Color(0xFFE0E5EC);
///
/// // Or configure multiple at once
/// AppColors.configure(
///   backgroundColor: myBgColor,
///   accent: Colors.pink,
/// );
///
/// // Or use dark/light mode preset
/// AppColors.switchColorMode(true);
/// ```
///
/// **Full control:**
/// ```dart
/// AppColors.mainColor = myBackground;
/// AppColors.textColor = myTextColor;
/// AppColors.lightShadowColor = myLightShadow;
/// AppColors.darkShadowColor = myDarkShadow;
/// AppColors.accentColor = myAccent;
/// ```
///
/// **Reset to defaults:**
/// ```dart
/// AppColors.reset(); // clears all overrides
/// ```
class AppColors {
  // --- Private backing fields ---
  static Color _backgroundColor = defaultBackgroundLight;
  static Color? _textColorOverride;
  static Color? _lightShadowOverride;
  static Color? _darkShadowOverride;
  static Color? _accentOverride;
  static Color? _altAccentOverride;

  // --- Main background color ---

  /// The main background color.
  /// Setting this recalculates shadow/text defaults (unless overridden).
  // ignore: unnecessary_getters_setters
  static Color get mainColor => _backgroundColor;
  // ignore: unnecessary_getters_setters
  static set mainColor(Color value) => _backgroundColor = value;

  // --- Text color ---

  /// Text color. Auto-computed for contrast if not set.
  static Color get textColor =>
      _textColorOverride ?? _computeTextColor(_backgroundColor);

  /// Set custom text color, or null to use auto-computed.
  static set textColor(Color? value) => _textColorOverride = value;

  // --- Shadow colors ---

  /// Light shadow color. Auto-computed if not set.
  static Color get lightShadowColor =>
      _lightShadowOverride ?? _computeLightShadow(_backgroundColor);

  /// Set custom light shadow, or null to use auto-computed.
  static set lightShadowColor(Color? value) => _lightShadowOverride = value;

  /// Dark shadow color. Auto-computed if not set.
  static Color get darkShadowColor =>
      _darkShadowOverride ?? _computeDarkShadow(_backgroundColor);

  /// Set custom dark shadow, or null to use auto-computed.
  static set darkShadowColor(Color? value) => _darkShadowOverride = value;

  // --- Accent colors ---

  /// Primary accent color for highlights.
  static Color get accentColor => _accentOverride ?? defaultAccentColor;

  /// Set custom accent color, or null for default.
  static set accentColor(Color? value) => _accentOverride = value;

  /// Secondary accent color for gradients.
  static Color get altAccentColor =>
      _altAccentOverride ?? defaultAltAccentColor;

  /// Set custom alt accent color, or null for default.
  static set altAccentColor(Color? value) => _altAccentOverride = value;

  // --- Configuration methods ---

  /// Configure multiple colors at once.
  ///
  /// Only provided colors are set; others remain unchanged.
  /// Shadow colors auto-derive from background unless explicitly set.
  static void configure({
    Color? backgroundColor,
    Color? text,
    Color? lightShadow,
    Color? darkShadow,
    Color? accent,
    Color? altAccent,
  }) {
    if (backgroundColor != null) _backgroundColor = backgroundColor;
    if (text != null) _textColorOverride = text;
    if (lightShadow != null) _lightShadowOverride = lightShadow;
    if (darkShadow != null) _darkShadowOverride = darkShadow;
    if (accent != null) _accentOverride = accent;
    if (altAccent != null) _altAccentOverride = altAccent;
  }

  /// Switches to light or dark mode preset.
  ///
  /// Clears all overrides and uses default colors for the mode.
  static void switchColorMode(bool darkMode) {
    reset();
    _backgroundColor =
        darkMode ? defaultBackgroundDark : defaultBackgroundLight;
  }

  /// Resets all colors to defaults.
  ///
  /// Background returns to light mode, all overrides cleared.
  static void reset() {
    _backgroundColor = defaultBackgroundLight;
    _textColorOverride = null;
    _lightShadowOverride = null;
    _darkShadowOverride = null;
    _accentOverride = null;
    _altAccentOverride = null;
  }

  // --- Gradients ---

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

  // --- Shadow lists ---

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

  // --- Private computation methods ---

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
      // For dark backgrounds, light shadow is even darker
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
      // For dark backgrounds, reduce lightness subtly
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
