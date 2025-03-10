import 'package:flutter/widgets.dart';

import 'neumorphic_frosted_glass_container_painter.dart';

/// A neumorphic container with frosted glass effects.
///
/// The [NeumorphicFrostedGlassContainer] widget displays a container with neumorphic
/// frosted glass effects. It uses [NeumorphicFrostedGlassContainerPainter] to paint the container.
class NeumorphicFrostedGlassContainer extends StatelessWidget {
  /// The shape of the container.
  final ShapeBorder shape;

  /// The margin around the container.
  final EdgeInsets margin;

  /// The padding inside the container.
  final EdgeInsets padding;

  /// The child widget to display inside the container.
  final Widget? child;

  /// The accent color of the container.
  final Color? accentColor;

  /// The alignment of the accent.
  final Alignment? accentAligment;

  /// The intensity of the accent.
  final double accentIntensity;

  /// Creates a [NeumorphicFrostedGlassContainer] widget.
  ///
  /// The [shape], [padding], [margin], and [accentIntensity] arguments must not be null.
  const NeumorphicFrostedGlassContainer({
    this.child,
    this.shape = const ContinuousRectangleBorder(),
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.accentColor,
    this.accentAligment,
    this.accentIntensity = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(0),
      child: CustomPaint(
        painter: NeumorphicFrostedGlassContainerPainter(
          shape: shape,
          accentColor: accentColor,
          accentIntensity: accentIntensity,
          accentAlignment: accentAligment,
        ),
        child: Container(
          margin: const EdgeInsets.all(0),
          padding: padding,
          child: Container(
            margin: const EdgeInsets.all(0),
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
