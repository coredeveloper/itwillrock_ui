import 'package:flutter/painting.dart';

/// Simple transperent color defentition, Yes we assume that sometimes transperent isn't fully transperent.
const transparentColor = Color.fromARGB(0, 0, 0, 0);

///The main color in Light mode
const mainColorLightMode = Color(0xFFE3E6EC);

///The main color in Dark mode
const mainColorDarkMode = Color(0xFF2A2D32);

///The light color in Light mode
const lightColorLightMode = Color(0xFFFFFFFF);

///The dark color in Light mode
const darkColorLightMode = Color(0xFFD1D9E6);

///The light color in Dark mode
const lightColorDarkMode = Color(0xFF30343A);

///The dark color in Dark mode
const darkColorDarkMode = Color(0xFF24262B);

///The text color in Light mode
const textColorLightMode = Color(0xFF000000);

///The text color in Dark mode
const textColorDarkMode = Color(0xFFFFFFFF);

///The alternative text color for non primary controls
const altTextColor = Color(0xFFFFFFFF);

///The accent color used to highlight or mark
const accentColor = Color(0xFFFC5C7D);

///The accent color used to highlight or mark non primary controls
const altAccentColor = Color(0xFF6A82FB);

///THe class for dynamicly changable colors. Like in case you switching modes. 
class AppColors {
  static Color mainColor = mainColorLightMode;
  static Color textColor = textColorLightMode;
  static Color lightShadowColor = lightColorLightMode;
  static Color darkShadowColor = darkColorLightMode;

  static Gradient get mainGradient => const LinearGradient(
      stops: [0, 1],
      begin: FractionalOffset.centerLeft,
      end: FractionalOffset.centerRight,
      colors: [
        accentColor,
        altAccentColor,
      ]);

  static Gradient get reversedGradient => const LinearGradient(
      stops: [0, 1],
      begin: FractionalOffset.centerLeft,
      end: FractionalOffset.centerRight,
      colors: [altAccentColor, accentColor]);

  static Gradient get shadowGradient => LinearGradient(
        colors: [AppColors.lightShadowColor, AppColors.darkShadowColor],
        stops: const [0, 1],
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomRight,
      );

  static List<Shadow> currentShadows(
          {double blurMultiplier = 1.0, double offsetMultiplier = 1.0}) =>
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

  static List<Shadow> currentInnerShadows(
          {double blurMultiplier = 1.0, double offsetMultiplier = 1.0}) =>
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

  static switchColorMode(bool darkMode) {
    if (darkMode) {
      mainColor = mainColorDarkMode;
      textColor = textColorDarkMode;
      lightShadowColor = lightColorDarkMode;
      darkShadowColor = darkColorDarkMode;
    } else {
      mainColor = mainColorLightMode;
      darkShadowColor = darkColorLightMode;
      lightShadowColor = lightColorLightMode;
      textColor = textColorLightMode;
    }
  }
}
