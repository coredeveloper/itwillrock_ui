import 'package:flutter/widgets.dart';
import 'neumorphic_shape_painter.dart';

/// A painter that paints a neumorphic accent.
///
/// The [NeumorphicAccentPainter] class is responsible for painting the accent
/// effect in a neumorphic design. It extends [NeumorphicShapePainter] to
/// provide additional functionality for painting accents.
class NeumorphicAccentPainter extends NeumorphicShapePainter {
  /// The color of the accent.
  final Color color;

  /// The alignment of the accent.
  final Alignment alignment;

  /// The intensity value of the accent.
  double value;

  /// The paint object used to paint the accent.
  Paint paintObject = Paint();

  /// The shift value for the accent.
  final double accentShift = 4;

  /// Creates a [NeumorphicAccentPainter].
  ///
  /// The [color], [alignment], [value], [shape], and [strokeWidth] arguments
  /// must not be null.
  NeumorphicAccentPainter({
    required this.color,
    required this.alignment,
    required this.value,
    required super.shape,
    required super.strokeWidth,
  }) {
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

  /// Paints the accent on the given [canvas].
  ///
  /// This method is responsible for painting the accent effect on the provided
  /// [canvas]. It uses the [outerPath] and [innerPath] to create the accent
  /// effect.
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
