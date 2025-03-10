import 'package:flutter/widgets.dart';
import 'neumorphic_shape_painter.dart';

/// A custom painter that extends [NeumorphicShapePainter] to draw
/// shadows for neumorphic design elements.
///
/// This painter is responsible for rendering the shadow effects
/// that give the neumorphic elements their characteristic look.
/// It handles the light and dark shadows to create the illusion
/// of depth and elevation.
class NeumorphicShadowPainter extends NeumorphicShapePainter {
  /// The list of shadows to apply to the shape.
  final List<Shadow> shadows;

  /// The paint object used to draw the shadows.
  final shadowPaint = Paint();

  /// Creates a [NeumorphicShadowPainter].
  NeumorphicShadowPainter(
      {required this.shadows, super.shape, super.strokeWidth});

  /// Paints the shadow effect on the shape.
  void paintShadow(Canvas canvas, {Path? path}) {
    for (final shadow in shadows) {
      shadowPaint
        ..color = shadow.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurSigma);
      if (path != null) {
        canvas.drawPath(path.shift(shadow.offset), shadowPaint);
      } else {
        canvas.drawPath(outerPath.shift(shadow.offset), shadowPaint);
      }
    }
  }
}
