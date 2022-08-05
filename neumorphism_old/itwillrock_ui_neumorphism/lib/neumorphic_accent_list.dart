import 'package:flutter/widgets.dart';
import '../../../constants/text.dart';
import 'neumorphic_accent_list_painter.dart';

const double itemHeight = 42;
typedef AccentCallback = void Function(double intensity);

class NeumorphicAccentList extends StatefulWidget {
  final double margin;
  final double padding;
  final ValueChanged<String> onItemSelected;
  final String selectedItem;
  final AccentCallback accentChanged;
  final Color color;
  final Color textColor;
  final List<String> items;
  NeumorphicAccentList(
      {this.padding,
      this.margin,
      this.color,
      this.textColor,
      this.onItemSelected,
      this.selectedItem,
      this.accentChanged,
      this.items});

  @override
  _NeumorphicAccentListState createState() => _NeumorphicAccentListState();
}

class _NeumorphicAccentListState extends State<NeumorphicAccentList>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _bounceController;
  Animation _positionTween;
  Animation _bounceTween;
  String _selectedItem;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _bounceController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 120),
    );
    _positionTween =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
    _bounceTween = Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(parent: _bounceController, curve: Curves.easeIn));
    if (widget.selectedItem != null) {
      _selectItem(widget.selectedItem);
      _selectedItem = widget.selectedItem;
    }
  }

  void _selectItem(String item) {
    var index = widget.items.indexOf(item);
    if (index > -1) {
      _animationController.value = 1 / widget.items.length * index;
      _selectedItem = item;
      if (widget.onItemSelected != null) {
        widget.onItemSelected(_selectedItem);
      }
    }
  }

  List<Widget> buildItems() {
    var items = <Widget>[];
    if (widget.items == null) {
      return items;
    }
    var length = widget.items.length;
    for (int i = 0; i < length; i++) {
      items.add(new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (TapDownDetails details) {
          if (_selectedItem == widget.items[i]) {
            return;
          }
          _selectedItem = widget.items[i];
          if (widget.onItemSelected != null) {
            widget.onItemSelected(_selectedItem);
          }
          _animationController
              .animateTo(1 / widget.items.length * i)
              .whenCompleteOrCancel(() {
            _bounceController.forward().whenCompleteOrCancel(() {
              _bounceController.reverse();
            });
          });
        },
        child: new Container(
          width: 300,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.only(left: 3),
          alignment: Alignment(-1, 0),
          height: itemHeight,
          child: new Text(
            widget.items[i],
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              color: widget.textColor,
              fontFamily: defaultFontFamily,
            ),
          ),
        ),
      ));
    }
    if (_selectedItem == null &&
        widget.items != null &&
        widget.items.length > 0) {
      _selectItem(widget.items[0]);
    }
    return items;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
        animation: Listenable.merge([_bounceController, _animationController]),
        builder: (context, child) => new Container(
              margin: new EdgeInsets.all(widget.margin),
              child: RepaintBoundary(
                child: new CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: NeumorphicAccentListPainter(
                    indicatorSize: Size(8 * (1 + _bounceTween.value * 0.05),
                        itemHeight * (1 - _bounceTween.value * 0.1)),
                    offset: Offset(
                        0,
                        _positionTween.value *
                                itemHeight *
                                widget.items.length +
                            widget.margin +
                            _bounceTween.value * 10),
                    shadows: [
                      Shadow(
                        color: widget.color,
                        blurRadius: 12,
                        offset: Offset(19, 0),
                      ),
                      Shadow(
                        color: widget.color,
                        blurRadius: 10,
                        offset: Offset(5, 0),
                      ),
                    ],
                    blur: 0,
                    color: widget.color,
                  ),
                  child: new Container(
                    alignment: Alignment(-1, -1),
                    margin: new EdgeInsets.all(0),
                    padding: new EdgeInsets.all(widget.padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: buildItems(),
                    ),
                  ),
                ),
              ),
            ));
  }
}
