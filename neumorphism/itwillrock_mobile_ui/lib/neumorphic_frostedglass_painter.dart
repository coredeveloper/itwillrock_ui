import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

import 'noise_generator.dart';

class NeumorphicFrostedGlassPainter extends CustomPainter {
  final ui.Image noiseTexture = NoiseGenerator.cachedSmall;

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
