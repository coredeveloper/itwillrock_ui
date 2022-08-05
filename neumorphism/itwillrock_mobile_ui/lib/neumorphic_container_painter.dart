import 'package:flutter/widgets.dart';

import 'neumorphic_accent_painter.dart';
import 'neumorphic_inner_shadow_painter.dart';
import 'neumorphic_shadow_painter.dart';
import 'neumorphic_surface_painter.dart';

class NeumorphicContainerPainter extends CustomPainter {
  late NeumorphicShadowPainter shadowPainter;
  late NeumorphicInnerShadowPainter innerShadowPainter;
  late NeumorphicSurfacePainter surfacePainter;
  NeumorphicAccentPainter? accentPainter;
  NeumorphicContainerPainter(
      {Gradient? gradient,
      List<Shadow> shadows = const <Shadow>[],
      List<Shadow> innerShadows = const <Shadow>[],
      ShapeBorder shape = const ContinuousRectangleBorder(),
      double blur = 0,
      double borderBlur = 0,
      Color color = const Color.fromARGB(0, 0, 0, 0),
      double strokeWidth = 0,
      Gradient? borderGradient,
      Color? accentColor,
      double accentIntensity = 0,
      Alignment? accentAlignment}) {
    shadowPainter = NeumorphicShadowPainter(
        shadows: shadows, shape: shape, strokeWidth: strokeWidth);
    surfacePainter = NeumorphicSurfacePainter(
        shape: shape,
        gradient: gradient,
        color: color,
        borderGradient: borderGradient,
        blur: blur,
        borderBlur: borderBlur,
        strokeWidth: strokeWidth);
    if (accentColor != null && accentAlignment != null && accentIntensity > 0) {
      accentPainter = NeumorphicAccentPainter(
          alignment: accentAlignment,
          value: accentIntensity,
          color: accentColor,
          shape: shape,
          strokeWidth: strokeWidth);
    }
    innerShadowPainter = NeumorphicInnerShadowPainter(
        innerShadows: innerShadows, shape: shape, strokeWidth: strokeWidth);
  }

  @override
  void paint(Canvas canvas, Size size) {
    shadowPainter.calculateShape(const Offset(0, 0), size);
    surfacePainter.calculateShape(const Offset(0, 0), size);
    innerShadowPainter.calculateShape(const Offset(0, 0), size);
    shadowPainter.paintShadow(canvas);
    surfacePainter.paintSurface(canvas);
    innerShadowPainter.paintShadow(canvas);
    if (accentPainter != null) {
      accentPainter!.calculateShape(const Offset(0, 0), size);
      accentPainter!.paintAccent(canvas);
    }
  }

  @override
  bool shouldRepaint(NeumorphicContainerPainter oldDelegate) {
    return false;
  }
}
