import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'constants/distances.dart';
import 'constants/text.dart';
import 'constants/colors.dart';
import 'constants/animations.dart';
import 'neumorphic_button_painter.dart';

class NeumorphicSoftRoundButton extends StatefulWidget {
  final ShapeBorder shape;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Size size;
  final Icon? icon;
  final String? text;
  final Color? textColor;
  final VoidCallback? onTap;
  final bool toggle;
  final Color color;
  final Color? accentColor;
  final Alignment? accentAligment;
  final double accentIntensity;
  final Gradient? gradient;
  final Duration animationDuration;
  final double elevationMultiplier;
  const NeumorphicSoftRoundButton(
      {this.shape = const ContinuousRectangleBorder(),
      this.animationDuration = genericDuration,
      this.padding = emptyPadding,
      this.margin = emptyMargin,
      this.icon,
      this.text,
      this.textColor,
      this.size = const Size(elementWidthOne, elementHeightOne),
      this.color = const Color.fromARGB(0, 0, 0, 0),
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
  NeumorphicSoftRoundButtonState createState() =>
      NeumorphicSoftRoundButtonState();
}

class NeumorphicSoftRoundButtonState extends State<NeumorphicSoftRoundButton>
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
              child: widget.text == null
                  ? widget.icon
                  : Text(
                      widget.text!,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontFamily: defaultFontFamily,
                          fontSize: 16,
                          color: widget.textColor ?? AppColors.textColor),
                    ),
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
                  blur: 3,
                  borderBlur: 5,
                  color: Color.alphaBlend(
                      AppColors.darkShadowColor
                          .withOpacity((1 - _shadowTween.value) / 4),
                      widget.color),
                  gradient: widget.gradient,
                  borderGradient: LinearGradient(
                      stops: const [0, 1],
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
