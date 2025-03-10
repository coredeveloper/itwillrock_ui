import 'package:flutter/widgets.dart';
import '../neumorphic_shape_painter.dart';

/// A custom painter that draws a grid on a Neumorphic surface.
///
/// This class extends [NeumorphicShapePainter] to provide a grid
/// painting functionality, which can be used to create a grid-like
/// appearance on Neumorphic surfaces.
class GridPainter extends NeumorphicShapePainter {
  /// The color of the grid.
  final Color color;

  /// The number of columns in the grid.
  final int columns;

  /// The number of rows in the grid.
  final int rows;

  /// The paint object used to draw the grid.
  final gridPaint = Paint();

  /// Creates a [GridPainter].
  GridPainter({
    required this.color,
    this.columns = 1,
    this.rows = 1,
  }) : super(strokeWidth: 0) {
    gridPaint.color = color;
  }

  /// Paints the surface of the chart grid onto the given canvas.
  ///
  /// This method is responsible for rendering the visual elements of the
  /// chart grid on the provided [canvas].
  ///
  /// [canvas] The canvas on which to paint the chart grid.
  void paintSurface(Canvas canvas) {
    //canvas.drawPath(outerPath, gridPaint);
    for (int i = 1; i < columns; i++) {
      var start = Offset(i * (outerRect.width / columns), outerRect.top);
      var end = Offset(i * outerRect.width / columns, outerRect.height);
      canvas.drawLine(start, end, gridPaint);
    }
  }
}
