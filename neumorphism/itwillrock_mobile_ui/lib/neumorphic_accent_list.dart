import 'package:flutter/widgets.dart';
import 'constants/distances.dart';
import 'constants/text.dart';
import 'neumorphic_accent_list_painter.dart';

/// The height of each item in the list, measured in logical pixels.
const double itemHeight = 42;

/// A callback function type definition that takes a [double] value representing
/// the intensity of the accent.
///
/// This callback can be used to handle changes in accent intensity, for example,
/// in a UI component that allows users to adjust the intensity of a neumorphic effect.
///
/// The [intensity] parameter represents the level of intensity, where higher values
/// indicate a stronger effect.
typedef AccentCallback = void Function(double intensity);

/// A widget that displays a list with a neumorphic accent.
///
/// The [NeumorphicAccentList] widget displays a list of items with a neumorphic
/// accent effect. It uses [NeumorphicAccentListPainter] to paint the accent.
class NeumorphicAccentList extends StatefulWidget {
  /// The margin around the list.
  final EdgeInsets margin;

  /// The padding inside the list.
  final EdgeInsets padding;

  /// Callback when an item is selected.
  final ValueChanged<String>? onItemSelected;

  /// The currently selected item.
  final String? selectedItem;

  /// Callback when the accent changes.
  final AccentCallback? accentChanged;

  /// The color of the accent.
  final Color color;

  /// The color of the text.
  final Color textColor;

  /// The list of items to display.
  final List<String> items;

  /// Creates a [NeumorphicAccentList] widget.
  ///
  /// The [items] argument must not be null.
  const NeumorphicAccentList({
    this.padding = emptyPadding,
    this.margin = emptyMargin,
    this.color = const Color.fromARGB(0, 0, 0, 0),
    this.textColor = const Color.fromARGB(0, 0, 0, 0),
    this.onItemSelected,
    this.selectedItem,
    this.accentChanged,
    required this.items,
    super.key,
  });

  @override
  NeumorphicAccentListState createState() => NeumorphicAccentListState();
}

/// The state for a [NeumorphicAccentList] widget.
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _selectItem(widget.selectedItem!);
      });
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

  /// Selects an item based on the provided [item] string.
  ///
  /// This method performs the necessary actions to handle the selection
  /// of an item within the application.
  ///
  /// [item]: The identifier of the item to be selected.
  void selectItem(String item) {
    setState(() {
      _selectItem(item);
    });
  }

  /// Builds a list of widgets to be displayed as items.
  ///
  /// This method creates and returns a list of [Widget] objects that
  /// represent the items in the list. The specific implementation
  /// details of how the items are built are not provided in this
  /// documentation comment.
  ///
  /// Returns:
  ///   A list of [Widget] objects representing the items.
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

          _animationController
              .animateTo(1 / widget.items.length * i)
              .whenCompleteOrCancel(() {
            if (widget.onItemSelected != null) {
              widget.onItemSelected!(_selectedItem!);
            }
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
                            widget.margin.top +
                            _bounceTween.value * 10),
                    shadows: [
                      Shadow(
                        color: widget.color.withAlpha(20),
                        blurRadius: 24,
                        offset: const Offset(12, 0),
                      ),
                      Shadow(
                        color: widget.color.withAlpha(50),
                        blurRadius: 16,
                        offset: const Offset(4, 0),
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
