import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../../constants/colors.dart';
import 'neumorphic_button_painter.dart';

class NeumorphicActionContainer extends StatefulWidget {
  final ShapeBorder shape;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Size size;
  final Widget child;
  final VoidCallback onTap;
  final bool toggle;
  final Color color;
  final Color accentColor;
  final Alignment accentAligment;
  final double accentIntensity;
  final Gradient gradient;
  final int animationDuration;
  NeumorphicActionContainer(
      {this.shape,
      this.animationDuration,
      this.padding,
      this.margin,
      this.child,
      this.size,
      this.color,
      this.gradient,
      this.accentColor,
      this.accentAligment,
      this.accentIntensity,
      this.onTap,
      this.toggle});

  @override
  _NeumorphicActionContainerState createState() =>
      _NeumorphicActionContainerState();
}

class _NeumorphicActionContainerState extends State<NeumorphicActionContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation _shadowTween;
  bool shouldReverse = false;
  @override
  void initState() {
    _animationController = AnimationController(
        animationBehavior: AnimationBehavior.preserve,
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));

    _shadowTween = Tween(begin: 1.0, end: 0.0).animate(_animationController);
    AnimationStatusListener listner = (status) {
      if (_animationController.status == AnimationStatus.completed &&
          shouldReverse) {
        _animationController.reverse();
        shouldReverse = false;
      }
    };
    _animationController.addStatusListener(listner);
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
    return new GestureDetector(
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
      child: new Container(
          margin: widget.margin,
          child: new AnimatedBuilder(
            animation: _shadowTween,
            child: new Container(
              height: widget.size.height,
              width: widget.size.width,
              alignment: Alignment(0, 0),
              child: widget.child,
              margin: new EdgeInsets.all(0),
              padding: widget.padding,
            ),
            builder: (context, child) {
              var customPaint = new CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: NeumorphicButtonPainter(
                  animationValue: _animationController.value,
                  accentColor: widget.accentColor,
                  accentAlignment: widget.accentAligment,
                  accentIntensity: widget.accentIntensity != null
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
