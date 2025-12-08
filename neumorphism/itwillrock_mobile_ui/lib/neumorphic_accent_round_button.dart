import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'constants/distances.dart';
import 'constants/colors.dart';
import 'neumorphic_button_painter.dart';

/// A callback function type definition for accent button actions.
///
/// This callback is triggered when an accent button is pressed, providing
/// the intensity of the press as a [double] value.
///
/// The [intensity] parameter represents the force or pressure of the button press.
typedef AccentButtonCallback = void Function(double intensity);

/// A neumorphic round button with accent effects.
///
/// The [NeumorphicAccentRoundButton] widget displays a round button with neumorphic
/// accent effects. It uses [NeumorphicButtonPainter] to paint the button.
class NeumorphicAccentRoundButton extends StatefulWidget {
  /// The shape of the button.
  final ShapeBorder shape;

  /// The margin around the button.
  final EdgeInsets margin;

  /// The padding inside the button.
  final EdgeInsets padding;

  /// The size of the button.
  final Size size;

  /// The child widget to display inside the button.
  final Widget? child;

  /// Callback when the button is tapped.
  final VoidCallback? onTap;

  /// Callback when the accent changes.
  final AccentButtonCallback? accentChanged;

  /// Whether the button should toggle its state.
  final bool toggle;

  /// The color of the button.
  final Color color;

  /// The duration of the animation.
  final Duration animationDuration;

  /// Creates a [NeumorphicAccentRoundButton] widget.
  ///
  /// The [shape], [animationDuration], [padding], [margin], [size], [color], and [toggle]
  /// arguments must not be null.
  const NeumorphicAccentRoundButton({
    this.shape = const ContinuousRectangleBorder(),
    this.animationDuration = Duration.zero,
    this.padding = emptyPadding,
    this.margin = emptyMargin,
    this.child,
    this.size = const Size(0, 0),
    this.color = const Color.fromARGB(0, 0, 0, 0),
    this.onTap,
    this.accentChanged,
    this.toggle = false,
    super.key,
  });

  @override
  NeumorphicAccentRoundButtonState createState() =>
      NeumorphicAccentRoundButtonState();
}

/// The state for a [NeumorphicAccentRoundButton] widget.
class NeumorphicAccentRoundButtonState
    extends State<NeumorphicAccentRoundButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _shadowTween;

  /// Indicates whether the action should be reversed.
  ///
  /// When set to `true`, the action will be performed in the reverse order.
  /// Defaults to `false`.
  bool shouldReverse = false;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.animationDuration);

    _shadowTween = Tween(begin: 1.0, end: 0.0).animate(_animationController);

    if (widget.accentChanged != null) {
      _animationController.addListener(() {
        widget.accentChanged!(1 - _animationController.value);
      });
    }
    _animationController.addStatusListener((status) {
      if (_animationController.status == AnimationStatus.completed &&
          shouldReverse) {
        _animationController.reverse();
        shouldReverse = false;
      }
    });
    super.initState();
  }

  /// Processes the tap down event.
  void processTapDown() {
    HapticFeedback.selectionClick();
    if (widget.toggle) {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    } else {
      _animationController.forward();
    }
  }

  /// Processes the tap up event.
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

  /// Marks the animation to reverse.
  void markReverse() {
    shouldReverse = true;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
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
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _shadowTween,
            builder: (context, child) => CustomPaint(
              size: const Size(double.infinity, double.infinity),
              painter: NeumorphicButtonPainter(
                animationValue: _animationController.value,
                blur: 0,
                color: widget.color,
                borderGradient: LinearGradient(
                    stops: const [0, 1],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors: [
                      AppColors.lightShadowColor
                          .withAlpha((128 * _shadowTween.value).round()),
                      AppColors.darkShadowColor
                          .withAlpha((64 * _shadowTween.value).round()),
                    ]),
                shape: widget.shape,
                strokeWidth: 0,
                shadows: [
                  Shadow(
                    color: widget.color.withAlpha((0.5 * 255).toInt()),
                    blurRadius: 12.0 * _shadowTween.value,
                    offset: Offset(0, 4.0 * _shadowTween.value),
                  ),
                ],
              ),
              child: Container(
                height: widget.size.height,
                width: widget.size.width,
                alignment: const Alignment(0, 0),
                margin: const EdgeInsets.all(0),
                padding: widget.padding,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
