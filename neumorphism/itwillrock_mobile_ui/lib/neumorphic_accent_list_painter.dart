import 'package:flutter/widgets.dart';
import 'neumorphic_shadow_painter.dart';
import 'neumorphic_surface_painter.dart';

class NeumorphicAccentListPainter extends CustomPainter {
  late NeumorphicShadowPainter shadowPainter;
  late NeumorphicSurfacePainter surfacePainter;
  Size indicatorSize;
  Offset offset;
  NeumorphicAccentListPainter(
      {List<Shadow> shadows = const <Shadow>[],
      this.offset = const Offset(0, 0),
      this.indicatorSize = const Size(8, 32),
      double blur = 0,
      double strokeWidth = 0,
      Color color = const Color.fromARGB(0, 0, 0, 0),
      Key? key}) {
    shadowPainter =
        NeumorphicShadowPainter(shadows: shadows, strokeWidth: strokeWidth);

    surfacePainter = NeumorphicSurfacePainter(
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
