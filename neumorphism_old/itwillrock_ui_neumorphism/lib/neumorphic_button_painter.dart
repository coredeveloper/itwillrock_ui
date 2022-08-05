import 'package:flutter/widgets.dart';

import 'neumorphic_accent_painter.dart';
import 'neumorphic_shadow_painter.dart';
import 'neumorphic_surface_painter.dart';

class NeumorphicButtonPainter extends CustomPainter {
  NeumorphicShadowPainter shadowPainter;
  NeumorphicSurfacePainter surfacePainter;
  NeumorphicAccentPainter accentPainter;

  final double animationValue;

  NeumorphicButtonPainter(
      {Gradient gradient,
      List<Shadow> shadows,
      ShapeBorder shape,
      double blur,
      double borderBlur,
      Color color,
      double strokeWidth,
      Gradient borderGradient,
      Color accentColor,
      double accentIntensity,
      Alignment accentAlignment,
      @required this.animationValue}) {
    this.shadowPainter = new NeumorphicShadowPainter(
        shadows: shadows, shape: shape, strokeWidth: strokeWidth);
    if (accentColor != null &&
        accentAlignment != null &&
        accentIntensity != null &&
        accentIntensity > 0) {
      this.accentPainter = new NeumorphicAccentPainter(
          alignment: accentAlignment,
          value: accentIntensity,
          color: accentColor,
          shape: shape,
          strokeWidth: strokeWidth);
    }

    this.surfacePainter = new NeumorphicSurfacePainter(
        shape: shape,
        gradient: gradient,
        color: color,
        borderGradient: borderGradient,
        blur: blur,
        borderBlur: borderBlur,
        strokeWidth: strokeWidth);
  }

  @override
  void paint(Canvas canvas, Size size) {
    shadowPainter.calculateShape(Offset(0, 0), size);
    surfacePainter.calculateShape(Offset(0, 0), size);
    shadowPainter.paintShadow(canvas);
    surfacePainter.paintSurface(canvas);
    if (accentPainter != null) {
      accentPainter.calculateShape(Offset(0, 0), size);
      accentPainter.paintAccent(canvas);
    }
  }

  @override
  bool shouldRepaint(NeumorphicButtonPainter oldDelegate) {
    if (animationValue != oldDelegate.animationValue) {
      return true;
    }
    return false;
  }
}
