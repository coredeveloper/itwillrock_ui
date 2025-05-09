import 'dart:ui';

import '../constants/colors.dart';
import '../neumorphic_shape_painter.dart';
import 'label_model.dart';

/// A custom painter for rendering chart areas with a neumorphic design.
///
/// This class extends [NeumorphicShapePainter] to provide a specialized
/// painter for drawing chart areas with a neumorphic effect.
class ChartAriaPainter extends NeumorphicShapePainter {
  /// The size of the indicator.
  final Size indicatorSize = const Size(10, 10);

  /// The series to render.
  final LabelSeriesModel series;

  /// The paint object used to fill the chart area.
  final fillPaint = Paint()..color = AppColors.textColor.withAlpha(50);

  /// The paint object used to fill the alternate chart area.
  final altFillPaint = Paint()..color = AppColors.textColor;

  /// The paint object used to draw the dashed line.
  final dashedLinePaint = Paint()
    ..color = AppColors.altAccentColor
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round;

  /// The vertical scale factor for the chart area.
  ///
  /// This value is used to scale the vertical dimensions of the chart.
  /// A value of 1 means no scaling, while values greater than 1 will
  /// increase the vertical size and values less than 1 will decrease it.
  double verticalScale = 1;

  /// The horizontal scale factor for the chart area.
  ///
  /// This value is used to scale the chart horizontally. A value of 1 means no scaling,
  /// while values greater than 1 will stretch the chart horizontally, and values less than 1
  /// will compress it.
  double horizontalScale = 1;

  /// The paint object used to draw the outline of the chart area.
  final outlineMainPaint = Paint()
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke
    ..color = AppColors.accentColor;

  /// Creates a [ChartAriaPainter].
  ChartAriaPainter({
    required this.series,
  }) : super(strokeWidth: 0);

  /// Paints the chart area with a neumorphic effect.
  void paintSurface(Canvas canvas) {
    if (series.data.isEmpty) {
      return;
    }
    processSeries();
    var height = innerRect.height;
    var x0 = 0.0;
    var y0 = height - (series.data[0].value * verticalScale);

    var fillArea = Path();
    var mainArea = Path();
    fillArea.moveTo(x0, y0);
    fillArea.lineTo(x0 + horizontalScale / 2, y0);
    mainArea.moveTo(x0, y0);
    mainArea.lineTo(x0 + horizontalScale / 2, y0);

    var length = series.data.length;
    for (int i = 1; i < length; i++) {
      var x1 =
          i * horizontalScale - horizontalScale / 3 * 2 + horizontalScale / 2;
      var y1 = height - (series.data[i - 1].value * verticalScale);
      var x2 =
          i * horizontalScale - (horizontalScale / 3) + horizontalScale / 2;
      var y2 = height - (series.data[i].value * verticalScale);
      var x3 = i * horizontalScale + horizontalScale / 2;
      var y3 = height - (series.data[i].value * verticalScale);
      fillArea.cubicTo(x1, y1, x2, y2, x3, y3);
      mainArea.cubicTo(x1, y1, x2, y2, x3, y3);
    }
    var lastY = height - (series.data[length - 1].value * verticalScale);
    fillArea.lineTo(outerRect.width, lastY);
    fillArea.lineTo(outerRect.width, outerRect.height);
    fillArea.lineTo(0, outerRect.height);
    fillArea.close();
    canvas.drawPath(mainArea, outlineMainPaint);
    canvas.drawPath(fillArea, fillPaint);

    // Draw the dashed horizontal line if referenceValue is valid
    if (series.referenceValue >= 0) {
      var referenceY = height - (series.referenceValue * verticalScale);
      var dashWidth = 5.0;
      var dashSpace = 6.0;
      double startX = 0;

      while (startX < outerRect.width) {
        canvas.drawLine(Offset(startX, referenceY),
            Offset(startX + dashWidth, referenceY), dashedLinePaint);
        startX += dashWidth + dashSpace;
      }
    }
  }

  /// Processes the series data to determine the scaling factors.
  void processSeries() {
    var max = series.data
        .reduce((curr, next) => curr.value > next.value ? curr : next);
    var maxValue =
        (max.value > series.referenceValue) ? max.value : series.referenceValue;
    verticalScale = outerRect.height / (maxValue + maxValue * 0.25);
    horizontalScale = outerRect.width / series.data.length;
  }
}
