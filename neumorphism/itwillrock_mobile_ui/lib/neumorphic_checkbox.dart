import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'constants/distances.dart';
import 'constants/colors.dart';

import 'neumorphic_container.dart';
import 'neumorphic_container_painter.dart';

/// A list of inner shadows used for the Neumorphic Checkbox widget.
///
/// This list defines the shadows that will be applied inside the checkbox
/// to create a neumorphic effect, giving it a 3D appearance.
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

/// A custom switch widget that uses a neumorphic design.
///
/// This widget is a stateful widget that represents a switch with a neumorphic
/// design. It can be toggled on or off, and its appearance will change
/// accordingly.
///
/// The [NeumorphicSwitch] can be used in forms, settings, or anywhere a switch
/// is needed.
///
/// Example usage:
/// ```dart
/// NeumorphicSwitch(
///   value: _isSwitched,
///   onChanged: (newValue) {
///     setState(() {
///       _isSwitched = newValue;
///     });
///   },
/// )
/// ```
///
/// See also:
///  * [Switch], which is a material design switch.
///  * [Checkbox], which is a material design checkbox.
class NeumorphicSwitch extends StatefulWidget {
  /// The border radius of the checkbox.
  ///
  /// This determines the roundness of the corners of the checkbox.
  /// A higher value will result in more rounded corners.
  final double borderRadius;

  /// The margin around the checkbox.
  ///
  /// This property defines the amount of space to be added around the checkbox
  /// widget. It is of type [EdgeInsets] and can be used to create padding
  /// around the checkbox to adjust its position within its parent widget.
  final EdgeInsets margin;

  /// The amount of space to surround the child inside the checkbox.
  ///
  /// This property defines the padding around the checkbox's child widget,
  /// allowing you to control the spacing inside the checkbox.
  final EdgeInsets padding;

  /// A callback that is called when the state of the checkbox changes.
  ///
  /// The callback receives a boolean value indicating whether the checkbox
  /// is checked (`true`) or unchecked (`false`).
  ///
  /// If this is set to `null`, the checkbox will be displayed as disabled.
  final ValueChanged<bool>? onChanged;

  /// A custom switch widget that uses a Neumorphic design.
  ///
  /// This widget is used to create a switch with a Neumorphic appearance,
  /// providing a modern and visually appealing toggle switch.
  ///
  /// The `NeumorphicSwitch` is a constant constructor, meaning its
  /// properties must be compile-time constants.
  const NeumorphicSwitch(
      {this.borderRadius = 0,
      this.padding = emptyPadding,
      this.margin = emptyPadding,
      this.onChanged,
      super.key});

  @override
  CheckBoxState createState() => CheckBoxState();
}

/// A state class for the NeumorphicSwitch widget that manages the state of a custom checkbox.
///
/// This class is responsible for handling the visual representation and interaction logic
/// of the NeumorphicSwitch, which is a custom checkbox styled with neumorphism design principles.
///
/// The state includes properties and methods to manage the checkbox's checked state,
/// handle user interactions, and update the UI accordingly.
class CheckBoxState extends State<NeumorphicSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  late Animation _positionTween;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _colorTween = ColorTween(
            begin: const Color(0x00FFFFFF), end: AppColors.altAccentColor)
        .animate(_animationController);

    _positionTween = Tween(begin: -1.0, end: 1.0).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  /// Switches the state of the checkbox to the given value.
  ///
  /// This method updates the checkbox to reflect the provided [value].
  ///
  /// [value] - The new state of the checkbox. If `true`, the checkbox will be checked;
  /// if `false`, the checkbox will be unchecked.
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

  /// Aligns the switch to its designated position.
  ///
  /// This method is responsible for adjusting the alignment of the switch
  /// within its parent container or layout. It ensures that the switch is
  /// positioned correctly based on the current layout constraints and
  /// alignment settings.
  ///
  /// Usage:
  /// ```dart
  /// alignSwitch();
  /// ```
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
