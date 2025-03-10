import 'package:flutter/widgets.dart';
import 'neumorphic_container_painter.dart';

/// A custom container widget that applies a neumorphic design style.
///
/// This widget is a `StatelessWidget` that provides a neumorphic effect to its child widgets,
/// giving them a soft, extruded look that resembles physical objects.
///
/// Usage:
/// ```dart
/// NeumorphicContainer(
///   child: Text('Hello, Neumorphism!'),
/// )
/// ```
///
/// You can customize the appearance of the container by providing different properties
/// such as color, border radius, and shadow intensity.
class NeumorphicContainer extends StatelessWidget {
  /// The shape of the container.
  final ShapeBorder shape;

  /// The margin around the container.
  final EdgeInsets margin;

  /// The padding inside the container.
  final EdgeInsets padding;

  /// The width of the container.
  final double width;

  /// The height of the container.
  final double height;

  /// The child widget to display inside the container.
  final Widget? child;

  /// The list of shadows to apply to the container.
  final List<Shadow> shadows;

  /// The list of inner shadows to apply to the container.
  final List<Shadow> innerShadows;

  /// The blur radius for the shadows.
  final double blur;

  /// The blur radius for the border.
  final double borderBlur;

  /// The gradient to apply to the container.
  final Gradient? gradient;

  /// The gradient to apply to the border of the container.
  final Gradient? borderGradient;

  /// The color of the container.
  final Color color;

  /// The accent color of the container.
  final Color? accentColor;

  /// The alignment of the accent.
  final Alignment? accentAligment;

  /// The intensity of the accent.
  final double accentIntensity;

  /// Creates a [NeumorphicContainer] widget.
  ///
  /// The [shape], [blur], [borderBlur], [padding], [margin], [shadows], [innerShadows],
  /// [color], [width], [height], and [accentIntensity] arguments must not be null.
  const NeumorphicContainer({
    this.child,
    this.shape = const ContinuousRectangleBorder(),
    this.blur = 0,
    this.borderBlur = 0,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.shadows = const <Shadow>[],
    this.gradient,
    this.borderGradient,
    this.color = const Color.fromARGB(0, 0, 0, 0),
    this.innerShadows = const <Shadow>[],
    this.accentColor,
    this.accentAligment,
    this.width = double.infinity,
    this.height = double.infinity,
    this.accentIntensity = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(0),
      child: CustomPaint(
        painter: NeumorphicContainerPainter(
          accentColor: accentColor,
          accentAlignment: accentAligment,
          accentIntensity: accentIntensity,
          blur: blur,
          borderBlur: borderBlur,
          gradient: gradient,
          color: color,
          borderGradient: borderGradient,
          shape: shape,
          strokeWidth: 1,
          shadows: shadows,
          innerShadows: innerShadows,
        ),
        child: Container(
          margin: const EdgeInsets.all(0),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
