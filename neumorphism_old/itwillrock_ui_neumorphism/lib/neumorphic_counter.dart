import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flyupline_mobile/constants/distances.dart';
import 'package:flyupline_mobile/widgets/style/neumorphism/neumorphism.dart';
import '../../../constants/colors.dart';
import 'neumorphic_container.dart';
import 'neumorphic_soft_round_button.dart';

class NeumorphicCounter extends StatefulWidget {
  final double borderRadius;
  final double margin;
  final double padding;
  final ValueChanged<int> onChanged;
  final int initialValue;
  final int maxValue;
  final int minValue;
  final int animationDuration;
  NeumorphicCounter(
      {this.initialValue = 0,
      this.maxValue = 10,
      this.minValue = 0,
      this.onChanged,
      this.margin,
      this.borderRadius,
      this.animationDuration,
      this.padding});
  @override
  _NeumorphicCounterState createState() => _NeumorphicCounterState();
}

class _NeumorphicCounterState extends State<NeumorphicCounter> {
  int value;
  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: EdgeInsets.all(widget.padding),
        margin: EdgeInsets.all(widget.margin),
        child: NeumorphicContainer(
          blur: 3,
          gradient: LinearGradient(
            colors: [AppColors.lightShadowColor, AppColors.darkShadowColor],
            stops: [0, 1],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
          padding: 0,
          margin: 0,
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
          child: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                _createButton(Icons.remove, () {
                  if (value > widget.minValue) {
                    _changeValue(value - 1);
                  }
                }),
                Container(
                  alignment: Alignment.center,
                  width: elementWidthOne - widget.padding * 2,
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
        widget.onChanged(value);
      }
    });
  }

  Widget _createButton(IconData icon, Function onPressed) {
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
        stops: [0, 1],
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomRight,
      ),
      size: Size(elementHeightThree, elementHeightThree),
      padding: 0,
      margin: 0,
    );
  }
}
