import 'package:flutter/widgets.dart';
import '../neumorphic_shape_painter.dart';


class GridPainter extends NeumorphicShapePainter {
  final Color color;
  final int columns;
  final int rows;
  final gridPaint = Paint();
  GridPainter({
    required this.color,
    this.columns = 1,
    this.rows = 1,
  }) : super(strokeWidth: 0) {
    gridPaint.color = color;
  }

  void paintSurface(Canvas canvas) {
    //canvas.drawPath(outerPath, gridPaint);
    for (int i = 1; i < columns; i++) {
      var start = Offset(i * (outerRect.width / columns), outerRect.top);
      var end = Offset(i * outerRect.width / columns, outerRect.height);
      canvas.drawLine(start, end, gridPaint);
    }
  }
}