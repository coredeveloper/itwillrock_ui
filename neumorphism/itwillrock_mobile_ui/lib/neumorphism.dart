import 'package:flutter/material.dart';
import 'constants/text.dart';
import 'constants/distances.dart';
import 'constants/colors.dart';
import 'email_validator.dart';
import 'gradient_text.dart';
import 'menu/menu_button.dart';
import 'menu/back_button.dart' as menu;
import 'neumorphic_counter.dart';
import 'neumorphic_frosted_glass_container.dart';
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
  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();

  static Duration animationDuration = const Duration(milliseconds: 64);
  static double borderRadius = 24;

  static Widget accentList(
          {required List<String> items,
          EdgeInsets padding = paddingStepOne,
          ValueChanged<String>? onItemSelected,
          String? selectedItem,
          EdgeInsets margin = paddingStepOne}) =>
      NeumorphicAccentList(
          padding: padding,
          color: AppColors.accentColor,
          textColor: AppColors.textColor,
          selectedItem: selectedItem,
          onItemSelected: onItemSelected,
          margin: margin,
          items: items);

  static Widget menuButton({
    double animationStep = 0,
  }) =>
      MenuButton(
          size: 24, color: AppColors.accentColor, animationStep: animationStep);

  static Widget backButton({GestureTapCallback? onTap}) => menu.BackButton(
        24.0,
        onTap,
      );

  static InputDecoration inputDecoration({
    String? label,
    String? hint,
    Widget? icon,
    bool filled = true,
  }) =>
      InputDecoration(
          hintStyle: TextStyle(color: AppColors.textColor),
          suffixIcon: icon,
          suffixStyle: TextStyle(color: AppColors.textColor),
          prefixStyle: TextStyle(color: AppColors.textColor),
          filled: filled,
          fillColor: AppColors.mainColor,
          labelText: label,
          hintText: hint,
          border: const GradientOutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ));

  static Widget container(
          {Widget? child,
          double width = double.infinity,
          double height = double.infinity,
          bool dropShadow = true,
          bool dropInnerShadow = false,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          bool renderAccent = false,
          Alignment? accentAligment,
          double accentIntensity = 0}) =>
      NeumorphicContainer(
        margin: margin,
        padding: padding,
        blur: 0,
        borderBlur: 3,
        accentAligment: renderAccent ? accentAligment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : 0,
        shadows: dropShadow ? AppColors.currentShadows() : <Shadow>[],
        innerShadows:
            dropInnerShadow ? AppColors.currentInnerShadows() : <Shadow>[],
        borderGradient: AppColors.shadowGradient,
        gradient: AppColors.shadowGradient,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: child,
      );

  static Widget frostedGlassContainer(
          {Widget? child,
          double width = double.infinity,
          double height = double.infinity,
          bool dropShadow = true,
          bool dropInnerShadow = false,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          bool renderAccent = false,
          Alignment? accentAligment,
          double accentIntensity = 0}) =>
      NeumorphicFrostedGlassContainer(
        margin: margin,
        padding: padding,
        accentAligment: renderAccent ? accentAligment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: child,
      );

  static Widget dropDownFormField<T>(
          {required T value,
          bool obscureText = false,
          TextInputType inputType = TextInputType.text,
          ValueChanged<T?>? onChanged,
          required List<T> items,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne}) =>
      Container(
          padding: padding,
          margin: margin,
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
          {String? label,
          TextEditingController? controller,
          FormFieldValidator<String>? validator,
          AutovalidateMode validateMode = AutovalidateMode.disabled,
          String? hint,
          Icon? icon,
          bool obscureText = false,
          TextInputType inputType = TextInputType.text,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne}) =>
      Container(
        padding: padding,
        margin: margin,
        child: TextFormField(
          autovalidateMode: validateMode,
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

  static Widget emailFormField(
          {String? label,
          TextEditingController? controller,
          FormFieldValidator<String>? validator,
          AutovalidateMode validateMode = AutovalidateMode.disabled,
          String hint = 'Enter your email',
          Icon? icon,
          bool obscureText = false,
          TextInputType inputType = TextInputType.text,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne}) =>
      textFormField(
          label: label,
          controller: _emailController,
          validator: Validators.validateEmail,
          icon: icon ??
              Icon(
                Icons.email,
                color: AppColors.textColor,
                size: iconSizeSmall,
              ));

  static Widget passwordFormField(
          {String? label,
          String? hint,
          Icon? icon,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne}) =>
      textFormField(
          label: label,
          controller: _passwordController,
          obscureText: true,
          icon: Neumorphism.icon(Icons.password));

  static Widget actionContainer(
          {Widget? child,
          Size size = const Size(double.infinity, 48),
          ShapeBorder? shape,
          bool main = false,
          bool toggle = false,
          double padding = 0,
          double margin = 0,
          VoidCallback? onTap,
          bool renderAccent = false,
          Alignment? accentAligment,
          double accentIntensity = 0}) =>
      NeumorphicActionContainer(
        animationDuration: animationDuration,
        accentAligment: renderAccent ? accentAligment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : 0,
        onTap: onTap,
        size: size,
        color: main ? transparentColor : AppColors.mainColor,
        gradient: main ? AppColors.mainGradient : null,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: padding,
        margin: margin,
        toggle: toggle,
        child: child,
      );

  static Widget extendedActionContainer(
          {Widget? child,
          Size size = const Size(double.infinity, 48),
          ShapeBorder? shape,
          bool main = false,
          bool toggle = false,
          EdgeInsets padding = const EdgeInsets.all(0),
          EdgeInsets margin = const EdgeInsets.all(0),
          VoidCallback? onTap,
          bool renderAccent = false,
          Alignment? accentAligment,
          double accentIntensity = 0}) =>
      NeumorphicExtendedActionContainer(
        animationDuration: animationDuration,
        accentAligment: renderAccent ? accentAligment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : 0,
        onTap: onTap,
        size: size,
        color: main ? transparentColor : AppColors.mainColor,
        gradient: main ? AppColors.mainGradient : null,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: padding,
        margin: margin,
        toggle: toggle,
        child: child,
      );

  static Widget softRoundButton(
          {Icon? icon,
          String? text,
          Size size = const Size(96, 96),
          ShapeBorder? shape,
          bool main = false,
          bool toggle = false,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          VoidCallback? onTap,
          bool renderAccent = false,
          Alignment? accentAligment,
          double elevationMultiplier = 1,
          double accentIntensity = 0}) =>
      NeumorphicSoftRoundButton(
        animationDuration: animationDuration,
        accentAligment: renderAccent ? accentAligment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : 0,
        onTap: onTap,
        icon: icon,
        text: text,
        elevationMultiplier: elevationMultiplier,
        textColor: main ? AppColors.altTextColor : null,
        size: size,
        color: main ? transparentColor : AppColors.mainColor,
        gradient: main ? AppColors.mainGradient : null,
        shape: shape ??
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(roundedBorder)),
        padding: padding,
        margin: margin,
        toggle: toggle,
      );

  static Widget indicatorButton(
          {required Icon icon,
          double size = 96,
          ShapeBorder? shape,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          Color? accentColor,
          ValueChanged<bool>? onChanged,
          Alignment? accentAligment,
          double accentIntensity = 0}) =>
      NeumorphicIndicatorButton(
        accentAligment: accentAligment,
        accentColor: accentColor,
        accentIntensity: accentIntensity,
        onChanged: onChanged,
        icon: icon,
        size: size,
        color: AppColors.mainColor,
        shape: shape ??
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(roundedBorder)),
        padding: padding,
        margin: margin,
      );

  static Widget accentButton(
          {Widget? child,
          Size size = const Size(elementWidthTwo, elementHeightTwo),
          ShapeBorder? shape,
          bool toggle = false,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          VoidCallback? onTap,
          AccentButtonCallback? accentChanged}) =>
      NeumorphicAccentRoundButton(
        onTap: onTap,
        accentChanged: accentChanged,
        animationDuration: animationDuration,
        size: size,
        color: AppColors.accentColor,
        shape: shape ??
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
        padding: padding,
        margin: margin,
        toggle: toggle,
        child: child,
      );

  static Widget checkBox(
          {EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          ValueChanged<bool>? onChanged}) =>
      NeumorphicSwitch(
        padding: padding,
        margin: margin,
        borderRadius: borderRadius,
        onChanged: onChanged,
      );

  static Widget image(String url,
          {EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          required double height,
          required double width}) =>
      Container(
        margin: margin,
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.network(url, height: height, width: width),
        ),
      );

  static Widget counter(
          {EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          int initialValue = 0,
          int minValue = 1,
          ValueChanged<int>? onChanged}) =>
      NeumorphicCounter(
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
          Color? color,
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
          Color? color,
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

  static Icon icon(IconData iconData, {double size = 24, Color? color}) => Icon(
        iconData,
        color: color ?? AppColors.textColor,
        size: size,
      );

  static Widget gradientText(String text) => GradientText(
        text,
        gradient: AppColors.shadowGradient,
        style: TextStyle(
            fontFamily: defaultFontFamily,
            color: AppColors.textColor,
            fontSize: largeTextSize,
            fontWeight: FontWeight.normal),
      );
}
