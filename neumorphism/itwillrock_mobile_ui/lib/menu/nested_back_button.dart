import 'package:flutter/widgets.dart';
import 'nested_back_button_painter.dart';

/// A back button that displays multiple chevrons to indicate navigation depth.
///
/// Shows `<` for level 1, `<<` for level 2, `<<<` for level 3, etc.
/// Animates smoothly when the nesting level changes.
class NestedBackButton extends StatefulWidget {
  /// The size of the button (height, width grows with nesting level).
  final double size;

  /// The current nesting level (1 = <, 2 = <<, etc.)
  final int nestingLevel;

  /// Callback when the button is tapped.
  final GestureTapCallback? onTap;

  /// The color of the chevrons. Defaults to accent color.
  final Color? color;

  /// The stroke width of the chevron lines.
  final double strokeWidth;

  /// Duration of the animation when nesting level changes.
  final Duration animationDuration;

  /// Creates a [NestedBackButton].
  const NestedBackButton({
    super.key,
    this.size = 24,
    this.nestingLevel = 1,
    this.onTap,
    this.color,
    this.strokeWidth = 2,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<NestedBackButton> createState() => _NestedBackButtonState();
}

class _NestedBackButtonState extends State<NestedBackButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: 1.0,
    );
  }

  @override
  void didUpdateWidget(NestedBackButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.nestingLevel != widget.nestingLevel) {
      _controller.forward(from: 0);
    }
    if (oldWidget.animationDuration != widget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Width grows with nesting level (same formula as BackButton but wider for multiple)
    final width = widget.size + (widget.nestingLevel - 1) * widget.size * 0.5;

    // Match BackButton structure exactly
    return RepaintBoundary(
      child: GestureDetector(
        onTap: widget.onTap,
        child: CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: NestedBackButtonPainter(
            nestingLevel: widget.nestingLevel,
            animationStep: _controller.value,
            color: widget.color,
            strokeWidth: widget.strokeWidth,
          ),
          child: Container(
            height: widget.size,
            width: width,
            alignment: const Alignment(0, 0),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
