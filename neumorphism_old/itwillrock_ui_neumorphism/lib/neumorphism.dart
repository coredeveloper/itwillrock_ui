import 'package:flutter/material.dart';
import '../../../constants/text.dart';
import '../../../constants/distances.dart';
import '../../../constants/colors.dart';
import 'menu/menu_button.dart';
import 'menu/back_button.dart' as Menu;
import 'neumorphic_counter.dart';
import 'neumorphic_indicator_button.dart';
import 'neumorphic_accent_round_button.dart';
import 'neumorphic_soft_round_button.dart';
import 'neumorphic_action_container.dart';
import 'neumorphic_extended_action_container.dart';
import 'gradient_input_border.dart';
import 'neumorphic_container.dart';
import 'neumorphic_checkbox.dart';
import 'neumorphic_accent_list.dart';

class Neumorphism {
  static int animationDuration = 64;
  static double borderRadius = 24;

  static Widget accentList(
          {List<String> items,
          double padding = paddingStepOne,
          ValueChanged<String> onItemSelected,
          String selectedItem,
          double margin = paddingStepOne}) =>
      new NeumorphicAccentList(
          padding: padding,
          color: AppColors.accentColor,
          textColor: AppColors.textColor,
          selectedItem: selectedItem,
          onItemSelected: onItemSelected,
          margin: margin,
          items: items);

  static Widget menuButton({
    double margin = paddingStepOne,
    double animationStep = 0,
  }) =>
      new MenuButton(
          size: 24, color: AppColors.accentColor, animationStep: animationStep);

  static Widget backButton({GestureTapCallback onTap}) => new Menu.BackButton(
        size: 24.0,
        onTap: onTap,
      );

  static InputDecoration inputDecoration({
    String label,
    String hint,
    Widget icon,
    Color color,
    TextInputType inputType,
    bool filled = true,
  }) =>
      new InputDecoration(
          hintStyle: new TextStyle(color: AppColors.textColor),
          suffixIcon: icon,
          suffixStyle: new TextStyle(color: AppColors.textColor),
          prefixStyle: new TextStyle(color: AppColors.textColor),
          filled: filled,
          fillColor: AppColors.mainColor,
          labelText: label,
          hintText: hint,
          border: new GradientOutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ));

  static Widget container(
          {Widget child,
          double width = double.infinity,
          double height = double.infinity,
          bool dropShadow = true,
          bool dropInnerShadow = false,
          double padding = paddingStepOne,
          double margin = paddingStepOne,
          bool renderAccent = false,
          Alignment accentAligment,
          double accentIntensity}) =>
      new NeumorphicContainer(
        margin: margin,
        padding: padding,
        child: child,
        blur: 0,
        borderBlur: 3,
        accentAligment: renderAccent ? accentAligment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : null,
        shadows: dropShadow ? AppColors.currentShadows() : null,
        innerShadows: dropInnerShadow ? AppColors.currentInnerShadows() : null,
        borderGradient: LinearGradient(
            stops: [0, 1],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              AppColors.lightShadowColor,
              AppColors.darkShadowColor,
            ]),
        gradient: LinearGradient(
          colors: [AppColors.lightShadowColor, AppColors.darkShadowColor],
          stops: [0, 1],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
      );

  static Widget dropDownFormField<T>(
          {T value,
          TextEditingController controller,
          FormFieldValidator<String> validator,
          String hint,
          Icon icon,
          bool obscureText = false,
          TextInputType inputType = TextInputType.text,
          ValueChanged<T> onChanged,
          List<T> items,
          double padding = paddingStepOne,
          double margin = paddingStepOne}) =>
      Container(
          padding: new EdgeInsets.all(padding),
          margin: new EdgeInsets.all(margin),
          child: DropdownButtonFormField<T>(
            dropdownColor: AppColors.mainColor,
            elevation: 0,
            decoration: inputDecoration(),
            isExpanded: true,
            value: value,
            icon: Icon(
              Icons.arrow_downward,
              color: AppColors.textColor,
            ),
            style: TextStyle(color: AppColors.textColor),
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<T>>((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ));

  static Widget textFormField(
          {String label,
          TextEditingController controller,
          FormFieldValidator<String> validator,
          String hint,
          Icon icon,
          bool obscureText = false,
          TextInputType inputType = TextInputType.text,
          double padding = paddingStepOne,
          double margin = paddingStepOne}) =>
      new Container(
        padding: new EdgeInsets.all(padding),
        margin: new EdgeInsets.all(margin),
        child: new TextFormField(
          textDirection: TextDirection.ltr,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: inputType,
          style: TextStyle(
            fontFamily: defaultFontFamily,
            color: AppColors.textColor,
          ),
          decoration: inputDecoration(label: label, hint: hint, icon: icon),
        ),
      );

  static Widget passwordFormField(
          {String label,
          String hint,
          Icon icon,
          double padding = paddingStepOne,
          double margin = paddingStepOne}) =>
      new Container(
        padding: new EdgeInsets.all(padding),
        margin: new EdgeInsets.all(margin),
        child: new TextFormField(
          style: TextStyle(
            fontFamily: defaultFontFamily,
            color: AppColors.textColor,
          ),
          decoration: inputDecoration(label: label, hint: hint, icon: icon),
        ),
      );

  static Widget actionContainer(
          {Widget child,
          Size size = const Size(double.infinity, 48),
          ShapeBorder shape,
          bool main = false,
          bool toggle = false,
          EdgeInsets padding,
          EdgeInsets margin,
          VoidCallback onTap,
          bool renderAccent = false,
          Alignment accentAligment,
          double accentIntensity}) =>
      new NeumorphicActionContainer(
        animationDuration: animationDuration,
        accentAligment: renderAccent ? accentAligment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : null,
        onTap: onTap,
        child: child,
        size: size,
        color: main ? null : AppColors.mainColor,
        gradient: main ? AppColors.mainGradient : null,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: padding,
        margin: margin,
        toggle: toggle,
      );

  static Widget extendedActionContainer(
          {Widget child,
          Size size = const Size(double.infinity, 48),
          ShapeBorder shape,
          bool main = false,
          bool toggle = false,
          EdgeInsets padding,
          EdgeInsets margin,
          VoidCallback onTap,
          bool renderAccent = false,
          Alignment accentAligment,
          double accentIntensity}) =>
      new NeumorphicExtendedActionContainer(
        animationDuration: animationDuration,
        accentAligment: renderAccent ? accentAligment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : null,
        onTap: onTap,
        child: child,
        size: size,
        color: main ? null : AppColors.mainColor,
        gradient: main ? AppColors.mainGradient : null,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: padding,
        margin: margin,
        toggle: toggle,
      );

  static Widget softRoundButton(
          {Icon icon,
          String text,
          Size size = const Size(96, 96),
          ShapeBorder shape,
          bool main = false,
          bool toggle = false,
          double padding = paddingStepOne,
          double margin = paddingStepOne,
          VoidCallback onTap,
          bool renderAccent = false,
          Alignment accentAligment,
          double elevationMultiplier = 1,
          double accentIntensity}) =>
      new NeumorphicSoftRoundButton(
        animationDuration: animationDuration,
        accentAligment: renderAccent ? accentAligment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : null,
        onTap: onTap,
        icon: icon,
        text: text,
        elevationMultiplier: elevationMultiplier,
        textColor: main ? AppColors.altTextColor : null,
        size: size,
        color: main ? null : AppColors.mainColor,
        gradient: main ? AppColors.mainGradient : null,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
        padding: padding,
        margin: margin,
        toggle: toggle,
      );

  static Widget indicatorButton(
          {Icon icon,
          double size = 96,
          ShapeBorder shape,
          double padding = paddingStepOne,
          double margin = paddingStepOne,
          Color accentColor,
          ValueChanged<bool> onChanged,
          Alignment accentAligment,
          double accentIntensity}) =>
      new NeumorphicIndicatorButton(
        accentAligment: accentAligment,
        accentColor: accentColor,
        accentIntensity: accentIntensity,
        onChanged: onChanged,
        icon: icon,
        size: size,
        color: AppColors.mainColor,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
        padding: padding,
        margin: margin,
      );

  static Widget accentButton(
          {Widget child,
          Size size = const Size(elementWidthTwo, elementHeightTwo),
          ShapeBorder shape,
          bool toggle = false,
          double padding = paddingStepOne,
          double margin = paddingStepOne,
          VoidCallback onTap,
          AccentButtonCallback accentChanged}) =>
      NeumorphicAccentRoundButton(
        onTap: onTap,
        accentChanged: accentChanged,
        animationDuration: animationDuration,
        child: child,
        size: size,
        color: AppColors.accentColor,
        shape: shape ??
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
        padding: padding,
        margin: margin,
        toggle: toggle,
      );

  static Widget checkBox(
          {double padding = paddingStepOne,
          double margin = paddingStepOne,
          ValueChanged<bool> onChanged}) =>
      new NeumorphicCheckBox(
        padding: padding,
        margin: margin,
        borderRadius: borderRadius,
        onChanged: onChanged,
      );

  static Widget image(String url,
          {EdgeInsets padding = const EdgeInsets.all(paddingStepOne),
          EdgeInsets margin = const EdgeInsets.all(paddingStepOne),
          double height,
          double width}) =>
      Container(
        margin: margin,
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.network(url, height: height, width: width),
        ),
      );

  static Widget counter(
          {double padding = paddingStepOne,
          double margin = paddingStepOne,
          int initialValue = 0,
          int minValue = 1,
          ValueChanged<int> onChanged}) =>
      new NeumorphicCounter(
        padding: padding,
        minValue: minValue,
        initialValue: initialValue,
        margin: margin,
        animationDuration: animationDuration,
        borderRadius: borderRadius,
        onChanged: onChanged,
      );

  static Widget text(String text,
          {double size = defaultTextSize,
          Color color,
          TextAlign textAlign = TextAlign.left,
          FontWeight fontWeight = FontWeight.normal}) =>
      Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
            fontFamily: defaultFontFamily,
            color: color ?? AppColors.textColor,
            fontSize: size,
            fontWeight: fontWeight),
      );

  static Widget wrappingText(String text,
          {double size = defaultTextSize,
          Color color,
          TextAlign textAlign = TextAlign.left,
          FontWeight fontWeight = FontWeight.normal}) =>
      Flexible(
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
              fontFamily: defaultFontFamily,
              color: color ?? AppColors.textColor,
              fontSize: size,
              fontWeight: fontWeight),
        ),
      );

  static Icon icon(IconData iconData, {double size = 24, Color color}) =>
      new Icon(
        iconData,
        color: color == null ? AppColors.textColor : color,
        size: size,
      );
}
