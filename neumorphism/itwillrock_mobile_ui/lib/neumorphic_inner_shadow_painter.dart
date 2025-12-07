import 'package:flutter/widgets.dart';

import 'neumorphic_shape_painter.dart';

/// A custom painter that draws an inner shadow to create a
/// neumorphic effect on a widget. This painter extends the
/// [NeumorphicShapePainter] to provide additional styling
/// specific to inner shadows.
class NeumorphicInnerShadowPainter extends NeumorphicShapePainter {
  /// The list of inner shadows to apply to the widget.
  final List<Shadow> innerShadows;

  /// Cached paint object for performance.
  final Paint _shadowPaint = Paint();

  /// Creates a [NeumorphicInnerShadowPainter].
  NeumorphicInnerShadowPainter({
    required this.innerShadows,
    required super.shape,
    required super.strokeWidth,
  });

  /// Paints the inner shadow effect on the widget.
  void paintShadow(Canvas canvas, {Path? path}) {
    if (path != null) {
      innerPath = path;
    }
    canvas.save();
    canvas.clipPath(innerPath);
    var virtualBoxPath = path;

    virtualBoxPath ??= Path.combine(PathOperation.difference,
        shape.getOuterPath(outerRect.inflate(30)), innerPath);

    for (final shadow in innerShadows) {
      _shadowPaint
        ..color = shadow.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurSigma);
      canvas.drawPath(virtualBoxPath.shift(shadow.offset), _shadowPaint);
    }

    canvas.restore();
  }
}
