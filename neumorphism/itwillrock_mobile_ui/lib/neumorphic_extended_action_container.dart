import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../../constants/colors.dart';

import 'neumorphic_button_painter.dart';

/// A neumorphic container with extended action effects.
///
/// The [NeumorphicExtendedActionContainer] widget displays a container with neumorphic
/// action effects. It uses [NeumorphicButtonPainter] to paint the container.
class NeumorphicExtendedActionContainer extends StatefulWidget {
  /// The shape of the container.
  final ShapeBorder shape;

  /// The margin around the container.
  final EdgeInsets margin;

  /// The padding inside the container.
  final EdgeInsets padding;

  /// The size of the container.
  final Size size;

  /// The child widget to display inside the container.
  final Widget? child;

  /// Callback when the container is tapped.
  final VoidCallback? onTap;

  /// Whether the container should toggle its state.
  final bool toggle;

  /// The color of the container.
  final Color color;

  /// The accent color of the container.
  final Color? accentColor;

  /// The alignment of the accent.
  final Alignment? accentAligment;

  /// The intensity of the accent.
  final double accentIntensity;

  /// The gradient to apply to the container.
  final Gradient? gradient;

  /// The duration of the animation.
  final Duration animationDuration;

  /// Creates a [NeumorphicExtendedActionContainer] widget.
  ///
  /// The [shape], [animationDuration], [padding], [margin], [size], [color], and [toggle]
  /// arguments must not be null.
  const NeumorphicExtendedActionContainer({
    this.shape = const ContinuousRectangleBorder(),
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
    super.key,
  });

  @override
  NeumorphicExtendedActionContainerState createState() =>
      NeumorphicExtendedActionContainerState();
}

/// The state for a [NeumorphicExtendedActionContainer] widget.
class NeumorphicExtendedActionContainerState
    extends State<NeumorphicExtendedActionContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _shadowTween;

  /// Indicates whether the action should be reversed.
  ///
  /// When set to `true`, the action will be performed in reverse order.
  /// Defaults to `false`.
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

  /// Processes the tap down event.
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
