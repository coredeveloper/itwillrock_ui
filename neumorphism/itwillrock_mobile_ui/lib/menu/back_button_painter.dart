import 'package:flutter/widgets.dart';
import '../constants/colors.dart';

import 'back_icon_painter.dart';

/// A custom painter that draws a back button.
///
/// This class extends [CustomPainter] and is used to paint a back button
/// with a specific design. The painting logic should be implemented in the
/// [paint] method, and the [shouldRepaint] method should determine when
/// the painter needs to repaint.
class BackButtonPainter extends CustomPainter {
  /// Creates a [BackButtonPainter].
  final BackIconPainter iconPainter =
      BackIconPainter(color: AppColors.accentColor, strokeWidth: 2);

  @override
  void paint(Canvas canvas, Size size) {
    iconPainter.calculateShape(const Offset(0, 0), size);

    iconPainter.paintIcon(canvas);
  }

  @override
  bool shouldRepaint(BackButtonPainter oldDelegate) {
    return false;
  }
}
