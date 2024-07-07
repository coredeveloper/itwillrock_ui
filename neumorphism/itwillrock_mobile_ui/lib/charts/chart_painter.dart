import 'package:flutter/widgets.dart';
import '../constants/colors.dart';
import 'chart_area_painter.dart';
import 'chart_grid_painter.dart';
import 'label_model.dart';

class ChartPainter extends CustomPainter {
  late GridPainter gridPainter;
  late ChartAriaPainter areaPainter;
  final Size indicatorSize;
  Offset indicatorOffset = Offset.zero;
  LabelSeriesModel series;
  final double verticalOffset;

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
    areaPainter = ChartAriaPainter(
        fillColor: AppColors.textColor.withAlpha(50), series: series);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (series.data.isEmpty) {
      return;
    }
    var columnWidth = size.width / (series.data.length);
    indicatorOffset = Offset(
        columnWidth * series.splitIndex +
            (columnWidth / 2) -
            indicatorSize.width / 2,
        0);
    var offset = const Offset(0, 0);
    offset = Offset(0, verticalOffset);
    size = Size(size.width, size.height - verticalOffset * 2);
      gridPainter.calculateShape(offset, size);
    areaPainter.calculateShape(offset, size);

    gridPainter.paintSurface(canvas);
    areaPainter.paintSurface(canvas);
    //indicatorPainter.paintSurface(canvas);
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) {
    if (series.data == oldDelegate.series.data) {
      return false;
    }
    return true;
  }
}
