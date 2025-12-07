import 'package:flutter/widgets.dart';
import '../constants/colors.dart';

/// A custom painter that draws nested back chevrons.
///
/// Displays multiple chevrons to indicate navigation depth:
/// - Level 1: `<`
/// - Level 2: `<<`
/// - Level 3: `<<<`
///
/// The newest chevron animates from `-` (horizontal) to `<` (chevron),
/// similar to how the menu button animates from `=` to `>`.
class NestedBackButtonPainter extends CustomPainter {
  /// The number of chevrons to display (navigation depth).
  final int nestingLevel;

  /// Animation progress for the newest chevron (0.0 to 1.0).
  /// At 0.0, the newest chevron is horizontal `-`.
  /// At 1.0, the newest chevron is a full chevron `<`.
  final double animationStep;

  /// The color of the chevrons. Defaults to accent color if null.
  final Color? color;

  /// The stroke width of the chevron lines.
  final double strokeWidth;

  /// Maximum rotation angle in radians for the chevron lines.
  final double _maxRotationRadians = 0.79;

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
    final chevronSize = size.height;
    final spacing = chevronSize * 0.5;
    final paint = Paint()..color = chevronColor;

    for (int i = 0; i < nestingLevel; i++) {
      // Determine rotation for this chevron
      // Last chevron (if not the only one) animates from 0 to full rotation
      final isLastChevron = i == nestingLevel - 1 && nestingLevel > 1;
      final rotation = isLastChevron ? animationStep : 1.0;

      canvas.save();

      // Offset for this chevron
      canvas.translate(i * spacing, 0);

      // Draw chevron with rotation (same logic as BackIconPainter/MenuIconPainter)
      _drawChevron(canvas, chevronSize, paint, rotation);

      canvas.restore();
    }
  }

  /// Draws a single chevron with the given rotation factor.
  /// rotation: 0.0 = horizontal lines `-`, 1.0 = full chevron `<`
  void _drawChevron(Canvas canvas, double size, Paint paint, double rotation) {
    final step = size / 3;

    final topLine = RRect.fromLTRBR(
      0,
      0,
      size,
      step,
      Radius.circular(step / 2),
    );

    final bottomLine = RRect.fromLTRBR(
      0,
      step * 2,
      size,
      size,
      const Radius.circular(4),
    );

    final topIconPath = Path()..addRRect(topLine);
    final bottomIconPath = Path()..addRRect(bottomLine);

    // Same transform as BackIconPainter, but rotation is animated
    canvas.translate(-5, size / 2);
    canvas.rotate(-_maxRotationRadians * rotation);
    canvas.drawPath(topIconPath, paint);

    canvas.rotate(_maxRotationRadians * 2 * rotation);
    canvas.translate(0, -size);
    canvas.drawPath(bottomIconPath, paint);
  }

  @override
  bool shouldRepaint(NestedBackButtonPainter oldDelegate) {
    return oldDelegate.nestingLevel != nestingLevel ||
        oldDelegate.animationStep != animationStep ||
        oldDelegate.color != color;
  }
}
