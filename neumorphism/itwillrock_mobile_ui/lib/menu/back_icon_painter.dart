import 'package:flutter/widgets.dart';
import '../neumorphic_shape_painter.dart';

/// A custom painter that draws a back icon with a neumorphic design.
///
/// This class extends [NeumorphicShapePainter] to provide a custom
/// painting implementation for a back icon, typically used for
/// navigation purposes in a user interface.
class BackIconPainter extends NeumorphicShapePainter {
  /// The color of the icon.
  final Color color;

  /// The paint object used to draw the icon.
  final Paint paintObject = Paint();

  /// The maximum rotation angle for the icon.
  final maxRotationRadians = 0.79;

  /// Creates a [BackIconPainter].
  BackIconPainter({required this.color, required super.strokeWidth}) {
    paintObject.color = color;
  }

  /// Paints the back icon onto the given canvas.
  void paintIcon(Canvas canvas) {
    var step = innerRect.height / 3;

    var topLine = RRect.fromLTRBR(innerRect.left, innerRect.top,
        innerRect.right, innerRect.top + step, Radius.circular(step / 2));

    var bottomLine = RRect.fromLTRBR(innerRect.left, innerRect.top + step * 2,
        innerRect.right, innerRect.bottom, const Radius.circular(4));
    var topIconPath = Path()..addRRect(topLine);
    var bottomIconPath = Path()..addRRect(bottomLine);

    canvas.translate(-5, outerRect.height / 2);
    canvas.rotate(-maxRotationRadians);
    canvas.drawPath(topIconPath, paintObject);

    canvas.rotate(maxRotationRadians * 2);
    canvas.translate(0, -outerRect.height);
    canvas.drawPath(bottomIconPath, paintObject);
  }
}
