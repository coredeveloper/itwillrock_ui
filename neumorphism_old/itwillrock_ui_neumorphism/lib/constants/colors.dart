import 'package:flutter/painting.dart';

const mainColorLightMode = const Color(0xFFE3E6EC);
const mainColorDarkMode = const Color(0xFF2A2D32);

const lightColorLightMode = const Color(0xFFFFFFFF);
const darkColorLightMode = const Color(0xFFD1D9E6);

const lightColorDarkMode = const Color(0xFF30343A);
const darkColorDarkMode = const Color(0xFF24262B);

const textColorLightMode = const Color(0xFF000000);
const textColorDarkMode = const Color(0xFFFFFFFF);

class AppColors {
  static Color mainColor = mainColorLightMode;
  static Color accentColor = Color(0xFFFC5C7D);
  static Color altAccentColor = Color(0xFF6A82FB);

  static Color textColor = textColorLightMode;
  static Color altTextColor = const Color(0xFFFFFFFF);

  static Color lightShadowColor = lightColorLightMode;
  static Color darkShadowColor = darkColorLightMode;

  static Gradient get mainGradient => LinearGradient(
      stops: [0, 1],
      begin: FractionalOffset.centerLeft,
      end: FractionalOffset.centerRight,
      colors: [
        accentColor,
        altAccentColor,
      ]);

  static Gradient get reversedGradient => LinearGradient(
      stops: [0, 1],
      begin: FractionalOffset.centerLeft,
      end: FractionalOffset.centerRight,
      colors: [altAccentColor, accentColor]);

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
