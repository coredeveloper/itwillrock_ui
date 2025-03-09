import 'package:flutter/widgets.dart';
import 'neumorphic_shape_painter.dart';

class NeumorphicAccentPainter extends NeumorphicShapePainter {
  final Color color;
  final Alignment alignment;
  double value;
  Paint paintObject = Paint();
  final double accentShift = 4;
  NeumorphicAccentPainter(
      {required this.color,
      required this.alignment,
      required this.value,
      required super.shape,
      required super.strokeWidth}) {
    if (value < 0) {
      value = 0;
    } else if (value > 1) {
      value = 1;
    }
    paintObject = Paint()
      ..color = color.withAlpha((value / 3 * 255).toInt())
      ..maskFilter =
          MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(15));
  }

  void paintAccent(Canvas canvas) {
    canvas.save();
    canvas.clipPath(outerPath);
    var virtualBoxPath = Path.combine(
        PathOperation.difference,
        outerPath,
        innerPath.shift(
            Offset(-alignment.x * accentShift, -alignment.y * accentShift)));

    canvas.drawPath(virtualBoxPath, paintObject);

    canvas.restore();
  }
}
