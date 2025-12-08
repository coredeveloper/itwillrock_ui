import 'package:flutter/widgets.dart';
import '../neumorphic_shape_painter.dart';

/// A custom painter that draws nested back chevrons (< << <<<).
///
/// Uses the same drawing logic as BackIconPainter, repeated with offset.
class NestedBackIconPainter extends NeumorphicShapePainter {
  /// The color of the chevrons.
  final Color color;

  /// The number of chevrons to display (navigation depth).
  final int nestingLevel;

  /// Animation progress for the newest chevron (0.0 to 1.0).
  final double animationStep;

  /// Paint object used for drawing.
  final Paint paintObject = Paint();

  /// Maximum rotation angle in radians for the chevron lines.
  final maxRotationRadians = 0.79;

  /// Creates a [NestedBackIconPainter].
  NestedBackIconPainter({
    required this.color,
    required super.strokeWidth,
    this.nestingLevel = 1,
    this.animationStep = 1.0,
  }) {
    paintObject.color = color;
  }

  /// Paints the nested chevron icons on the canvas.
  void paintIcon(Canvas canvas) {
    // Each chevron is square based on height (height doesn't change with nesting)
    final chevronSize = innerRect.height;
    final step = chevronSize / 3;
    final spacing = chevronSize * 0.5;

    for (int i = 0; i < nestingLevel; i++) {
      // Animate only the last chevron (if not the first)
      double opacity = 1.0;
      if (i == nestingLevel - 1 && nestingLevel > 1) {
        opacity = animationStep;
      }
      if (opacity <= 0) continue;

      paintObject.color = color.withValues(alpha: opacity * color.a);

      canvas.save();

      // Offset for this chevron
      canvas.translate(i * spacing, 0);

      // Draw chevron - same SIZE as single BackIconPainter
      var topLine = RRect.fromLTRBR(
        0,
        0,
        chevronSize,
        step,
        Radius.circular(step / 2),
      );

      var bottomLine = RRect.fromLTRBR(
        0,
        step * 2,
        chevronSize,
        chevronSize,
        const Radius.circular(4),
      );

      var topIconPath = Path()..addRRect(topLine);
      var bottomIconPath = Path()..addRRect(bottomLine);

      // Same transforms as BackIconPainter
      canvas.translate(-5, outerRect.height / 2);
      canvas.rotate(-maxRotationRadians);
      canvas.drawPath(topIconPath, paintObject);

      canvas.rotate(maxRotationRadians * 2);
      canvas.translate(0, -outerRect.height);
      canvas.drawPath(bottomIconPath, paintObject);

      canvas.restore();
    }

    paintObject.color = color;
  }
}
