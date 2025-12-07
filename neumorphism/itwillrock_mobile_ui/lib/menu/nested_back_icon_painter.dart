import 'package:flutter/widgets.dart';
import '../neumorphic_shape_painter.dart';

/// A custom painter that draws nested back chevrons (< << <<<).
///
/// Used to indicate navigation depth in nested screen hierarchies.
/// The number of chevrons corresponds to the nesting level.
class NestedBackIconPainter extends NeumorphicShapePainter {
  /// The color of the chevrons.
  final Color color;

  /// The current nesting level (1 = <, 2 = <<, 3 = <<<, etc.)
  final int nestingLevel;

  /// Animation progress for smooth transitions (0.0 to 1.0).
  /// Used when transitioning between nesting levels.
  final double animationStep;

  /// The cached paint object used to draw the chevrons.
  final Paint _paintObject = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  /// Spacing between multiple chevrons as fraction of size.
  static const double _chevronSpacing = 0.35;

  /// Creates a [NestedBackIconPainter].
  NestedBackIconPainter({
    required this.color,
    required super.strokeWidth,
    this.nestingLevel = 1,
    this.animationStep = 1.0,
  }) {
    _paintObject.color = color;
    _paintObject.strokeWidth = strokeWidth;
  }

  /// Paints the nested chevrons onto the canvas.
  void paintIcon(Canvas canvas) {
    final centerY = outerRect.height / 2;
    final chevronHeight = outerRect.height * 0.4;
    final chevronWidth = outerRect.width * 0.3;
    final spacing = outerRect.width * _chevronSpacing;

    // Calculate total width needed for all chevrons
    final totalWidth = (nestingLevel - 1) * spacing + chevronWidth;

    // Start position (right-aligned within bounds)
    final startX = outerRect.right - totalWidth - outerRect.width * 0.1;

    for (int i = 0; i < nestingLevel; i++) {
      // Calculate opacity/scale for animation
      // Last chevron animates in, others are fully visible
      double opacity = 1.0;
      double scale = 1.0;

      if (i == nestingLevel - 1) {
        // Animate the newest chevron
        opacity = animationStep;
        scale = 0.5 + (animationStep * 0.5);
      }

      if (opacity <= 0) continue;

      final chevronX = startX + (i * spacing);

      canvas.save();

      // Apply animation transforms
      if (scale != 1.0) {
        final pivotX = chevronX + chevronWidth / 2;
        canvas.translate(pivotX, centerY);
        canvas.scale(scale, scale);
        canvas.translate(-pivotX, -centerY);
      }

      // Set opacity using alpha channel
      final alpha = (opacity * color.a).round();
      _paintObject.color = color.withValues(alpha: alpha / 255);

      // Draw chevron as two lines forming <
      final path = Path();

      // Top arm of chevron (going up-left)
      path.moveTo(chevronX + chevronWidth, centerY - chevronHeight / 2);
      path.lineTo(chevronX, centerY);

      // Bottom arm of chevron (going down-left)
      path.lineTo(chevronX + chevronWidth, centerY + chevronHeight / 2);

      canvas.drawPath(path, _paintObject);
      canvas.restore();
    }

    // Reset paint color
    _paintObject.color = color;
  }
}
