import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'constants/distances.dart';
import 'constants/colors.dart';

import 'neumorphic_container.dart';
import 'neumorphic_container_painter.dart';

const innerShadows = [
  Shadow(
    color: Color(0x30000000),
    blurRadius: 2,
    offset: Offset(2, 2),
  ),
  Shadow(
    color: Color(0x20FFFFFF),
    blurRadius: 2,
    offset: Offset(-2, -2),
  ),
];

class NeumorphicSwitch extends StatefulWidget {
  final double borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final ValueChanged<bool>? onChanged;
  const NeumorphicSwitch(
      {this.borderRadius = 0,
      this.padding = emptyPadding,
      this.margin = emptyPadding,
      this.onChanged,
      super.key});

  @override
  CheckBoxState createState() => CheckBoxState();
}

class CheckBoxState extends State<NeumorphicSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  late Animation _positionTween;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _colorTween =
        ColorTween(begin: const Color(0x00FFFFFF), end: AppColors.altAccentColor)
            .animate(_animationController);

    _positionTween = Tween(begin: -1.0, end: 1.0).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void switchTo(bool value) {
    if (value) {
      _animationController.forward();
      if (widget.onChanged != null) {
        widget.onChanged!(true);
      }
    } else {
      _animationController.reverse();
      if (widget.onChanged != null) {
        widget.onChanged!(false);
      }
    }
    HapticFeedback.selectionClick();
  }

  void alignSwitch() {
    if (_animationController.value > 0.5) {
      switchTo(true);
    } else {
      switchTo(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) => GestureDetector(
              onHorizontalDragUpdate: (details) {
                _animationController.animateTo(details.localPosition.dx / 64);
              },
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity == null) {
                  return;
                }
                if (details.primaryVelocity! < 1 &&
                    details.primaryVelocity! > -1) {
                  alignSwitch();
                } else {
                  if (details.primaryVelocity! > 0) {
                    switchTo(true);
                  } else {
                    switchTo(false);
                  }
                }
              },
              onTap: () {
                if (_animationController.lastElapsedDuration?.inSeconds == 0) {
                  return;
                }
                if (_animationController.isCompleted) {
                  switchTo(false);
                } else {
                  switchTo(true);
                }
              },
              child: RepaintBoundary(
                child: Container(
                  padding: widget.padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      NeumorphicContainer(
                        blur: 3,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.lightShadowColor,
                            AppColors.darkShadowColor
                          ],
                          stops: const [0, 1],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                        ),
                        padding: const EdgeInsets.all(0),
                        margin: widget.margin,
                        shadows: const <Shadow>[],
                        innerShadows: [
                          Shadow(
                            color: AppColors.darkShadowColor,
                            blurRadius: 2,
                            offset: const Offset(2, 2),
                          ),
                          Shadow(
                            color: AppColors.lightShadowColor,
                            blurRadius: 2,
                            offset: const Offset(-2, -2),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(widget
                                    .borderRadius +
                                (widget.padding.left + widget.padding.right) /
                                    4)),
                        child: Container(
                          height: elementHeightThree,
                          width: elementWidthThree +
                              widget.padding.left +
                              widget.padding.right,
                          alignment: Alignment(_positionTween.value, 0),
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          child: NeumorphicContainer(
                            accentColor: _colorTween.value,
                            accentAligment: Alignment.centerRight,
                            accentIntensity: _positionTween.value,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.darkShadowColor,
                                AppColors.lightShadowColor,
                              ],
                              stops: const [0, 1],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight,
                            ),
                            blur: 0,
                            shadows: AppColors.currentShadows(
                                blurMultiplier: 0.2, offsetMultiplier: 0.2),
                            padding: const EdgeInsets.all(0),
                            margin: const EdgeInsets.all(0),
                            innerShadows: const <Shadow>[],
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(widget.borderRadius)),
                            child: const SizedBox(
                              width: elementHeightThree,
                              height: elementHeightThree,
                            ),
                          ),
                        ),
                      ),
                      CustomPaint(
                        painter: NeumorphicContainerPainter(
                            color: _colorTween.value,
                            borderGradient: AppColors.shadowGradient,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    elementHeightOne / 4)),
                            strokeWidth: 0.5,
                            innerShadows: innerShadows),
                        child: const SizedBox(
                          width: elementHeightOne / 2,
                          height: elementHeightOne / 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
