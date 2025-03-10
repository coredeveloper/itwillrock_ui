import 'package:flutter/widgets.dart';
import 'back_button_painter.dart';

/// A custom back button widget that extends [StatelessWidget].
///
/// This widget can be used to navigate back to the previous screen
/// in a Flutter application. It is designed to fit within the
/// neumorphism design pattern.
class BackButton extends StatelessWidget {
  /// The size of the button.
  final double size;

  /// The callback function when the button is tapped.
  final GestureTapCallback? onTap;

  /// Creates a [BackButton].
  const BackButton(this.size, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        child: CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: BackButtonPainter(),
          child: Container(
            height: size,
            width: size,
            alignment: const Alignment(0, 0),
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
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
