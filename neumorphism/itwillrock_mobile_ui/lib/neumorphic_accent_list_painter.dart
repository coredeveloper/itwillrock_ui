import 'package:flutter/widgets.dart';
import 'neumorphic_shadow_painter.dart';
import 'neumorphic_surface_painter.dart';

/// A custom painter that paints a neumorphic accent list.
///
/// The [NeumorphicAccentListPainter] class uses [NeumorphicShadowPainter] and
/// [NeumorphicSurfacePainter] to paint a neumorphic accent list with shadows
/// and surface effects.
class NeumorphicAccentListPainter extends CustomPainter {
  /// A painter that is responsible for rendering shadows in a Neumorphic design.
  ///
  /// This painter is used to create the shadow effects that give the
  /// Neumorphic design its characteristic look and feel.
  ///
  /// The [NeumorphicShadowPainter] is typically used in conjunction with
  /// other Neumorphic painters to achieve the desired visual effect.
  late NeumorphicShadowPainter shadowPainter;

  /// A painter that is used to render the surface of a Neumorphic design element.
  ///
  /// This painter is responsible for drawing the visual appearance of the
  /// Neumorphic surface, including shadows, highlights, and other effects
  /// that create the characteristic Neumorphic look.
  ///
  /// The `NeumorphicSurfacePainter` is typically used in conjunction with
  /// other Neumorphic design elements to achieve a cohesive and visually
  /// appealing UI.
  ///
  /// See also:
  /// - [Neumorphic design](https://en.wikipedia.org/wiki/Neumorphism) for more information on the design style.
  late NeumorphicSurfacePainter surfacePainter;

  /// The size of the indicator.
  final Size indicatorSize;

  /// The offset of the indicator.
  final Offset offset;

  /// Creates a [NeumorphicAccentListPainter].
  ///
  /// The [shadows], [offset], [indicatorSize], [blur], [strokeWidth], and [color]
  /// arguments must not be null.
  NeumorphicAccentListPainter({
    List<Shadow> shadows = const <Shadow>[],
    this.offset = const Offset(0, 0),
    this.indicatorSize = const Size(8, 32),
    double blur = 0,
    double strokeWidth = 0,
    Color color = const Color.fromARGB(0, 0, 0, 0),
    Key? key,
  }) {
    shadowPainter =
        NeumorphicShadowPainter(shadows: shadows, strokeWidth: strokeWidth);

    surfacePainter = NeumorphicSurfacePainter(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: color,
        blur: blur,
        borderBlur: blur,
        strokeWidth: strokeWidth);
  }

  @override
  void paint(Canvas canvas, Size size) {
    shadowPainter.calculateShape(offset, indicatorSize);
    shadowPainter.paintShadow(canvas);
    surfacePainter.calculateShape(offset, indicatorSize);
    surfacePainter.paintSurface(canvas);
  }

  @override
  bool shouldRepaint(NeumorphicAccentListPainter oldDelegate) {
    if (offset.dy == oldDelegate.offset.dy) {
      return false;
    }
    return true;
  }
}
