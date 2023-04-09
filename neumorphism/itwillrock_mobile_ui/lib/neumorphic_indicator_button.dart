import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:itwillrock_mobile_ui/constants/distances.dart';
import '../../../constants/colors.dart';
import 'neumorphic_button_painter.dart';
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

class NeumorphicIndicatorButton extends StatefulWidget {
  final ShapeBorder shape;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double size;
  final Icon icon;
  final ValueChanged<bool>? onChanged;
  final Color color;
  final Color? accentColor;
  final Alignment? accentAligment;
  final double accentIntensity;
  const NeumorphicIndicatorButton(
      {this.shape = const ContinuousRectangleBorder(),
      this.padding = emptyPadding,
      this.margin = emptyMargin,
      required this.icon,
      required this.size,
      this.color = const Color.fromARGB(0, 0, 0, 0),
      this.accentColor,
      this.accentAligment,
      this.accentIntensity = 0,
      this.onChanged,
      Key? key})
      : super(key: key);

  @override
  NeumorphicIndicatorButtonState createState() =>
      NeumorphicIndicatorButtonState();
}

class NeumorphicIndicatorButtonState extends State<NeumorphicIndicatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation _shadowTween;
  late Animation _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 32));

    _shadowTween = Tween(begin: 1.0, end: 0.0).animate(_animationController);
    _colorTween = ColorTween(
            begin: const Color(0x00FFFFFF), end: AppColors.altAccentColor)
        .animate(_animationController);

    super.initState();
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
  }

  void processTap() {
     if(_animationController.lastElapsedDuration?.inSeconds==0)
    {
      return;
    }
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
    return AnimatedBuilder(
        animation: _shadowTween,
        builder: (context, child) => GestureDetector(
              onTap: processTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: widget.margin,
                    child: CustomPaint(
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
                            offsetMultiplier: (_shadowTween.value)),
                      ),
                      child: Container(
                        height: widget.size,
                        width: widget.size,
                        alignment: const Alignment(0, 0),
                        margin: const EdgeInsets.all(0),
                        padding: widget.padding,
                        child: widget.icon,
                      ),
                    ),
                  ),
                  CustomPaint(
                    size: const Size(10, 10),
                    painter: NeumorphicContainerPainter(
                        color: _colorTween.value,
                        borderGradient: const LinearGradient(
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
                    child: const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                  ),
                ],
              ),
            ));
  }
}
