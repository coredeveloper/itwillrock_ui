import 'package:flutter/widgets.dart';

/// An abstract class that defines the contract for painting
/// Neumorphic shapes. Classes that extend this abstract class
/// should implement the painting logic for Neumorphic shapes.
abstract class NeumorphicShapePainter {
  /// The shape of the Neumorphic element.
  final ShapeBorder shape;

  /// The width of the stroke for the shape.
  final double strokeWidth;

  /// The outer rectangle of the shape.
  late Rect outerRect;

  /// The inner rectangle of the shape.
  late Rect innerRect;

  /// The outer path of the shape.
  late Path outerPath;

  /// The inner path of the shape.
  late Path innerPath;

  /// Creates a [NeumorphicShapePainter].
  NeumorphicShapePainter({
    this.shape = const ContinuousRectangleBorder(),
    this.strokeWidth = 0,
  });

  /// Converts a radius value to a sigma value.
  double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  /// Calculates the shape of the Neumorphic element.
  void calculateShape(Offset offset, Size size) {
    outerRect = offset & size;
    innerRect = outerRect.deflate(strokeWidth);
    outerPath = shape.getOuterPath(outerRect);
    innerPath = shape.getOuterPath(innerRect);
  }
}
