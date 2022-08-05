import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'menu_button_painter.dart';

class MenuButton extends StatefulWidget {
  final double size;
  final Color color;
  final double animationStep;
  MenuButton({this.size, this.color, this.animationStep});

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: MenuButtonPainter(
          animationStep: widget.animationStep,
          color: widget.color,
          strokeWidth: 2,
        ),
        child: Container(
          height: widget.size,
          width: widget.size,
          alignment: Alignment(0, 0),
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
