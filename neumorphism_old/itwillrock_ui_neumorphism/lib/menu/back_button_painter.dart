import 'package:flutter/widgets.dart';
import 'package:flyupline_mobile/constants/colors.dart';

import 'back_icon_painter.dart';

class BackButtonPainter extends CustomPainter {
  final BackIconPainter iconPainter =
      BackIconPainter(color: AppColors.accentColor, strokeWidth: 2);

  @override
  void paint(Canvas canvas, Size size) {
    iconPainter.calculateShape(Offset(0, 0), size);

    iconPainter.paintIcon(canvas);
  }

  @override
  bool shouldRepaint(BackButtonPainter oldDelegate) {
    return false;
  }
}
