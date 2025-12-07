import 'package:flutter/widgets.dart';

import 'neumorphic_accent_painter.dart';
import 'neumorphic_frosted_glass_surface_painter.dart';

/// A custom painter for neumorphic frosted glass containers.
///
/// The [NeumorphicFrostedGlassContainerPainter] class is responsible for painting
/// the neumorphic frosted glass container with surface and accent effects.
class NeumorphicFrostedGlassContainerPainter extends CustomPainter {
  /// A painter that is responsible for rendering the frosted glass effect
  /// with a neumorphic design on a surface.
  ///
  late NeumorphicFrostGlassSurfacePainter surfacePainter;

  /// A painter that applies a neumorphic accent effect to the container.
  ///
  /// This painter is used to add a frosted glass effect with neumorphic
  /// design principles to the container. It can be customized to achieve
  /// various neumorphic accent styles.
  NeumorphicAccentPainter? accentPainter;

  /// Creates a [NeumorphicFrostedGlassContainerPainter].
  ///
  /// The [shape], [accentColor], [accentIntensity], and [accentAlignment] arguments
  /// must not be null.
  NeumorphicFrostedGlassContainerPainter({
    ShapeBorder shape = const ContinuousRectangleBorder(),
    Color? accentColor,
    double accentIntensity = 0,
    Alignment? accentAlignment,
  }) {
    surfacePainter = NeumorphicFrostGlassSurfacePainter(shape: shape);
    if (accentColor != null && accentAlignment != null && accentIntensity > 0) {
      accentPainter = NeumorphicAccentPainter(
          alignment: accentAlignment,
          value: accentIntensity,
          color: accentColor,
          shape: shape,
          strokeWidth: 0);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    surfacePainter.calculateShape(const Offset(0, 0), size);
    surfacePainter.paintSurface(canvas);
    if (accentPainter != null) {
      accentPainter!.calculateShape(const Offset(0, 0), size);
      accentPainter!.paintAccent(canvas);
    }
  }

  @override
  bool shouldRepaint(NeumorphicFrostedGlassContainerPainter oldDelegate) {
    return accentPainter?.value != oldDelegate.accentPainter?.value;
  }
}
