import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'constants/distances.dart';
import '../../../constants/colors.dart';
import 'neumorphic_button_painter.dart';
import 'neumorphic_container_painter.dart';

/// Default inner shadows for the indicator dot
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

/// A neumorphic button with an indicator dot that shows active state
class NeumorphicIndicatorButton extends StatefulWidget {
  /// The shape of the button border
  final ShapeBorder shape;

  /// Outer margin around the button
  final EdgeInsets margin;

  /// Inner padding within the button
  final EdgeInsets padding;

  /// Size of the button (width and height)
  final double size;

  /// Icon displayed in the center of the button
  final Icon icon;

  /// Callback when the button state changes
  final ValueChanged<bool>? onChanged;

  /// Background color of the button
  final Color color;

  /// Color of the accent glow effect
  final Color? accentColor;

  /// Position of the accent glow
  final Alignment? accentAlignment;

  /// Intensity of the accent glow (0.0 to 1.0)
  final double accentIntensity;

  /// Creates a neumorphic indicator button
  const NeumorphicIndicatorButton(
      {this.shape = const ContinuousRectangleBorder(),
      this.padding = emptyPadding,
      this.margin = emptyMargin,
      required this.icon,
      required this.size,
      this.color = const Color.fromARGB(0, 0, 0, 0),
      this.accentColor,
      this.accentAlignment,
      this.accentIntensity = 0,
      this.onChanged,
      super.key});

  @override
  NeumorphicIndicatorButtonState createState() =>
      NeumorphicIndicatorButtonState();
}

/// State for [NeumorphicIndicatorButton]
class NeumorphicIndicatorButtonState extends State<NeumorphicIndicatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation _shadowTween;
  late Animation _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));

    _shadowTween = Tween(begin: 1.0, end: 0.0).animate(_animationController);
    _colorTween = ColorTween(
            begin: const Color(0x00FFFFFF), end: AppColors.altAccentColor)
        .animate(_animationController);

    super.initState();
  }

  /// Programmatically switches the button to the given state
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

  /// Handles tap gesture and toggles button state
  void processTap() {
    if (_animationController.lastElapsedDuration?.inSeconds == 0) {
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
                        accentAlignment: widget.accentAlignment,
                        accentIntensity: widget.accentIntensity > 0
                            ? widget.accentIntensity *
                                (1 - _animationController.value)
                            : 0,
                        blur: 3,
                        borderBlur: 5,
                        color: Color.alphaBlend(
                            AppColors.darkShadowColor.withAlpha(
                                ((1 - _shadowTween.value) / 4 * 255).toInt()),
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
