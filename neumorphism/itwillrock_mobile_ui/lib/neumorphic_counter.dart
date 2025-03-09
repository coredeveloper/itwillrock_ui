import 'package:flutter/material.dart';
import 'constants/distances.dart';
import 'constants/colors.dart';
import 'neumorphic_container.dart';
import 'neumorphic_soft_round_button.dart';
import 'neumorphism.dart';

class NeumorphicCounter extends StatefulWidget {
  final double borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final ValueChanged<int>? onChanged;
  final int initialValue;
  final int maxValue;
  final int minValue;
  final Duration animationDuration;
  const NeumorphicCounter(
      {this.initialValue = 0,
      this.maxValue = 10,
      this.minValue = 0,
      this.onChanged,
      this.margin = emptyMargin,
      this.borderRadius = 0,
      this.animationDuration = Duration.zero,
      this.padding = emptyPadding,
      super.key});
  @override
  NeumorphicCounterState createState() => NeumorphicCounterState();
}

class NeumorphicCounterState extends State<NeumorphicCounter> {
  int value = 0;
  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: widget.padding,
        margin: widget.margin,
        child: NeumorphicContainer(
          blur: 3,
          gradient: LinearGradient(
            colors: [AppColors.lightShadowColor, AppColors.darkShadowColor],
            stops: const [0, 1],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
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
              borderRadius: BorderRadius.circular(widget.borderRadius +
                  (widget.padding.left + widget.padding.right / 2) / 2)),
          child: Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                _createButton(Icons.remove, () {
                  if (value > widget.minValue) {
                    _changeValue(value - 1);
                  }
                }),
                Container(
                  alignment: Alignment.center,
                  width: elementWidthOne -
                      widget.padding.left -
                      widget.padding.right,
                  child: Neumorphism.text(value.toString()),
                ),
                _createButton(Icons.add, () {
                  if (value < widget.maxValue) {
                    _changeValue(value + 1);
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeValue(int val) {
    setState(() {
      value = val;
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    });
  }

  Widget _createButton(IconData icon, VoidCallback? onPressed) {
    return NeumorphicSoftRoundButton(
      toggle: false,
      icon: Neumorphism.icon(icon),
      onTap: onPressed,
      animationDuration: widget.animationDuration,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius)),
      gradient: LinearGradient(
        colors: [
          AppColors.darkShadowColor,
          AppColors.lightShadowColor,
        ],
        stops: const [0, 1],
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomRight,
      ),
      size: const Size(elementHeightThree, elementHeightThree),
      padding: emptyPadding,
      margin: emptyMargin,
    );
  }
}
