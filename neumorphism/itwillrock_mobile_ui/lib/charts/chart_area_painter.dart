import 'dart:ui';

import '../constants/colors.dart';
import '../neumorphic_shape_painter.dart';
import 'label_model.dart';

class ChartAriaPainter extends NeumorphicShapePainter {
  final Size indicatorSize = const Size(10, 10);
  final LabelSeriesModel series;
  final fillPaint = Paint()..color = AppColors.textColor.withAlpha(50);
  final altFillPaint = Paint()..color = AppColors.textColor;
  final indicatorPaint = Paint()..color = AppColors.accentColor;
  final dashedLinePaint = Paint()
    ..color = AppColors.altAccentColor
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round;
  Rect indicatorRect = Rect.zero;
  Offset indicatorOffset = Offset.zero;

  final outlineMainPaint = Paint()
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke
    ..color = AppColors.accentColor;

  double verticalScale = 1;
  double horizontalScale = 1;

  ChartAriaPainter({
    required this.series,
  }) : super(strokeWidth: 0);

  void saveIndicator(double x, double y) {
    indicatorOffset = Offset(x, y);
    indicatorRect = indicatorOffset & indicatorSize;
  }

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
    var altArea = Path();
    fillArea.moveTo(x0, y0);
    fillArea.lineTo(x0 + horizontalScale / 2, y0);
    mainArea.moveTo(x0, y0);
    mainArea.lineTo(x0 + horizontalScale / 2, y0);
    altArea.moveTo(x0 + horizontalScale / 2, y0);
    saveIndicator(x0 + horizontalScale / 2, y0);
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
      if (i < series.splitIndex) {
        mainArea.cubicTo(x1, y1, x2, y2, x3, y3);
      } else if (i == series.splitIndex) {
        mainArea.cubicTo(x1, y1, x2, y2, x3, y3);
        altArea.moveTo(x3, y3);
        saveIndicator(x3, y3);
      } else {
        altArea.cubicTo(x1, y1, x2, y2, x3, y3);
      }
    }
    var lastY = height - (series.data[length - 1].value * verticalScale);
    fillArea.lineTo(outerRect.width, lastY);
    altArea.lineTo(outerRect.width, lastY);
    fillArea.lineTo(outerRect.width, outerRect.height);
    fillArea.lineTo(0, outerRect.height);
    fillArea.close();
    canvas.drawPath(mainArea, outlineMainPaint);
    canvas.drawPath(altArea, outlineMainPaint);
    canvas.drawPath(fillArea, fillPaint);

    // Draw the dotted horizontal line
    var dashWidth = 5.0;
    var dashSpace = 6.0;
    double startX = 0;

    while (startX < outerRect.width) {
      canvas.drawLine(Offset(startX, indicatorOffset.dy),
          Offset(startX + dashWidth, indicatorOffset.dy), dashedLinePaint);
      startX += dashWidth + dashSpace;
    }
    canvas.drawCircle(indicatorOffset, indicatorSize.width, indicatorPaint);
    canvas.drawCircle(indicatorOffset, 3, altFillPaint);
  }

  void processSeries() {
    var max = series.data
        .reduce((curr, next) => curr.value > next.value ? curr : next);
    verticalScale = outerRect.height / (max.value + max.value * 0.25);
    horizontalScale = outerRect.width / series.data.length;
  }
}
