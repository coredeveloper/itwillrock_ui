import 'package:flutter/widgets.dart';
import 'neumorphic_shape_painter.dart';

/// A custom painter that extends [NeumorphicShapePainter] to paint
/// a surface with a neumorphic design. This painter is used to create
/// the light and shadow effects that give the appearance of a raised
/// or recessed surface.
///
/// The [NeumorphicSurfacePainter] class provides the necessary methods
/// to paint the neumorphic surface with the desired shape, light source,
/// and shadow properties.
class NeumorphicSurfacePainter extends NeumorphicShapePainter {
  /// The gradient to apply to the surface.
  final Gradient? gradient;

  /// The color of the surface.
  final Color? color;

  /// The gradient to apply to the border of the surface.
  final Gradient? borderGradient;

  /// The paint object used to draw the border.
  final Paint borderPaintObject = Paint();

  /// The paint object used to draw the surface.
  final Paint paintObject = Paint();

  /// The blur radius for the surface.
  final double blur;

  /// The blur radius for the border.
  final double borderBlur;

  /// The border path.
  Path? borderPath;

  /// Creates a [NeumorphicSurfacePainter].
  NeumorphicSurfacePainter(
      {this.gradient,
      this.color,
      this.borderGradient,
      this.blur = 0,
      this.borderBlur = 0,
      super.shape,
      super.strokeWidth});

  /// Paints the surface effect on the shape.
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
