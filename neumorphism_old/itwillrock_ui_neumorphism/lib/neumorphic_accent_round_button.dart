import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import '../../../constants/colors.dart';
import 'neumorphic_button_painter.dart';

typedef AccentButtonCallback = void Function(double intensity);

class NeumorphicAccentRoundButton extends StatefulWidget {
  final ShapeBorder shape;
  final double margin;
  final double padding;
  final Size size;
  final Widget child;
  final VoidCallback onTap;
  final AccentButtonCallback accentChanged;
  final bool toggle;
  final Color color;
  final int animationDuration;
  NeumorphicAccentRoundButton(
      {this.shape,
      this.animationDuration,
      this.padding,
      this.margin,
      this.child,
      this.size,
      this.color,
      this.onTap,
      this.accentChanged,
      this.toggle});

  @override
  _NeumorphicAccentRoundButtonState createState() =>
      _NeumorphicAccentRoundButtonState();
}

class _NeumorphicAccentRoundButtonState
    extends State<NeumorphicAccentRoundButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _shadowTween;
  bool shouldReverse = false;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));

    _shadowTween = Tween(begin: 1.0, end: 0.0).animate(_animationController);

    if (widget.accentChanged != null) {
      _animationController.addListener(() {
        widget.accentChanged(1 - _animationController.value);
      });
    }

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
    super.dispose();
    _animationController.dispose();
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
          builder: (context, child) => new CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: NeumorphicButtonPainter(
              animationValue: _animationController.value,
              blur: 5 - 5 * _shadowTween.value,
              color: Color.alphaBlend(
                  AppColors.darkShadowColor
                      .withOpacity((1 - _shadowTween.value) / 4),
                  widget.color),
              borderGradient: LinearGradient(
                  stops: [.5, 2],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [
                    AppColors.lightShadowColor.withOpacity(_shadowTween.value),
                    AppColors.darkShadowColor
                        .withOpacity(_shadowTween.value / 3),
                  ]),
              shape: widget.shape,
              strokeWidth: 0,
              shadows: [
                Shadow(
                  color: widget.color.withOpacity(0.6),
                  blurRadius: 16 * _shadowTween.value,
                  offset: Offset(0, 4 * _shadowTween.value),
                ),
              ],
            ),
            child: new Container(
              height: widget.size.height,
              width: widget.size.width,
              alignment: Alignment(0, 0),
              child: widget.child,
              margin: new EdgeInsets.all(0),
              padding: new EdgeInsets.all(widget.padding),
            ),
          ),
        ),
      ),
    );
  }
}
