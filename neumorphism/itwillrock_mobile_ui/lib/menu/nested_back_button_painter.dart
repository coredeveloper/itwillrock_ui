import 'package:flutter/widgets.dart';
import '../constants/colors.dart';
import 'back_icon_painter.dart';

/// A custom painter that draws nested back chevrons using BackIconPainter.
///
/// Displays multiple chevrons to indicate navigation depth:
/// - Level 1: `<`
/// - Level 2: `<<`
/// - Level 3: `<<<`
class NestedBackButtonPainter extends CustomPainter {
  /// The number of chevrons to display (navigation depth).
  final int nestingLevel;

  /// Animation progress for the newest chevron (0.0 to 1.0).
  final double animationStep;

  /// The color of the chevrons. Defaults to accent color if null.
  final Color? color;

  /// The stroke width of the chevron lines.
  final double strokeWidth;

  /// Creates a [NestedBackButtonPainter].
  NestedBackButtonPainter({
    this.nestingLevel = 1,
    this.animationStep = 1.0,
    this.color,
    this.strokeWidth = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final chevronColor = color ?? AppColors.accentColor;
    final chevronSize = size.height; // Square based on height
    final spacing = chevronSize * 0.5;

    for (int i = 0; i < nestingLevel; i++) {
      // Animate only the last chevron
      double opacity = 1.0;
      if (i == nestingLevel - 1 && nestingLevel > 1) {
        opacity = animationStep;
      }
      if (opacity <= 0) continue;

      // Create painter with opacity
      final painter = BackIconPainter(
        color: chevronColor.withValues(alpha: opacity * chevronColor.a),
        strokeWidth: strokeWidth,
      );

      canvas.save();

      // Offset for this chevron
      canvas.translate(i * spacing, 0);

      // Calculate shape for square chevron
      painter.calculateShape(Offset.zero, Size(chevronSize, chevronSize));

      // Draw using exact BackIconPainter code
      painter.paintIcon(canvas);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(NestedBackButtonPainter oldDelegate) {
    return oldDelegate.nestingLevel != nestingLevel ||
        oldDelegate.animationStep != animationStep ||
        oldDelegate.color != color;
  }
}
