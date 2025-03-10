import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'constants/distances.dart';
import 'constants/text.dart';
import 'constants/colors.dart';
import 'constants/animations.dart';
import 'neumorphic_button_painter.dart';

/// A custom button widget that provides a neumorphic soft round button appearance.
///
/// This widget is stateful and can be used to create buttons with a soft,
/// rounded, and elevated look, which is a common design pattern in neumorphism.
///
/// The button can be customized with various properties to achieve the desired
/// look and feel.
class NeumorphicSoftRoundButton extends StatefulWidget {
  /// The shape of the button.
  final ShapeBorder shape;

  /// The margin around the button.
  final EdgeInsets margin;

  /// The padding inside the button.
  final EdgeInsets padding;

  /// The size of the button.
  final Size size;

  /// The icon to display inside the button.
  final Icon? icon;

  /// The text to display inside the button.
  final String? text;

  /// The color of the text.
  final Color? textColor;

  /// Callback when the button is tapped.
  final VoidCallback? onTap;

  /// Whether the button should toggle its state.
  final bool toggle;

  /// The color of the button.
  final Color color;

  /// The accent color of the button.
  final Color? accentColor;

  /// The alignment of the accent.
  final Alignment? accentAligment;

  /// The intensity of the accent.
  final double accentIntensity;

  /// The gradient to apply to the button.
  final Gradient? gradient;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The elevation multiplier for the button.
  final double elevationMultiplier;

  /// Creates a [NeumorphicSoftRoundButton] widget.
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
      super.key});

  @override
  NeumorphicSoftRoundButtonState createState() =>
      NeumorphicSoftRoundButtonState();
}

/// The state class for the `NeumorphicSoftRoundButton` widget.
///
/// This class is responsible for managing the state and behavior of the
/// `NeumorphicSoftRoundButton` widget, including its appearance and
/// interaction logic.
class NeumorphicSoftRoundButtonState extends State<NeumorphicSoftRoundButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _shadowTween;

  /// Whether the button should reverse its state.
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

  /// Handles the tap down event for the button.
  ///
  /// This method is called when the user presses down on the button.
  /// It can be used to trigger visual feedback or other actions.
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

  /// Handles the tap up event for the button.
  void processTapUp() {
    // if (_animationController.lastElapsedDuration?.inSeconds == 0) {
    //   return;
    // }
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

  /// Marks the animation to reverse.
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
                      AppColors.darkShadowColor.withAlpha(
                          ((1 - _shadowTween.value) * 255 / 4).round()),
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
