import 'package:flutter/widgets.dart';
import 'menu_button_painter.dart';

/// A stateful widget that represents a menu button in the application.
class MenuButton extends StatefulWidget {
  /// The size of the button.
  final double size;

  /// The color of the button.
  final Color color;

  /// The animation step for the button.
  final double animationStep;

  /// Creates a [MenuButton].
  const MenuButton(
      {this.size = 0,
      this.color = const Color.fromARGB(0, 0, 0, 0),
      this.animationStep = 0,
      super.key});

  @override
  MenuButtonState createState() => MenuButtonState();
}

/// The state of the [MenuButton] widget.
class MenuButtonState extends State<MenuButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: MenuButtonPainter(
          animationStep: widget.animationStep,
          color: widget.color,
          strokeWidth: 2,
        ),
        child: Container(
          height: widget.size,
          width: widget.size,
          alignment: const Alignment(0, 0),
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}
