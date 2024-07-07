import 'package:flutter/widgets.dart';
import 'neumorphic_shape_painter.dart';

class NeumorphicShadowPainter extends NeumorphicShapePainter {
  final List<Shadow> shadows;
  final shadowPaint = Paint();
  NeumorphicShadowPainter({required this.shadows, super.shape, super.strokeWidth});

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
