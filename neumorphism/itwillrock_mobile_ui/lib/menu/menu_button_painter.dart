import 'package:flutter/widgets.dart';

import 'menu_icon_painter.dart';

/// A custom painter for rendering a menu button with a neumorphic design.
///
/// This class extends [CustomPainter] and overrides the [paint] and
/// [shouldRepaint] methods to provide custom drawing logic for the menu button.
class MenuButtonPainter extends CustomPainter {
  /// A painter that handles the drawing of the menu button icon.
  late MenuIconPainter iconPainter;

  /// The animation step for the menu button.
  double animationStep;

  /// Creates a [MenuButtonPainter].
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
