import 'dart:ui';

/// A utility class for handling color-related operations.
class ColorsUtils {
  /// Darkens the given color by the given percentage.
  static Color darken(Color c, [int percent = 10]) {
    if (percent == 0) return c;
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB((c.a * 255).round(), (c.r * 255 * f).round(),
        (c.g * 255 * f).round(), (c.b * 255 * f).round());
  }

  /// Lightens the given color by the given percentage.
  static Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        (c.a * 255).round(),
        (c.r * 255 + ((255 - c.r * 255) * p)).round(),
        (c.g * 255 + ((255 - c.g * 255) * p)).round(),
        (c.b * 255 + ((255 - c.b * 255) * p)).round());
  }
}
