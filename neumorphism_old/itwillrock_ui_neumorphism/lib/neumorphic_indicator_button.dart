import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../../constants/colors.dart';
import 'neumorphic_button_painter.dart';
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

class NeumorphicIndicatorButton extends StatefulWidget {
  final ShapeBorder shape;
  final double margin;
  final double padding;
  final double size;
  final Icon icon;
  final ValueChanged<bool> onChanged;
  final Color color;
  final Color accentColor;
  final Alignment accentAligment;
  final double accentIntensity;
  NeumorphicIndicatorButton(
      {this.shape,
      this.padding,
      this.margin,
      this.icon,
      this.size,
      this.color,
      this.accentColor,
      this.accentAligment,
      this.accentIntensity,
      this.onChanged});

  @override
  _NeumorphicIndicatorButtonState createState() =>
      _NeumorphicIndicatorButtonState();
}

class _NeumorphicIndicatorButtonState extends State<NeumorphicIndicatorButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation _shadowTween;
  Animation _colorTween;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 32));

    _shadowTween = Tween(begin: 1.0, end: 0.0).animate(_animationController);
    _colorTween =
        ColorTween(begin: Color(0x00FFFFFF), end: AppColors.altAccentColor)
            .animate(_animationController);

    super.initState();
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
  }

  void processTap() {
    if (_animationController.status == AnimationStatus.completed) {
      HapticFeedback.selectionClick();
      switchTo(false);
    } else {
      switchTo(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
        animation: _shadowTween,
        builder: (context, child) => new GestureDetector(
              onTap: processTap,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.all(widget.margin),
                    child: new CustomPaint(
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
                        color: Color.alphaBlend(
                            AppColors.darkShadowColor
                                .withOpacity((1 - _shadowTween.value) / 4),
                            widget.color),
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
                            offsetMultiplier: (_shadowTween.value)),
                      ),
                      child: new Container(
                        height: widget.size,
                        width: widget.size,
                        alignment: Alignment(0, 0),
                        child: widget.icon,
                        margin: new EdgeInsets.all(0),
                        padding: new EdgeInsets.all(widget.padding),
                      ),
                    ),
                  ),
                  new CustomPaint(
                    child: new Container(
                      width: 10,
                      height: 10,
                    ),
                    size: Size(10, 10),
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
                            borderRadius: BorderRadius.circular(5)),
                        strokeWidth: 0.5,
                        innerShadows: innerShadows),
                  ),
                ],
              ),
            ));
  }
}
