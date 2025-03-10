import 'package:flutter/widgets.dart';

/// A widget that displays text with a gradient color.
///
/// The [GradientText] widget applies a gradient to the text, making it visually
/// appealing. It uses a [ShaderMask] to achieve the gradient effect.
class GradientText extends StatelessWidget {
  /// Creates a [GradientText] widget.
  ///
  /// The [text] and [gradient] arguments must not be null.
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  /// The text to display.
  final String text;

  /// The style to use for the text.
  final TextStyle? style;

  /// The gradient to apply to the text.
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
