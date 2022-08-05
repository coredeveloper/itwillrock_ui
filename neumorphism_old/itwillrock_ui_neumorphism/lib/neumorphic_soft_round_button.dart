import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'constants/text.dart';
import 'constants/colors.dart';
import 'constants/animations.dart';
import 'neumorphic_button_painter.dart';

class NeumorphicSoftRoundButton extends StatefulWidget {
  final ShapeBorder? shape;
  final double margin;
  final double padding;
  final Size? size;
  final Icon? icon;
  final String? text;
  final Color? textColor;
  final VoidCallback? onTap;
  final bool toggle;
  final Color? color;
  final Color accentColor;
  final Alignment accentAligment;
  final double accentIntensity;
  final Gradient? gradient;
  final Duration animationDuration;
  final double elevationMultiplier;
  const NeumorphicSoftRoundButton(
      {this.shape,
      this.animationDuration = genericDuration,
      this.padding = 0,
      this.margin = 0,
      this.icon,
      this.text,
      this.textColor,
      this.size,
      this.color,
      this.gradient,
      this.elevationMultiplier = 1,
      this.accentColor = const Color(0x00FFFFFF),
      this.accentAligment = Alignment.center,
      this.accentIntensity = 0,
      this.onTap,
      this.toggle = false,
      Key? key})
      : super(key: key);

  @override
  _NeumorphicSoftRoundButtonState createState() =>
      _NeumorphicSoftRoundButtonState();
}

class _NeumorphicSoftRoundButtonState extends State<NeumorphicSoftRoundButton>
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
      onTap: widget.onTap,
      child: new Container(
          margin: new EdgeInsets.all(widget.margin),
          child: new AnimatedBuilder(
            animation: _shadowTween,
            child: new Container(
              height: widget.size.height,
              width: widget.size.width,
              alignment: Alignment(0, 0),
              child: widget.text == null
                  ? widget.icon
                  : Text(
                      widget.text,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontFamily: defaultFontFamily,
                          fontSize: 16,
                          color: widget.textColor ?? AppColors.textColor),
                    ),
              margin: new EdgeInsets.all(0),
              padding: new EdgeInsets.all(widget.padding),
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
                  blur: 3,
                  borderBlur: 5,
                  color: widget.color == null
                      ? null
                      : Color.alphaBlend(
                          AppColors.darkShadowColor
                              .withOpacity((1 - _shadowTween.value) / 4),
                          widget.color),
                  gradient: widget.gradient,
                  borderGradient: LinearGradient(
                      stops: [0, 1],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [
                        AppColors.lightShadowColor,
                        AppColors.darkShadowColor,
                      ]),
                  shape: widget.shape,
                  strokeWidth: 2,
                  shadows: AppColors.currentShadows(
                      blurMultiplier: (_shadowTween.value),
                      offsetMultiplier:
                          (_shadowTween.value * widget.elevationMultiplier)),
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
