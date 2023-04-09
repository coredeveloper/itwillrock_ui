import 'package:flutter/painting.dart';

const transparentColor = Color.fromARGB(0, 0, 0, 0);

const mainColorLightMode = Color(0xFFE3E6EC);
const mainColorDarkMode = Color(0xFF2A2D32);

const lightColorLightMode = Color(0xFFFFFFFF);
const darkColorLightMode = Color(0xFFD1D9E6);

const lightColorDarkMode = Color(0xFF30343A);
const darkColorDarkMode = Color(0xFF24262B);

const textColorLightMode = Color(0xFF000000);
const textColorDarkMode = Color(0xFFFFFFFF);

class AppColors {
  static Color mainColor = mainColorLightMode;
  static Color accentColor = const Color(0xFFFC5C7D);
  static Color altAccentColor = const Color(0xFF6A82FB);

  static Color textColor = textColorLightMode;
  static Color altTextColor = const Color(0xFFFFFFFF);

  static Color lightShadowColor = lightColorLightMode;
  static Color darkShadowColor = darkColorLightMode;

  static Gradient get mainGradient => LinearGradient(
      stops: const [0, 1],
      begin: FractionalOffset.centerLeft,
      end: FractionalOffset.centerRight,
      colors: [
        accentColor,
        altAccentColor,
      ]);

  static Gradient get reversedGradient => LinearGradient(
      stops: const [0, 1],
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
