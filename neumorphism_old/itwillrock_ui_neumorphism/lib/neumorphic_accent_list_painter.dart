import 'package:flutter/widgets.dart';
import 'neumorphic_shadow_painter.dart';
import 'neumorphic_surface_painter.dart';

class NeumorphicAccentListPainter extends CustomPainter {
  NeumorphicShadowPainter shadowPainter;
  NeumorphicSurfacePainter surfacePainter;
  Size indicatorSize;
  Offset offset;
  NeumorphicAccentListPainter({
    List<Shadow> shadows,
    this.offset = const Offset(0, 0),
    this.indicatorSize = const Size(8, 32),
    double blur,
    double strokeWidth = 0,
    Color color,
  }) {
    this.shadowPainter =
        new NeumorphicShadowPainter(shadows: shadows, strokeWidth: strokeWidth);

    this.surfacePainter = new NeumorphicSurfacePainter(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: color,
        blur: blur,
        borderBlur: blur,
        strokeWidth: strokeWidth);
  }

  @override
  void paint(Canvas canvas, Size size) {
    shadowPainter.calculateShape(offset, indicatorSize);
    shadowPainter.paintShadow(canvas);
    surfacePainter.calculateShape(offset, indicatorSize);
    surfacePainter.paintSurface(canvas);
  }

  @override
  bool shouldRepaint(NeumorphicAccentListPainter oldDelegate) {
    if (offset.dy == oldDelegate.offset.dy) {
      return false;
    }
    return true;
  }
}
