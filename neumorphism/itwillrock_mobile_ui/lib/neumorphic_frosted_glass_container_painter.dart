import 'package:flutter/widgets.dart';

import 'neumorphic_accent_painter.dart';
import 'neumorphic_frosted_glass_surface_painter.dart';

class NeumorphicFrostedGlassContainerPainter extends CustomPainter {
  late NeumorphicFrostGlassSurfacePainter surfacePainter;
  NeumorphicAccentPainter? accentPainter;
  NeumorphicFrostedGlassContainerPainter(
      {ShapeBorder shape = const ContinuousRectangleBorder(),
      Color? accentColor,
      double accentIntensity = 0,
      Alignment? accentAlignment}) {
    surfacePainter = NeumorphicFrostGlassSurfacePainter(shape: shape);
    if (accentColor != null && accentAlignment != null && accentIntensity > 0) {
      accentPainter = NeumorphicAccentPainter(
          alignment: accentAlignment,
          value: accentIntensity,
          color: accentColor,
          shape: shape,
          strokeWidth: 0);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    surfacePainter.calculateShape(const Offset(0, 0), size);
    surfacePainter.paintSurface(canvas);
    if (accentPainter != null) {
      accentPainter!.calculateShape(const Offset(0, 0), size);
      accentPainter!.paintAccent(canvas);
    }
  }

  @override
  bool shouldRepaint(NeumorphicFrostedGlassContainerPainter oldDelegate) {
    return false;
  }
}
