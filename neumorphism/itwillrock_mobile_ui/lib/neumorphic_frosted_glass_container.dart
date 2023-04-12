import 'package:flutter/widgets.dart';

import 'neumorphic_frosted_glass_container_painter.dart';

class NeumorphicFrostedGlassContainer extends StatelessWidget {
  final ShapeBorder shape;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget? child;
  final Color? accentColor;
  final Alignment? accentAligment;
  final double accentIntensity;
  const NeumorphicFrostedGlassContainer(
      {this.child,
      this.shape = const ContinuousRectangleBorder(),
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.accentColor,
      this.accentAligment,
      this.accentIntensity = 0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: const EdgeInsets.all(0),
        child: CustomPaint(
          painter: NeumorphicFrostedGlassContainerPainter(
            shape: shape,
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
        ));
  }
}
