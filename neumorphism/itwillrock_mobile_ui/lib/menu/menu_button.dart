import 'package:flutter/widgets.dart';
import 'menu_button_painter.dart';

class MenuButton extends StatefulWidget {
  final double size;
  final Color color;
  final double animationStep;
  const MenuButton(
      {this.size = 0,
      this.color = const Color.fromARGB(0, 0, 0, 0),
      this.animationStep = 0,
      super.key});

  @override
  MenuButtonState createState() => MenuButtonState();
}

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
