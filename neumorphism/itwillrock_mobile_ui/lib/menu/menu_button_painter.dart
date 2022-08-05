import 'package:flutter/widgets.dart';

import 'menu_icon_painter.dart';

class MenuButtonPainter extends CustomPainter {
  late MenuIconPainter iconPainter;
  double animationStep;
  MenuButtonPainter({
    Color color = const Color.fromARGB(0, 0, 0, 0),
    double strokeWidth = 0,
    this.animationStep = 0,
  }) {
    iconPainter = MenuIconPainter(
        color: color, animationStep: animationStep, strokeWidth: strokeWidth);
  }

  @override
  void paint(Canvas canvas, Size size) {
    iconPainter.calculateShape(const Offset(0, 0), size);

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
