import 'package:flutter/widgets.dart';

import 'neumorphic_container_painter.dart';

class NeumorphicContainer extends StatelessWidget {
  final ShapeBorder shape;
  final double margin;
  final double padding;
  final Widget child;
  final List<Shadow> shadows;
  final List<Shadow> innerShadows;
  final double blur;
  final double borderBlur;
  final Gradient gradient;
  final Gradient borderGradient;
  final Color color;
  final Color accentColor;
  final Alignment accentAligment;
  final double accentIntensity;
  NeumorphicContainer({
    this.child,
    this.shape,
    this.blur,
    this.borderBlur,
    this.padding,
    this.margin,
    this.shadows,
    this.gradient,
    this.borderGradient,
    this.color,
    this.innerShadows,
    this.accentColor,
    this.accentAligment,
    this.accentIntensity,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(margin),
        padding: new EdgeInsets.all(0),
        child: new CustomPaint(
          child: new Container(
            child: child,
            margin: new EdgeInsets.all(0),
            padding: new EdgeInsets.all(padding),
          ),
          painter: new NeumorphicContainerPainter(
              accentColor: accentColor,
              accentAlignment: accentAligment,
              accentIntensity: accentIntensity != null ? accentIntensity : 0,
              blur: blur,
              borderBlur: borderBlur,
              gradient: gradient,
              color: color,
              borderGradient: borderGradient,
              shape: shape,
              strokeWidth: 1,
              shadows: shadows,
              innerShadows: innerShadows),
        ));
  }
}
