import 'package:flutter/widgets.dart';
import 'neumorphic_surface_painter.dart';

/// A custom painter that draws a list of neumorphic indicators.
///
/// This painter is used to create a neumorphic effect for a list of indicators,
/// giving them a soft, embossed look. It can be used in various UI components
/// where a neumorphic design is desired.
///
/// To use this painter, create an instance of it and pass it to a `CustomPaint`
/// widget.
///
/// Example:
/// ```dart
/// CustomPaint(
///   painter: NeumorphicIndicatorListPainter(),
///   child: Container(),
/// )
/// ```
///
/// See also:
/// - [CustomPainter], which is the base class for creating custom painters.
/// - [CustomPaint], which is a widget that uses a custom painter to paint its
///   child.
class NeumorphicIndicatorListPainter extends CustomPainter {
  /// A painter that is used to draw the surface of a Neumorphic indicator.
  late NeumorphicSurfacePainter surfacePainter;

  /// The size of the indicator.
  Size indicatorSize;

  /// The offset of the indicator.
  Offset offset;

  /// Creates a [NeumorphicIndicatorListPainter].
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
