import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'constants/distances.dart';
import 'constants/colors.dart';
import 'neumorphic_button_painter.dart';

typedef AccentButtonCallback = void Function(double intensity);

class NeumorphicAccentRoundButton extends StatefulWidget {
  final ShapeBorder shape;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Size size;
  final Widget? child;
  final VoidCallback? onTap;
  final AccentButtonCallback? accentChanged;
  final bool toggle;
  final Color color;
  final Duration animationDuration;
  const NeumorphicAccentRoundButton(
      {this.shape = const ContinuousRectangleBorder(),
      this.animationDuration = Duration.zero,
      this.padding = emptyPadding,
      this.margin = emptyMargin,
      this.child,
      this.size = const Size(0, 0),
      this.color = const Color.fromARGB(0, 0, 0, 0),
      this.onTap,
      this.accentChanged,
      this.toggle = false,
      super.key});

  @override
  NeumorphicAccentRoundButtonState createState() =>
      NeumorphicAccentRoundButtonState();
}

class NeumorphicAccentRoundButtonState
    extends State<NeumorphicAccentRoundButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _shadowTween;
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
                blur: 5.0 - 5.0 * _shadowTween.value,
                color: Color.alphaBlend(
                    AppColors.darkShadowColor.withAlpha((255 * ((1 - _shadowTween.value) / 4)).round()),
                    widget.color),
                borderGradient: LinearGradient(
                    stops: const [.5, 2],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors: [
                        AppColors.lightShadowColor
                          .withAlpha((255 * _shadowTween.value).round()),
                        AppColors.darkShadowColor
                          .withAlpha((255 * (_shadowTween.value / 3)).round()),
                    ]),
                shape: widget.shape,
                strokeWidth: 0,
                shadows: [
                  Shadow(
                    color: widget.color.withAlpha((0.6 * 255).toInt()),
                    blurRadius: 16.0 * _shadowTween.value,
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
