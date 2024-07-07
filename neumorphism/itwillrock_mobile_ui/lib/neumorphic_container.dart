import 'package:flutter/widgets.dart';
import 'neumorphic_container_painter.dart';

class NeumorphicContainer extends StatelessWidget {
  final ShapeBorder shape;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;
  final double height;
  final Widget? child;
  final List<Shadow> shadows;
  final List<Shadow> innerShadows;
  final double blur;
  final double borderBlur;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final Color color;
  final Color? accentColor;
  final Alignment? accentAligment;
  final double accentIntensity;
  const NeumorphicContainer(
      {this.child,
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
      super.key});

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
              innerShadows: innerShadows),
          child: Container(
            margin: const EdgeInsets.all(0),
            padding: padding,
            child: child,
          ),
        ));
  }
}
