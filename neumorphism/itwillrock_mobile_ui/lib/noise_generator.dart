import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

class NoiseGenerator {
  static final _random = Random();
  static final cachedSmall = generate(100, 100);

  static ui.Image generate(int width, int height) {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(
        recorder, Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()));
    final paint = Paint();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int gray = _random.nextInt(56) + 100;
        paint.color = Color.fromARGB(100, gray - 20, gray - 20, gray);
        canvas.drawRect(Rect.fromLTWH(x.toDouble(), y.toDouble(), 1, 1), paint);
      }
    }

    return recorder.endRecording().toImageSync(width, height);
  }
}
