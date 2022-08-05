import 'package:flutter/widgets.dart';

abstract class NeumorphicShapePainter {
  final ShapeBorder? shape;
  final double strokeWidth;
  Rect? outerRect;
  Rect? innerRect;
  Path? outerPath;
  Path? innerPath;

  NeumorphicShapePainter({
    this.shape,
    this.strokeWidth = 0,
  });

  double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  void calculateShape(Offset offset, Size size) {
    outerRect = offset & size;
    innerRect = outerRect?.deflate(strokeWidth);
    if (shape != null) {
      outerPath = shape?.getOuterPath(outerRect!);
      innerPath = shape?.getOuterPath(innerRect!);
    } else {
      outerPath = Path()..addRect(outerRect!);
      innerPath = Path()..addRect(innerRect!);
    }
  }
}
