import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A widget that represents a container for a menu.
///
/// This widget extends [SingleChildRenderObjectWidget] and is used to
/// create a custom render object for a menu container in the UI.
class MenuContainer extends SingleChildRenderObjectWidget {
  /// Creates a [MenuContainer].
  const MenuContainer({
    super.key,
    required this.shiftValue,
    super.child,
  });

  /// The amount to shift the menu container.
  final double shiftValue;
  @override
  RenderMenuContainer createRenderObject(BuildContext context) {
    return RenderMenuContainer(
      shiftValue: shiftValue,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderMenuContainer renderObject) {
    renderObject.shiftValue = shiftValue;
  }
}

/// A custom render object that extends [RenderProxyBox] to provide
/// additional functionality for rendering a menu container.
///
/// This class is responsible for handling the rendering logic of
/// the menu container in the application. It can be used to apply
/// custom painting, layout, and hit testing behavior specific to
/// the menu container.
class RenderMenuContainer extends RenderProxyBox {
  /// Creates a [RenderMenuContainer].
  RenderMenuContainer({
    double shiftValue = 0,
    RenderBox? child,
  })  : _shiftValue = shiftValue,
        super(child);

  /// The amount to shift the menu container.
  double get shiftValue => _shiftValue;
  double _shiftValue;
  set shiftValue(double shiftValue) {
    if (_shiftValue == shiftValue) return;
    _shiftValue = shiftValue;
    markNeedsPaint();
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    assert(!debugNeedsLayout);
    return result.addWithPaintOffset(
      offset: Offset(shiftValue, shiftValue / 4),
      position: position,
      hitTest: (BoxHitTestResult result, Offset position) {
        return super.hitTestChildren(result, position: position);
      },
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      offset = offset.translate(shiftValue, shiftValue / 4);
      context.paintChild(child!, offset);
    }
  }
}
