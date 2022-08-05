import 'package:flutter/widgets.dart';

import 'menu_icon_painter.dart';

class MenuButtonPainter extends CustomPainter {
  MenuIconPainter iconPainter;
  double animationStep;
  MenuButtonPainter({
    Color color,
    double strokeWidth,
    this.animationStep,
  }) {
    this.iconPainter = new MenuIconPainter(
        color: color, animationStep: animationStep, strokeWidth: strokeWidth);
  }

  @override
  void paint(Canvas canvas, Size size) {
    iconPainter.calculateShape(Offset(0, 0), size);

    iconPainter.paintIcon(canvas);
  }

  @override
  bool shouldRepaint(MenuButtonPainter oldDelegate) {
    if (animationStep == oldDelegate.animationStep) {
      return false;
    }
    return true;
  }
}
