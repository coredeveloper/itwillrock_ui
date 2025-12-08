import 'package:flutter/material.dart';
import 'charts/label_model.dart';
import 'charts/series_chart.dart';
import 'charts/series_type_chart.dart';
import 'charts/time_period_type.dart';
import 'constants/text.dart';
import 'constants/distances.dart';
import 'constants/colors.dart';
import 'email_validator.dart';
import 'gradient_text.dart';
import 'menu/menu_button.dart';
import 'menu/back_button.dart' as menu;
import 'menu/nested_back_button.dart';
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

/// A class that provides Neumorphism design elements and utilities.
///
/// Neumorphism is a design trend that combines shapes, gradients, and shadows
/// to create a soft, extruded plastic look. This class can be used to apply
/// Neumorphism effects to UI components.
class Neumorphism {
  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();

  /// The duration of the animation used in the neumorphism effect.
  ///
  /// This duration is set to 64 milliseconds.
  static Duration animationDuration = const Duration(milliseconds: 64);

  /// The border radius for neumorphic elements.
  static double borderRadius = 24;

  /// The size of the icons used in neumorphic elements.
  static SeriesTypesChart seriesTypesChart(
          {ValueChanged<TimePeriodType>? onItemSelected,
          required Color color}) =>
      SeriesTypesChart(
        textColor: AppColors.textColor,
        color: color,
        onItemSelected: onItemSelected,
      );

  /// Creates a ChartSeries based on the provided [values].
  ///
  /// The [values] parameter is a [ValueNotifier] that holds a [LabelSeriesModel].
  /// This method generates a series chart using the data from the [LabelSeriesModel].
  ///
  /// Returns a [ChartSeries] object representing the series chart.
  static ChartSeries seriesChart(ValueNotifier<LabelSeriesModel> values,
          {EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne}) =>
      ChartSeries(
          values: values,
          padding: padding,
          textColor: AppColors.textColor,
          margin: margin);

  /// Creates a list of widgets with accent styling.
  ///
  /// This method returns a list of widgets that have a neumorphic accent
  /// design. The exact appearance and behavior of the widgets depend on the
  /// implementation details provided in the method.
  ///
  /// Returns a [Widget] that contains the accent-styled list.
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

  /// Creates a menu button widget.
  ///
  /// This widget can be customized using the provided parameters.
  ///
  /// The [menuButton] method returns a [Widget] that represents a menu button.
  ///
  /// Example usage:
  /// ```dart
  /// Widget button = menuButton(
  ///   // Add your parameters here
  /// );
  /// ```
  ///
  /// Add detailed parameter descriptions here.
  static Widget menuButton({
    double animationStep = 0,
  }) =>
      MenuButton(
          size: 24, color: AppColors.accentColor, animationStep: animationStep);

  /// Creates a back button widget.
  ///
  /// The [onTap] parameter is a callback that is triggered when the button is tapped.
  ///
  /// Returns a [Widget] that represents a back button.
  static Widget backButton({GestureTapCallback? onTap}) => menu.BackButton(
        24.0,
        onTap,
      );

  /// Creates a nested back button that shows navigation depth.
  ///
  /// The number of chevrons indicates how deep in the navigation stack:
  /// - Level 1: `<` (one screen deep)
  /// - Level 2: `<<` (two screens deep)
  /// - Level 3: `<<<` (three screens deep)
  /// - etc.
  ///
  /// The [nestingLevel] parameter specifies the current depth.
  /// The [onTap] callback is triggered when the button is tapped.
  /// The [color] parameter allows custom chevron color.
  /// The [size] parameter controls the button size.
  ///
  /// Example usage:
  /// ```dart
  /// Neumorphism.nestedBackButton(
  ///   nestingLevel: 2, // Shows <<
  ///   onTap: () => Navigator.pop(context),
  /// )
  /// ```
  static Widget nestedBackButton({
    int nestingLevel = 1,
    GestureTapCallback? onTap,
    Color? color,
    double size = 24,
    double strokeWidth = 2,
    Duration animationDuration = const Duration(milliseconds: 200),
  }) =>
      NestedBackButton(
        nestingLevel: nestingLevel,
        onTap: onTap,
        color: color,
        size: size,
        strokeWidth: strokeWidth,
        animationDuration: animationDuration,
      );

  /// Creates an [InputDecoration] with neumorphism styling.
  ///
  /// This method allows you to customize the appearance of input fields
  /// with neumorphism design principles.
  ///
  /// The [inputDecoration] method accepts various parameters to define
  /// the look and feel of the input field.
  ///
  /// Example usage:
  /// ```dart
  /// InputDecoration decoration = Neumorphism.inputDecoration(
  ///   hintText: 'Enter your text',
  ///   labelText: 'Label',
  ///   // other parameters
  /// );
  /// ```
  ///
  /// Returns an [InputDecoration] object with the specified styling.
  static InputDecoration inputDecoration(
          {String? label,
          String? hint,
          Widget? icon,
          bool filled = true,
          bool renderAccent = false,
          Alignment? accentAlignment,
          double accentIntensity = 0,
          bool alignLabelWithHint = false,
          EdgeInsetsGeometry? contentPadding}) =>
      InputDecoration(
          enabledBorder: GradientOutlineInputBorder(
            accentAlignment: renderAccent ? accentAlignment : null,
            accentColor: renderAccent ? AppColors.accentColor : null,
            accentIntensity: renderAccent ? accentIntensity : 0,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          hintStyle: TextStyle(color: AppColors.textColor),
          suffixIcon: icon,
          suffixStyle: TextStyle(color: AppColors.textColor),
          prefixStyle: TextStyle(color: AppColors.textColor),
          filled: filled,
          fillColor: AppColors.mainColor,
          labelText: label,
          hintText: hint,
          alignLabelWithHint: alignLabelWithHint,
          contentPadding: contentPadding,
          border: GradientOutlineInputBorder(
            accentAlignment: renderAccent ? accentAlignment : null,
            accentColor: renderAccent ? AppColors.accentColor : null,
            accentIntensity: renderAccent ? accentIntensity : 0,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ));

  /// Creates a neumorphic container widget.
  ///
  /// This widget applies a neumorphic design to its child widget, giving it
  /// a soft, extruded look that appears to be carved out of the background.
  ///
  /// The [container] method takes various parameters to customize the appearance
  /// and behavior of the neumorphic container.
  ///
  /// Returns a [Widget] that represents the neumorphic container.
  static Widget container(
          {Widget? child,
          Color? color,
          double width = double.infinity,
          double height = double.infinity,
          bool dropShadow = true,
          bool dropInnerShadow = false,
          List<Shadow>? shadows,
          List<Shadow>? innerShadows,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          bool renderAccent = false,
          Alignment? accentAlignment,
          double accentIntensity = 0}) =>
      NeumorphicContainer(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        color: color ?? AppColors.mainColor,
        blur: 0,
        borderBlur: 3,
        accentAlignment: renderAccent ? accentAlignment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : 0,
        shadows:
            dropShadow ? (shadows ?? AppColors.currentShadows()) : <Shadow>[],
        innerShadows: dropInnerShadow
            ? (innerShadows ?? AppColors.currentInnerShadows())
            : <Shadow>[],
        borderGradient: AppColors.shadowGradient,
        gradient: color != null ? null : AppColors.shadowGradient,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: child,
      );

  /// Creates a frosted glass effect container.
  ///
  /// This widget applies a frosted glass effect to its child widget,
  /// giving it a blurred, translucent appearance.
  ///
  /// The [frostedGlassContainer] can be used to create visually appealing
  /// UI elements that stand out with a glass-like effect.
  ///
  /// Example usage:
  /// ```
  /// frostedGlassContainer(
  ///   child: Text('Hello, World!'),
  /// )
  /// ```
  ///
  /// Returns a [Widget] that applies the frosted glass effect.
  static Widget frostedGlassContainer(
          {Widget? child,
          double width = double.infinity,
          double height = double.infinity,
          bool dropShadow = true,
          bool dropInnerShadow = false,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          bool renderAccent = false,
          Alignment? accentAlignment,
          double accentIntensity = 0}) =>
      NeumorphicFrostedGlassContainer(
        margin: margin,
        padding: padding,
        accentAlignment: renderAccent ? accentAlignment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: child,
      );

  /// Creates a dropdown form field widget.
  ///
  /// The generic type [T] represents the type of the value the dropdown holds.
  ///
  /// This widget is used to create a dropdown menu within a form, allowing users
  /// to select a value from a list of options.
  ///
  /// Example usage:
  /// ```dart
  /// dropDownFormField<String>(
  ///   // parameters here
  /// );
  /// ```
  ///
  /// Returns a [Widget] that displays a dropdown form field.
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
            initialValue: value,
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

  /// Creates a TextFormField widget with neumorphism design.
  ///
  /// This method returns a [Widget] that represents a TextFormField with
  /// neumorphic styling, providing a modern and visually appealing user interface.
  ///
  /// Example usage:
  /// ```dart
  /// Neumorphism.textFormField(
  ///   // Add your parameters here
  /// );
  /// ```
  ///
  /// Returns:
  ///   A [Widget] that represents a TextFormField with neumorphic design.
  static Widget textFormField(
          {String? label,
          TextEditingController? controller,
          FormFieldValidator<String>? validator,
          AutovalidateMode validateMode = AutovalidateMode.disabled,
          String? hint,
          Icon? icon,
          bool obscureText = false,
          bool renderAccent = false,
          Alignment? accentAlignment,
          double accentIntensity = 0,
          TextInputType? inputType,
          int? maxLines = 1,
          int? minLines,
          bool expands = false,
          TextInputAction? textInputAction,
          TextAlignVertical? textAlignVertical,
          bool alignLabelWithHint = false,
          EdgeInsetsGeometry? contentPadding,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne}) {
    // Auto-detect multiline keyboard type
    final isMultiline = maxLines != 1 || minLines != null || expands;
    final keyboardType = inputType ??
        (isMultiline ? TextInputType.multiline : TextInputType.text);

    return Container(
      padding: padding,
      margin: margin,
      child: TextFormField(
        autovalidateMode: validateMode,
        textDirection: TextDirection.ltr,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        expands: expands,
        textInputAction: textInputAction,
        textAlignVertical: textAlignVertical,
        style: TextStyle(
          fontFamily: defaultFontFamily,
          color: AppColors.textColor,
        ),
        decoration: inputDecoration(
            accentAlignment: renderAccent ? accentAlignment : null,
            accentIntensity: renderAccent ? accentIntensity : 0,
            renderAccent: renderAccent,
            alignLabelWithHint: alignLabelWithHint,
            contentPadding: contentPadding,
            label: label,
            hint: hint,
            icon: icon),
      ),
    );
  }

  /// Creates a form field for email input with neumorphic design.
  ///
  /// This widget provides a text field specifically designed for email input,
  /// incorporating neumorphic design principles to give a soft, raised appearance.
  ///
  /// Returns a [Widget] that can be used as an email input form field.
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

  /// Creates a password form field widget with neumorphism design.
  ///
  /// This widget is used to input passwords securely.
  ///
  /// Returns a [Widget] that represents the password form field.
  static Widget passwordFormField(
          {String? label,
          String? hint,
          Icon? icon,
          bool renderAccent = false,
          Alignment? accentAlignment,
          double accentIntensity = 0,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne}) =>
      textFormField(
          renderAccent: renderAccent,
          accentAlignment: accentAlignment,
          accentIntensity: accentIntensity,
          label: label,
          controller: _passwordController,
          obscureText: true,
          icon: Neumorphism.icon(Icons.password));

  /// Creates a container widget for an action.
  ///
  /// This widget is used to display an action button or any other interactive
  /// element within a neumorphic design.
  ///
  /// The [actionContainer] method returns a [Widget] that can be customized
  /// with various properties to achieve the desired neumorphic effect.
  static Widget actionContainer(
          {Widget? child,
          Color? color,
          Size size = const Size(double.infinity, 48),
          ShapeBorder? shape,
          bool main = false,
          bool toggle = false,
          EdgeInsets padding = EdgeInsets.zero,
          EdgeInsets margin = EdgeInsets.zero,
          VoidCallback? onTap,
          bool renderAccent = false,
          Alignment? accentAlignment,
          double accentIntensity = 0}) =>
      NeumorphicActionContainer(
        animationDuration: animationDuration,
        accentAlignment: renderAccent ? accentAlignment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : 0,
        onTap: onTap,
        size: size,
        color: main ? transparentColor : (color ?? AppColors.mainColor),
        gradient: main ? AppColors.mainGradient : null,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: padding,
        margin: margin,
        toggle: toggle,
        child: child,
      );

  /// Creates a container with extended action capabilities.
  ///
  /// This widget is designed to provide a neumorphic style container
  /// that can be used for extended actions within the UI.
  ///
  /// The container can be customized with various properties to fit
  /// the design requirements of the application.
  ///
  /// Returns a [Widget] that represents the extended action container.
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
          Alignment? accentAlignment,
          double accentIntensity = 0}) =>
      NeumorphicExtendedActionContainer(
        animationDuration: animationDuration,
        accentAlignment: renderAccent ? accentAlignment : null,
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

  /// Creates a soft round button with neumorphism design.
  ///
  /// This widget applies a soft shadow effect to give the appearance of
  /// a raised button with rounded corners.
  ///
  /// Returns a [Widget] representing the soft round button.
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
          Alignment? accentAlignment,
          double elevationMultiplier = 1,
          double accentIntensity = 0}) =>
      NeumorphicSoftRoundButton(
        animationDuration: animationDuration,
        accentAlignment: renderAccent ? accentAlignment : null,
        accentColor: renderAccent ? AppColors.accentColor : null,
        accentIntensity: renderAccent ? accentIntensity : 0,
        onTap: onTap,
        icon: icon,
        text: text,
        elevationMultiplier: elevationMultiplier,
        textColor: main ? altTextColor : null,
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

  /// Creates a button with an indicator.
  ///
  /// This widget is typically used to show a button with some form of
  /// visual indicator, such as a loading spinner or a progress bar.
  ///
  /// The [indicatorButton] method takes various parameters to customize
  /// the appearance and behavior of the button.
  ///
  /// Returns a [Widget] that represents the button with an indicator.
  static Widget indicatorButton(
          {required Icon icon,
          double size = 96,
          ShapeBorder? shape,
          EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          Color? accentColor,
          ValueChanged<bool>? onChanged,
          Alignment? accentAlignment,
          double accentIntensity = 0}) =>
      NeumorphicIndicatorButton(
        accentAlignment: accentAlignment,
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

  /// Creates an accent button with neumorphism design.
  ///
  /// This button is styled with a unique accent color and neumorphic
  /// effects to provide a modern and visually appealing look.
  ///
  /// Returns a [Widget] that represents the accent button.
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

  /// Creates a custom checkbox widget with neumorphism design.
  ///
  /// This widget can be used to display a checkbox with a unique
  /// neumorphic style, which gives it a soft, extruded, and 3D-like
  /// appearance.
  ///
  /// Returns a [Widget] that represents the custom checkbox.
  static Widget checkBox(
          {EdgeInsets padding = paddingStepOne,
          EdgeInsets margin = paddingStepOne,
          bool initialValue = false,
          ValueChanged<bool>? onChanged}) =>
      NeumorphicSwitch(
        padding: padding,
        margin: margin,
        borderRadius: borderRadius,
        initialValue: initialValue,
        onChanged: onChanged,
      );

  /// Creates a widget that displays an image from the given [url].
  ///
  /// The [url] parameter must not be null.
  ///
  /// Example usage:
  /// ```dart
  /// Widget imageWidget = Neumorphism.image('https://example.com/image.png');
  /// ```
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

  /// Creates a counter widget with neumorphism design.
  ///
  /// This widget displays a counter with a neumorphic style, which gives
  /// a soft, extruded, and 3D-like appearance. It can be used to show
  /// numerical values that can be incremented or decremented.
  ///
  /// Example usage:
  /// ```dart
  /// Neumorphism.counter(
  ///   initialValue: 0,
  ///   onIncrement: () => setState(() => _counter++),
  ///   onDecrement: () => setState(() => _counter--),
  /// );
  /// ```
  ///
  /// - [initialValue]: The starting value of the counter.
  /// - [onIncrement]: Callback function to be called when the counter is incremented.
  /// - [onDecrement]: Callback function to be called when the counter is decremented.
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

  /// Creates a text widget with the given [text].
  ///
  /// The [text] parameter specifies the string to be displayed in the widget.
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

  /// Wraps the given [text] in a widget.
  ///
  /// This method takes a [String] [text] and returns a [Widget] that
  /// displays the text with specific styling or behavior.
  ///
  /// Example:
  /// ```dart
  /// Widget wrappedText = wrappingText("Hello, World!");
  /// ```
  ///
  /// Returns a [Widget] that contains the wrapped text.
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

  /// Creates an icon with neumorphism style.
  ///
  /// The [iconData] parameter must not be null and specifies the icon to display.
  ///
  /// The [size] parameter specifies the size of the icon in logical pixels.
  /// If not specified, it defaults to 24.
  ///
  /// The [color] parameter specifies the color of the icon. If not specified,
  /// the icon will use the default color.
  static Icon icon(IconData iconData, {double size = 24, Color? color}) => Icon(
        iconData,
        color: color ?? AppColors.textColor,
        size: size,
      );

  /// Creates a widget that displays text with a gradient effect.
  ///
  /// The [text] parameter specifies the text to be displayed.
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
