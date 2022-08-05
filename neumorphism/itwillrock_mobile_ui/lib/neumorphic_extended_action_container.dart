import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../../constants/colors.dart';

import 'neumorphic_button_painter.dart';

class NeumorphicExtendedActionContainer extends StatefulWidget {
  final ShapeBorder shape;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Size size;
  final Widget? child;
  final VoidCallback? onTap;
  final bool toggle;
  final Color color;
  final Color? accentColor;
  final Alignment? accentAligment;
  final double accentIntensity;
  final Gradient? gradient;
  final Duration animationDuration;
  const NeumorphicExtendedActionContainer(
      {this.shape = const ContinuousRectangleBorder(),
      this.animationDuration = Duration.zero,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.child,
      required this.size,
      this.color = const Color.fromARGB(0, 0, 0, 0),
      this.gradient,
      this.accentColor,
      this.accentAligment,
      this.accentIntensity = 0,
      this.onTap,
      this.toggle = false,
      Key? key})
      : super(key: key);

  @override
  NeumorphicExtendedActionContainerState createState() =>
      NeumorphicExtendedActionContainerState();
}

class NeumorphicExtendedActionContainerState
    extends State<NeumorphicExtendedActionContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _shadowTween;
  bool shouldReverse = false;
  @override
  void initState() {
    _animationController = AnimationController(
        animationBehavior: AnimationBehavior.preserve,
        vsync: this,
        duration: widget.animationDuration);

    _shadowTween = Tween(begin: 1.0, end: 0.0).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (_animationController.status == AnimationStatus.completed &&
          shouldReverse) {
        _animationController.reverse();
        shouldReverse = false;
      }
    });
    super.initState();
  }

  void processTapDown() {
    HapticFeedback.selectionClick();
    if (widget.toggle) {
      if (_animationController.status == AnimationStatus.completed) {
      } else {
        _animationController.forward();
      }
    } else {
      _animationController.forward();
    }
  }

  void processTapUp() {
    if (widget.toggle) {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    } else {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      } else {
        markReverse();
      }
    }
  }

  void markReverse() {
    shouldReverse = true;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        processTapDown();
      },
      onTapUp: (details) {
        processTapUp();
      },
      onVerticalDragEnd: (details) {
        processTapUp();
      },
      onHorizontalDragEnd: (details) {
        processTapUp();
      },
      onTap: widget.onTap,
      child: Container(
          margin: widget.margin,
          child: AnimatedBuilder(
            animation: _shadowTween,
            child: Container(
              height: widget.size.height,
              width: widget.size.width,
              alignment: const Alignment(0, 0),
              margin: const EdgeInsets.all(0),
              padding: widget.padding,
              child: widget.child,
            ),
            builder: (context, child) {
              var customPaint = CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: NeumorphicButtonPainter(
                  animationValue: _animationController.value,
                  accentColor: widget.accentColor,
                  accentAlignment: widget.accentAligment,
                  accentIntensity: widget.accentIntensity > 0
                      ? widget.accentIntensity *
                          (1 - _animationController.value)
                      : 0,
                  blur: 2,
                  borderBlur: 0,
                  color: AppColors.mainColor,
                  gradient: widget.gradient,
                  shape: widget.shape,
                  strokeWidth: 0,
                  shadows: AppColors.currentShadows(
                      blurMultiplier: (_shadowTween.value * 0.5),
                      offsetMultiplier: (_shadowTween.value * 0.5)),
                ),
                child: child,
              );
              if (widget.accentColor == null) {
                return RepaintBoundary(
                  child: customPaint,
                );
              }
              return customPaint;
            },
          )),
    );
  }
}
