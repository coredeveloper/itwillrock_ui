import 'package:flutter/widgets.dart';

import 'neumorphic_shape_painter.dart';

class NeumorphicInnerShadowPainter extends NeumorphicShapePainter {
  final List<Shadow> innerShadows;

  NeumorphicInnerShadowPainter(
      {@required this.innerShadows, shape, @required strokeWidth})
      : super(shape: shape, strokeWidth: strokeWidth);

  void paintShadow(Canvas canvas, {Path path}) {
    if (innerShadows == null) return;
    if (path != null) {
      innerPath = path;
    }
    canvas.save();
    canvas.clipPath(innerPath);
    var virtualBoxPath = path;

    if (virtualBoxPath == null) {
      virtualBoxPath = Path.combine(PathOperation.difference,
          shape.getOuterPath(outerRect.inflate(30)), innerPath);
    }

    for (final shadow in innerShadows) {
      final shadowPaint = Paint()
        ..color = shadow.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurSigma);
      canvas.drawPath(virtualBoxPath.shift(shadow.offset), shadowPaint);
    }

    canvas.restore();
  }
}
