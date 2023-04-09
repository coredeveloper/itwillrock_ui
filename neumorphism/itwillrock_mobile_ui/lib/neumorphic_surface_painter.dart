import 'package:flutter/widgets.dart';

import 'neumorphic_shape_painter.dart';

class NeumorphicSurfacePainter extends NeumorphicShapePainter {
  final Gradient? gradient;
  final Color? color;
  final Gradient? borderGradient;
  final Paint borderPaintObject = Paint();
  final Paint paintObject = Paint();
  final double blur;
  final double borderBlur;
  Path? borderPath;
  NeumorphicSurfacePainter(
      {this.gradient,
      this.color,
      this.borderGradient,
      this.blur = 0,
      this.borderBlur = 0,
      shape,
      @required strokeWidth})
      : super(shape: shape, strokeWidth: strokeWidth);

  void paintSurface(Canvas canvas, {Path? path}) {
    if (path != null) {
      borderPath = path;
    } else {
      borderPath = _calculateBorderPath(outerPath, innerPath);
    }

    if (borderBlur > 0) {
      borderPaintObject.maskFilter =
          MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(borderBlur));
    }
    if (gradient != null) {
      if (path != null) {
        paintObject.shader = gradient?.createShader(path.getBounds());
      } else {
        paintObject.shader = gradient?.createShader(innerPath.getBounds());
      }
    } else if (color != null) {
      if (blur > 0) {
        paintObject.maskFilter =
            MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(blur));
      }
      paintObject.color = color!;
    }
    if (borderGradient != null) {
      borderPaintObject.shader =
          borderGradient?.createShader(outerPath.getBounds());
      canvas.drawPath(borderPath!, borderPaintObject);
    }
    if (path != null) {
      canvas.drawPath(path, paintObject);
    } else {
      canvas.drawPath(innerPath, paintObject);
    }
  }

  Path _calculateBorderPath(Path outerPath, Path innerPath) {
    return Path.combine(PathOperation.difference, outerPath, innerPath);
  }
}
