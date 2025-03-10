import 'package:flutter/widgets.dart';

import 'neumorphic_accent_painter.dart';
import 'neumorphic_inner_shadow_painter.dart';
import 'neumorphic_shadow_painter.dart';
import 'neumorphic_surface_painter.dart';

/// A custom painter that draws a neumorphic container.
///
/// This painter is used to create a neumorphic effect on a container,
/// giving it a soft, extruded look with light and shadow effects.
class NeumorphicContainerPainter extends CustomPainter {
  /// A painter that handles the drawing of shadows for a neumorphic container.
  ///
  /// This painter is used to create the shadow effects that give the neumorphic
  /// design its characteristic look.
  ///
  /// See also:
  ///
  ///  * [NeumorphicContainer], which uses this painter to draw its shadows.
  late NeumorphicShadowPainter shadowPainter;

  /// A painter that applies an inner shadow effect to a Neumorphic container.
  ///
  /// This painter is used to create a concave or inset effect, giving the
  /// appearance that the container is pressed into the background.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// NeumorphicInnerShadowPainter innerShadowPainter = NeumorphicInnerShadowPainter();
  /// ```
  ///
  /// See also:
  ///
  ///  * [NeumorphicContainer], which uses this painter to create Neumorphic designs.
  late NeumorphicInnerShadowPainter innerShadowPainter;

  /// A painter that is used to draw the surface of a Neumorphic container.
  ///
  /// This painter is responsible for rendering the visual appearance of the
  /// Neumorphic surface, including shadows, highlights, and other effects
  /// that give the container its characteristic look.
  late NeumorphicSurfacePainter surfacePainter;

  /// A painter that is used to draw accents on a Neumorphic container.
  ///
  /// This painter can be used to add additional visual effects to a Neumorphic
  /// container, such as shadows, highlights, or other decorative elements.
  NeumorphicAccentPainter? accentPainter;

  /// A custom painter for rendering a Neumorphic container effect.
  ///
  /// This painter is used to create a Neumorphic design, which gives the
  /// appearance of extruded or inset shapes, creating a soft, 3D effect.
  ///
  /// The NeumorphicContainerPainter class should be used with a CustomPaint
  /// widget to apply the Neumorphic effect to a container.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// CustomPaint(
  ///   painter: NeumorphicContainerPainter(),
  ///   child: Container(
  ///     width: 100,
  ///     height: 100,
  ///   ),
  /// )
  /// ```
  ///
  /// The painter can be customized to achieve different Neumorphic effects
  /// by adjusting its properties.
  NeumorphicContainerPainter(
      {Gradient? gradient,
      List<Shadow> shadows = const <Shadow>[],
      List<Shadow> innerShadows = const <Shadow>[],
      ShapeBorder shape = const ContinuousRectangleBorder(),
      double blur = 0,
      double borderBlur = 0,
      Color color = const Color.fromARGB(0, 0, 0, 0),
      double strokeWidth = 0,
      Gradient? borderGradient,
      Color? accentColor,
      double accentIntensity = 0,
      Alignment? accentAlignment}) {
    shadowPainter = NeumorphicShadowPainter(
        shadows: shadows, shape: shape, strokeWidth: strokeWidth);
    surfacePainter = NeumorphicSurfacePainter(
        shape: shape,
        gradient: gradient,
        color: color,
        borderGradient: borderGradient,
        blur: blur,
        borderBlur: borderBlur,
        strokeWidth: strokeWidth);
    if (accentColor != null && accentAlignment != null && accentIntensity > 0) {
      accentPainter = NeumorphicAccentPainter(
          alignment: accentAlignment,
          value: accentIntensity,
          color: accentColor,
          shape: shape,
          strokeWidth: strokeWidth);
    }
    innerShadowPainter = NeumorphicInnerShadowPainter(
        innerShadows: innerShadows, shape: shape, strokeWidth: strokeWidth);
  }

  @override
  void paint(Canvas canvas, Size size) {
    shadowPainter.calculateShape(const Offset(0, 0), size);
    surfacePainter.calculateShape(const Offset(0, 0), size);
    innerShadowPainter.calculateShape(const Offset(0, 0), size);
    shadowPainter.paintShadow(canvas);
    surfacePainter.paintSurface(canvas);
    innerShadowPainter.paintShadow(canvas);
    if (accentPainter != null) {
      accentPainter!.calculateShape(const Offset(0, 0), size);
      accentPainter!.paintAccent(canvas);
    }
  }

  @override
  bool shouldRepaint(NeumorphicContainerPainter oldDelegate) {
    return false;
  }
}
