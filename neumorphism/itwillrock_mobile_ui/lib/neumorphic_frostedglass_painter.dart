import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

import 'noise_generator.dart';

/// A custom painter that creates a frosted glass effect with a neumorphic design.
///
/// This painter can be used to achieve a frosted glass look with a soft,
/// embossed appearance, typically used in neumorphic design patterns.
/// embossed effect that is characteristic of neumorphism.
///
/// To use this painter, create an instance of it and pass it to a `CustomPaint` widget.
class NeumorphicFrostedGlassPainter extends CustomPainter {
  /// The noise texture used to create the frosted glass effect.
  final ui.Image noiseTexture = NoiseGenerator.cachedSmall;

  /// A custom painter that creates a frosted glass effect with neumorphic design.
  ///
  /// This painter can be used to achieve a frosted glass look with a soft,
  /// embossed effect that is characteristic of neumorphism.
  ///
  /// Example usage:
  /// ```dart
  /// CustomPaint(
  ///   painter: NeumorphicFrostedGlassPainter(),
  ///   child: ...
  /// )
  /// ```
  ///
  /// See also:
  ///  * [CustomPainter], which is the base class for creating custom painters.
  NeumorphicFrostedGlassPainter(
      {ShapeBorder shape = const ContinuousRectangleBorder()});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..blendMode = BlendMode.modulate
      ..shader = ImageShader(
        noiseTexture,
        TileMode.repeated,
        TileMode.repeated,
        Matrix4.identity().storage,
      );

    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawRect(Offset.zero & size, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
