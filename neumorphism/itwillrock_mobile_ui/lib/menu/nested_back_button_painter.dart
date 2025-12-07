import 'package:flutter/widgets.dart';
import '../constants/colors.dart';
import 'nested_back_icon_painter.dart';

/// A custom painter that draws a nested back button with multiple chevrons.
///
/// The number of chevrons indicates the navigation depth:
/// - Level 1: `<`
/// - Level 2: `<<`
/// - Level 3: `<<<`
/// - etc.
class NestedBackButtonPainter extends CustomPainter {
  /// The current nesting level (number of chevrons to draw).
  final int nestingLevel;

  /// Animation progress for smooth transitions between levels.
  final double animationStep;

  /// The color of the chevrons. Defaults to accent color.
  final Color? color;

  /// The stroke width of the chevron lines.
  final double strokeWidth;

  late final NestedBackIconPainter _iconPainter;

  /// Creates a [NestedBackButtonPainter].
  NestedBackButtonPainter({
    this.nestingLevel = 1,
    this.animationStep = 1.0,
    this.color,
    this.strokeWidth = 2.5,
  }) {
    _iconPainter = NestedBackIconPainter(
      color: color ?? AppColors.accentColor,
      strokeWidth: strokeWidth,
      nestingLevel: nestingLevel,
      animationStep: animationStep,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    _iconPainter.calculateShape(Offset.zero, size);
    _iconPainter.paintIcon(canvas);
  }

  @override
  bool shouldRepaint(NestedBackButtonPainter oldDelegate) {
    return oldDelegate.nestingLevel != nestingLevel ||
        oldDelegate.animationStep != animationStep ||
        oldDelegate.color != color;
  }
}
