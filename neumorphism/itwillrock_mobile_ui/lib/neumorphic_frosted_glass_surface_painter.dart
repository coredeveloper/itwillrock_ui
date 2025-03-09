import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import 'noise_generator.dart';
import 'neumorphic_shape_painter.dart';

class NeumorphicFrostGlassSurfacePainter extends NeumorphicShapePainter {
  final ui.Image noiseTexture = NoiseGenerator.cachedSmall;
  NeumorphicFrostGlassSurfacePainter({super.shape}) : super(strokeWidth: 0);

  void paintSurface(Canvas canvas, {double sigmaX = 0.9, double sigmaY = 0.9}) {
    final paint = Paint()
      ..imageFilter = ui.ImageFilter.blur(
          sigmaX: sigmaX, sigmaY: sigmaY, tileMode: TileMode.repeated)
      ..shader = ImageShader(
        noiseTexture,
        TileMode.repeated,
        TileMode.repeated,
        Matrix4.identity().storage,
      );

    canvas.save();
    canvas.clipPath(innerPath);
    canvas.drawPath(innerPath, paint);
    canvas.restore();
  }
}
