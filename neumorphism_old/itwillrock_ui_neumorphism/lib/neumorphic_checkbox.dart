import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flyupline_mobile/constants/distances.dart';
import '../../../constants/colors.dart';

import 'neumorphic_container.dart';
import 'neumorphic_container_painter.dart';

final innerShadows = const [
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

class NeumorphicCheckBox extends StatefulWidget {
  final double borderRadius;
  final double margin;
  final double padding;
  final ValueChanged<bool> onChanged;
  NeumorphicCheckBox({
    this.borderRadius,
    this.padding,
    this.margin,
    this.onChanged,
  });

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<NeumorphicCheckBox>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;
  Animation _positionTween;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _colorTween =
        ColorTween(begin: Color(0x00FFFFFF), end: AppColors.altAccentColor)
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
        widget.onChanged(true);
      }
    } else {
      _animationController.reverse();
      if (widget.onChanged != null) {
        widget.onChanged(false);
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
        builder: (context, child) => new GestureDetector(
              onHorizontalDragUpdate: (details) {
                _animationController.animateTo(details.localPosition.dx / 64);
              },
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity < 1 &&
                    details.primaryVelocity > -1) {
                  alignSwitch();
                } else {
                  if (details.primaryVelocity > 0) {
                    switchTo(true);
                  } else {
                    switchTo(false);
                  }
                }
              },
              onTap: () {
                if (_animationController.isCompleted) {
                  switchTo(false);
                } else {
                  switchTo(true);
                }
              },
              child: RepaintBoundary(
                child: Container(
                  padding: EdgeInsets.all(widget.padding),
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
                          stops: [0, 1],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                        ),
                        padding: 0,
                        margin: widget.margin,
                        shadows: null,
                        innerShadows: [
                          Shadow(
                            color: AppColors.darkShadowColor,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          ),
                          Shadow(
                            color: AppColors.lightShadowColor,
                            blurRadius: 2,
                            offset: Offset(-2, -2),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                widget.borderRadius + widget.padding / 2)),
                        child: new Container(
                          height: elementHeightThree,
                          width: elementWidthThree + widget.padding * 2,
                          alignment: Alignment(_positionTween.value, 0),
                          margin: new EdgeInsets.all(0),
                          padding: new EdgeInsets.all(0),
                          child: new NeumorphicContainer(
                            accentColor: _colorTween.value,
                            accentAligment: Alignment.centerRight,
                            accentIntensity: _positionTween.value,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.darkShadowColor,
                                AppColors.lightShadowColor,
                              ],
                              stops: [0, 1],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight,
                            ),
                            blur: 0,
                            shadows: AppColors.currentShadows(
                                blurMultiplier: 0.2, offsetMultiplier: 0.2),
                            padding: 0,
                            margin: 0,
                            innerShadows: null,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(widget.borderRadius)),
                            child: Container(
                              width: elementHeightThree,
                              height: elementHeightThree,
                            ),
                          ),
                        ),
                      ),
                      CustomPaint(
                        child: Container(
                          width: elementHeightOne / 2,
                          height: elementHeightOne / 2,
                        ),
                        painter: new NeumorphicContainerPainter(
                            color: _colorTween.value,
                            borderGradient: LinearGradient(
                                stops: [0.1, 0.76, 1],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight,
                                colors: [
                                  Color(0xA0FFFFFF),
                                  Color(0x10FFFFFF),
                                  Color(0x51000000),
                                ]),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    elementHeightOne / 4)),
                            strokeWidth: 0.5,
                            innerShadows: innerShadows),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
