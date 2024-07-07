import 'package:flutter/widgets.dart';
import 'neumorphic_surface_painter.dart';

class NeumorphicIndicatorListPainter extends CustomPainter {
  late NeumorphicSurfacePainter surfacePainter;
  Size indicatorSize;
  Offset offset;
  NeumorphicIndicatorListPainter({
    List<Shadow> shadows = const <Shadow>[],
    this.offset = const Offset(0, 0),
    this.indicatorSize = const Size(8, 32),
    double blur = 0,
    double strokeWidth = 0,
    Color? color,
    Gradient? gradient,
  }) {
    surfacePainter = NeumorphicSurfacePainter(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        gradient: gradient,
        blur: blur,
        color: color,
        borderBlur: blur,
        strokeWidth: strokeWidth);
  }

  @override
  void paint(Canvas canvas, Size size) {
    surfacePainter.calculateShape(offset, indicatorSize);
    surfacePainter.paintSurface(canvas);
  }

  @override
  bool shouldRepaint(NeumorphicIndicatorListPainter oldDelegate) {
    if (offset.dx == oldDelegate.offset.dx) {
      return false;
    }
    return true;
  }
}
