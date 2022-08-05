import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MenuContainer extends SingleChildRenderObjectWidget {
  const MenuContainer({
    Key key,
    @required this.shiftValue,
    Widget child,
  })  : assert(shiftValue != null),
        super(key: key, child: child);

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
    renderObject..shiftValue = shiftValue;
  }
}

class RenderMenuContainer extends RenderProxyBox {
  RenderMenuContainer({
    double shiftValue = 0,
    RenderBox child,
  })  : assert(shiftValue != null),
        _shiftValue = shiftValue,
        super(child);

  double get shiftValue => _shiftValue;
  double _shiftValue;
  set shiftValue(double shiftValue) {
    assert(shiftValue != null);
    if (_shiftValue == shiftValue) return;
    _shiftValue = shiftValue;
    markNeedsPaint();
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
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
      context.paintChild(child, offset);
    }
  }
}
