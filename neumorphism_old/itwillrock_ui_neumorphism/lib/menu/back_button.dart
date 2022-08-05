import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'back_button_painter.dart';

class BackButton extends StatelessWidget {
  final double size;
  GestureTapCallback onTap;
  BackButton({this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        child: CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: BackButtonPainter(),
          child: Container(
            height: size,
            width: size,
            alignment: Alignment(0, 0),
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
          ),
        ),
      ),
    );

    // RepaintBoundary(
    //   child: CustomPaint(
    //     size: Size(double.infinity, double.infinity),
    //     painter: MenuButtonPainter(
    //       animationStep: widget.animationStep,
    //       color: widget.color,
    //       strokeWidth: 2,
    //     ),
    //     child: Container(
    //       height: widget.size,
    //       width: widget.size,
    //       alignment: Alignment(0, 0),
    //       margin: EdgeInsets.all(0),
    //       padding: EdgeInsets.all(0),
    //     ),
    //   ),
    // )
  }
}
