import 'package:flutter/widgets.dart';

abstract class NeumorphicShapePainter {
  final ShapeBorder shape;
  final double strokeWidth;
  late Rect outerRect;
  late Rect innerRect;
  late Path outerPath;
  late Path innerPath;

  NeumorphicShapePainter({
    this.shape = const ContinuousRectangleBorder(),
    this.strokeWidth = 0,
  });

  double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  void calculateShape(Offset offset, Size size) {
    outerRect = offset & size;
    innerRect = outerRect.deflate(strokeWidth);
    outerPath = shape.getOuterPath(outerRect);
    innerPath = shape.getOuterPath(innerRect);
  }
}
