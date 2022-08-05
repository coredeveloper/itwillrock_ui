import 'package:flutter/widgets.dart';
import '../neumorphic_shape_painter.dart';

class MenuIconPainter extends NeumorphicShapePainter {
  final Color color;
  final Paint paintObject = Paint();
  final double animationStep;
  final maxRotationRadians = 0.79;
  MenuIconPainter(
      {required this.color, required strokeWidth, required this.animationStep})
      : super(strokeWidth: strokeWidth) {
    paintObject.color = color;
  }

  void paintIcon(Canvas canvas) {
    var step = innerRect.height / 3;

    var topLine = RRect.fromLTRBR(innerRect.left, innerRect.top,
        innerRect.right, innerRect.top + step, Radius.circular(step / 2));

    var bottomLine = RRect.fromLTRBR(innerRect.left, innerRect.top + step * 2,
        innerRect.right, innerRect.bottom, const Radius.circular(4));
    var topIconPath = Path()..addRRect(topLine);
    var bottomIconPath = Path()..addRRect(bottomLine);

    canvas.translate(-5, outerRect.height / 2);
    canvas.rotate(-maxRotationRadians * animationStep);
    canvas.drawPath(topIconPath, paintObject);

    canvas.rotate(maxRotationRadians * 2 * animationStep);
    canvas.translate(0, -outerRect.height);
    canvas.drawPath(bottomIconPath, paintObject);
  }
}
