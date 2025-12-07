import 'package:flutter/widgets.dart';
import '../neumorphic_shape_painter.dart';

/// Painter for animated hamburger menu icon that transforms to X
class MenuIconPainter extends NeumorphicShapePainter {
  /// The color of the menu icon lines
  final Color color;

  /// Cached paint object for drawing
  final Paint paintObject = Paint();

  /// Animation progress from 0.0 (hamburger) to 1.0 (X)
  final double animationStep;

  /// Maximum rotation angle in radians for the animation
  final maxRotationRadians = 0.79;

  /// Creates a menu icon painter
  MenuIconPainter(
      {required this.color,
      required super.strokeWidth,
      required this.animationStep}) {
    paintObject.color = color;
  }

  /// Paints the menu icon on the canvas
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
