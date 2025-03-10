import 'package:flutter/widgets.dart';
import '../constants/colors.dart';
import 'chart_area_painter.dart';
import 'chart_grid_painter.dart';
import 'label_model.dart';

/// A custom painter for rendering charts.
///
/// This class extends [CustomPainter] and is responsible for painting
/// the chart on the canvas. It should be used with a [CustomPaint] widget
/// to display the chart in the UI.
class ChartPainter extends CustomPainter {
  /// A painter that draws the grid lines on the chart.
  late GridPainter gridPainter;

  /// A painter that draws the area of the chart.
  late ChartAriaPainter areaPainter;

  /// The size of the indicator.
  final Size indicatorSize;

  /// The series of data to display on the chart.
  LabelSeriesModel series;

  /// The vertical offset of the chart.
  final double verticalOffset;

  /// Creates a [ChartPainter].
  ChartPainter({
    this.indicatorSize = const Size(16, 16),
    double blur = 0,
    this.verticalOffset = 0,
    double strokeWidth = 5,
    required this.series,
  }) {
    gridPainter = GridPainter(
        color: AppColors.textColor.withAlpha(100),
        columns: series.data.length * 2);
    areaPainter = ChartAriaPainter(series: series);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (series.data.isEmpty) {
      return;
    }
    var offset = const Offset(0, 0);
    offset = Offset(0, verticalOffset);
    size = Size(size.width, size.height - verticalOffset * 2);
    gridPainter.calculateShape(offset, size);
    areaPainter.calculateShape(offset, size);

    gridPainter.paintSurface(canvas);
    areaPainter.paintSurface(canvas);
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) {
    if (series.data == oldDelegate.series.data) {
      return false;
    }
    return true;
  }
}
