import 'package:flutter/widgets.dart';
import 'nested_back_button_painter.dart';

/// A back button that displays multiple chevrons to indicate navigation depth.
///
/// Shows `<` for level 1, `<<` for level 2, `<<<` for level 3, etc.
/// Animates smoothly when the nesting level changes.
///
/// Example usage:
/// ```dart
/// NestedBackButton(
///   size: 24,
///   nestingLevel: 2, // Shows <<
///   onTap: () => Navigator.pop(context),
/// )
/// ```
class NestedBackButton extends StatefulWidget {
  /// The size of the button (width and height).
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
    this.strokeWidth = 2.5,
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
      value: 1.0, // Start fully visible
    );
  }

  @override
  void didUpdateWidget(NestedBackButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Animate when nesting level changes
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
    return RepaintBoundary(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => CustomPaint(
            size: Size(widget.size * widget.nestingLevel, widget.size),
            painter: NestedBackButtonPainter(
              nestingLevel: widget.nestingLevel,
              animationStep: _controller.value,
              color: widget.color,
              strokeWidth: widget.strokeWidth,
            ),
            child: SizedBox(
              height: widget.size,
              width: widget.size * widget.nestingLevel * 0.8,
            ),
          ),
        ),
      ),
    );
  }
}
