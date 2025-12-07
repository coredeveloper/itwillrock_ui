import 'package:flutter/material.dart';
import 'constants/colors.dart';

/// A custom input border with a gradient outline.
///
/// This class is based on [OutlineInputBorder] and provides a gradient outline
/// for input fields.
class GradientOutlineInputBorder extends InputBorder {
  /// The accent color of the container.
  final Color? accentColor;

  /// The alignment of the accent.
  final Alignment? accentAlignment;

  /// The intensity of the accent.
  final double accentIntensity;

  /// Creates a gradient outline input border.
  ///
  /// The [borderSide], [borderRadius], and [gapPadding] arguments must not be null.
  GradientOutlineInputBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.gapPadding = 4.0,
    this.accentColor,
    this.accentAlignment,
    this.accentIntensity = 0,
  })  : assert(borderRadius != null),
        assert(gapPadding >= 0.0);

  static bool _cornersAreCircular(BorderRadius borderRadius) {
    return borderRadius.topLeft.x == borderRadius.topLeft.y &&
        borderRadius.bottomLeft.x == borderRadius.bottomLeft.y &&
        borderRadius.topRight.x == borderRadius.topRight.y &&
        borderRadius.bottomRight.x == borderRadius.bottomRight.y;
  }

  /// The padding for the gap between the border and the input field.
  final double gapPadding;

  /// The border radius of the outline.
  final BorderRadius? borderRadius;

  @override
  bool get isOutline => true;

  @override
  GradientOutlineInputBorder copyWith({BorderSide? borderSide}) {
    return GradientOutlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius,
      gapPadding: gapPadding,
      accentColor: accentColor,
      accentAlignment: accentAlignment,
      accentIntensity: accentIntensity,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(borderSide.width);
  }

  @override
  GradientOutlineInputBorder scale(double t) {
    BorderRadius radius = borderRadius ?? BorderRadius.zero;
    return GradientOutlineInputBorder(
      borderSide: borderSide.scale(t),
      borderRadius: radius * t,
      gapPadding: gapPadding * t,
      accentColor: accentColor,
      accentAlignment: accentAlignment,
      accentIntensity: accentIntensity,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is GradientOutlineInputBorder) {
      final GradientOutlineInputBorder outline = a;
      return GradientOutlineInputBorder(
        borderRadius: BorderRadius.lerp(outline.borderRadius, borderRadius, t),
        borderSide: BorderSide.lerp(outline.borderSide, borderSide, t),
        gapPadding: outline.gapPadding,
        accentColor: accentColor,
        accentAlignment: accentAlignment,
        accentIntensity: accentIntensity,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is GradientOutlineInputBorder) {
      final GradientOutlineInputBorder outline = b;
      return GradientOutlineInputBorder(
        borderRadius: BorderRadius.lerp(borderRadius, outline.borderRadius, t),
        borderSide: BorderSide.lerp(borderSide, outline.borderSide, t),
        gapPadding: outline.gapPadding,
        accentColor: accentColor,
        accentAlignment: accentAlignment,
        accentIntensity: accentIntensity,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius!
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(borderSide.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius!.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    assert(gapPercentage >= 0.0 && gapPercentage <= 1.0);
    assert(_cornersAreCircular(borderRadius!));

    final RRect outer = borderRadius!.toRRect(rect);

    final RRect center = outer.deflate(borderSide.width);

    final shadowPaint = Paint();

    final shaderRect = rect.deflate(borderSide.width);
    shadowPaint
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 + borderSide.width)
      ..shader = AppColors.reversedShadowGradient.createShader(shaderRect);

    canvas.save();
    canvas.clipRRect(center);
    canvas.drawPath(
        _calculateShadowPath(center, 3 - borderSide.width), shadowPaint);

    if (accentColor != null &&
        accentAlignment != null &&
        accentIntensity > 0.0) {
      final accentPaint = Paint()
        ..color = accentColor!
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 + borderSide.width)
        ..shader = LinearGradient(
          begin: accentAlignment!,
          end: Alignment(-accentAlignment!.x, -accentAlignment!.y),
          colors: [
            accentColor!.withValues(alpha: accentIntensity),
            accentColor!.withValues(alpha: 0.0),
          ],
          stops: const [0, 1],
        ).createShader(shaderRect);
      canvas.drawPath(
          _calculateShadowPath(center, 3 - borderSide.width), accentPaint);
    }
    canvas.restore();
  }

  Path _calculateShadowPath(RRect region, double shadowDepth) {
    var outerPath = Path()..addRRect(region);
    var innerPath = Path()..addRRect(region.deflate(shadowDepth));
    return Path.combine(PathOperation.difference, outerPath, innerPath);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final GradientOutlineInputBorder typedOther =
        other as GradientOutlineInputBorder;
    return typedOther.borderSide == borderSide &&
        typedOther.borderRadius == borderRadius &&
        typedOther.gapPadding == gapPadding &&
        typedOther.accentColor == accentColor &&
        typedOther.accentAlignment == accentAlignment &&
        typedOther.accentIntensity == accentIntensity;
  }

  @override
  int get hashCode => Object.hash(borderSide, borderRadius, gapPadding,
      accentColor, accentAlignment, accentIntensity);
}
