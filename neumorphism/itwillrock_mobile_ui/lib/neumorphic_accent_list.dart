import 'package:flutter/widgets.dart';
import 'constants/distances.dart';
import 'constants/text.dart';
import 'neumorphic_accent_list_painter.dart';

const double itemHeight = 42;
typedef AccentCallback = void Function(double intensity);

class NeumorphicAccentList extends StatefulWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final ValueChanged<String>? onItemSelected;
  final String? selectedItem;
  final AccentCallback? accentChanged;
  final Color color;
  final Color textColor;
  final List<String> items;
  const NeumorphicAccentList(
      {this.padding = emptyPadding,
      this.margin = emptyMargin,
      this.color = const Color.fromARGB(0, 0, 0, 0),
      this.textColor = const Color.fromARGB(0, 0, 0, 0),
      this.onItemSelected,
      this.selectedItem,
      this.accentChanged,
      required this.items,
      Key? key})
      : super(key: key);

  @override
  NeumorphicAccentListState createState() => NeumorphicAccentListState();
}

class NeumorphicAccentListState extends State<NeumorphicAccentList>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _bounceController;
  late Animation _positionTween;
  late Animation _bounceTween;
  String? _selectedItem;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _positionTween =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
    _bounceTween = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _bounceController, curve: Curves.easeIn));
    if (widget.selectedItem != null) {
      _selectItem(widget.selectedItem!);
      _selectedItem = widget.selectedItem;
    }
  }

  void _selectItem(String item) {
    var index = widget.items.indexOf(item);
    if (index > -1) {
      _animationController.value = 1 / widget.items.length * index;
      _selectedItem = item;
      if (widget.onItemSelected != null) {
        widget.onItemSelected!(_selectedItem!);
      }
    }
  }

  List<Widget> buildItems() {
    var items = <Widget>[];

    var length = widget.items.length;
    for (int i = 0; i < length; i++) {
      items.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (TapDownDetails details) {
          if (_selectedItem == widget.items[i]) {
            return;
          }
          _selectedItem = widget.items[i];
          if (widget.onItemSelected != null) {
            widget.onItemSelected!(_selectedItem!);
          }
          _animationController
              .animateTo(1 / widget.items.length * i)
              .whenCompleteOrCancel(() {
            _bounceController.forward().whenCompleteOrCancel(() {
              _bounceController.reverse();
            });
          });
        },
        child: Container(
          width: 300,
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.only(left: 3),
          alignment: const Alignment(-1, 0),
          height: itemHeight,
          child: Text(
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
    if (_selectedItem == null && widget.items.isNotEmpty) {
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
    return AnimatedBuilder(
        animation: Listenable.merge([_bounceController, _animationController]),
        builder: (context, child) => Container(
              margin: widget.margin,
              child: RepaintBoundary(
                child: CustomPaint(
                  size: const Size(double.infinity, double.infinity),
                  painter: NeumorphicAccentListPainter(
                    indicatorSize: Size(8 * (1.0 + _bounceTween.value * 0.05),
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
                        offset: const Offset(19, 0),
                      ),
                      Shadow(
                        color: widget.color,
                        blurRadius: 10,
                        offset: const Offset(5, 0),
                      ),
                    ],
                    blur: 0,
                    color: widget.color,
                  ),
                  child: Container(
                    alignment: const Alignment(-1, -1),
                    margin: const EdgeInsets.all(0),
                    padding: widget.padding,
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
