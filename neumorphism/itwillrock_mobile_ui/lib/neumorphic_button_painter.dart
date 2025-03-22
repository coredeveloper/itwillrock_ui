import 'package:flutter/widgets.dart';

import 'neumorphic_accent_painter.dart';
import 'neumorphic_shadow_painter.dart';
import 'neumorphic_surface_painter.dart';

/// A custom painter for neumorphic buttons.
///
/// The [NeumorphicButtonPainter] class is responsible for painting the neumorphic
/// button with shadow, surface, and accent effects.
class NeumorphicButtonPainter extends CustomPainter {
  /// A painter that is responsible for drawing shadows for the Neumorphic button.
  ///
  /// This painter is used to create the shadow effect that gives the button
  /// a raised or pressed appearance, depending on the light source and shadow
  /// configuration.
  late NeumorphicShadowPainter shadowPainter;

  /// A painter that is used to draw the surface of a Neumorphic button.
  ///
  /// This painter is responsible for rendering the visual appearance of the
  /// Neumorphic button, including its shadows, highlights, and other
  /// Neumorphic effects.
  late NeumorphicSurfacePainter surfacePainter;

  /// A painter used to draw accent effects on a Neumorphic button.
  ///
  /// This painter can be used to add additional visual effects to the button,
  /// such as shadows, highlights, or other decorative elements.
  NeumorphicAccentPainter? accentPainter;

  /// The animation value for the painter.
  final double animationValue;

  /// Creates a [NeumorphicButtonPainter].
  ///
  /// The [animationValue] argument must not be null.
  NeumorphicButtonPainter({
    Gradient? gradient,
    List<Shadow> shadows = const <Shadow>[],
    ShapeBorder shape = const ContinuousRectangleBorder(),
    double blur = 0,
    double borderBlur = 0,
    Color color = const Color.fromARGB(0, 0, 0, 0),
    double strokeWidth = 0,
    Gradient? borderGradient,
    Color? accentColor,
    double accentIntensity = 0,
    Alignment? accentAlignment,
    required this.animationValue,
    Key? key,
  }) {
    shadowPainter = NeumorphicShadowPainter(
        shadows: shadows, shape: shape, strokeWidth: strokeWidth);

    if (accentColor != null && accentAlignment != null && accentIntensity > 0) {
      accentPainter = NeumorphicAccentPainter(
          alignment: accentAlignment,
          value: accentIntensity,
          color: accentColor,
          shape: shape,
          strokeWidth: strokeWidth);
    }

    surfacePainter = NeumorphicSurfacePainter(
        shape: shape,
        gradient: gradient,
        color: color,
        borderGradient: borderGradient,
        blur: blur,
        borderBlur: borderBlur,
        strokeWidth: strokeWidth);
  }

  @override
  void paint(Canvas canvas, Size size) {
    shadowPainter.calculateShape(const Offset(0, 0), size);
    surfacePainter.calculateShape(const Offset(0, 0), size);
    shadowPainter.paintShadow(canvas);
    surfacePainter.paintSurface(canvas);
    if (accentPainter != null) {
      accentPainter!.calculateShape(const Offset(0, 0), size);
      accentPainter!.paintAccent(canvas);
    }
  }

  @override
  bool shouldRepaint(NeumorphicButtonPainter oldDelegate) {
    // Safely compare colors, handling null values
    final colorChanged =
        surfacePainter.color == oldDelegate.surfacePainter.color ? false : true;

    return animationValue != oldDelegate.animationValue || colorChanged;
  }
}
