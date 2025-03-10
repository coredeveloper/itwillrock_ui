import 'package:flutter/widgets.dart';
import '../neumorphic_indicator_list_painter.dart';
import '../neumorphism.dart';
import 'time_period_type.dart';

/// The width of each item in the list, measured in logical pixels.
const double itemWidth = 64;

/// A chart widget that displays different types of series.
///
/// This widget is a stateful widget that can be used to display various
/// types of data series in a chart format. It is part of the
/// `itwillrock_mobile_ui` package and is located in the
/// `lib/charts/series_type_chart.dart` file.
class SeriesTypesChart extends StatefulWidget {
  /// The color of the text.
  final Color textColor;

  /// The gradient to apply to the chart.
  final Gradient? gradient;

  /// The color of the chart.
  final Color color;

  /// Callback when an item is selected.
  final ValueChanged<TimePeriodType>? onItemSelected;

  /// Creates a [SeriesTypesChart] widget.
  const SeriesTypesChart(
      {super.key,
      required this.textColor,
      this.onItemSelected,
      this.gradient,
      required this.color});

  @override
  State<SeriesTypesChart> createState() => _SeriesTypesChartState();
}

class _SeriesTypesChartState extends State<SeriesTypesChart>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _bounceController;
  late Animation _positionTween;
  late Animation _bounceTween;
  TimePeriodType _selectedItem = TimePeriodType.day;

  List<Widget> buildItems(double width) {
    var items = <Widget>[];

    var length = TimePeriodType.values.length;
    for (int i = 0; i < length; i++) {
      items.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (TapDownDetails details) {
          _selectedItem = TimePeriodType.values[i];
          if (widget.onItemSelected != null) {
            widget.onItemSelected!(_selectedItem);
          }

          animateTo(i, width);
        },
        child: Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            alignment: const Alignment(0, 0),
            width: itemWidth,
            child: Neumorphism.text(TimePeriodType.values[i].name)),
      ));
    }
    return items;
  }

  void animateTo(int i, double width) {
    var length = TimePeriodType.values.length;
    var animateTo =
        (width / 2 - (length * itemWidth / 2) + (i * itemWidth)) / width;
    _animationController.animateTo(animateTo).whenCompleteOrCancel(() {
      if (mounted) {
        _bounceController.forward().whenCompleteOrCancel(() {
          if (mounted) {
            _bounceController.reverse();
          }
        });
      }
    });
  }

  @override
  void initState() {
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

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animateTo(0, width);
    });

    return AnimatedBuilder(
      animation: Listenable.merge([_bounceController, _animationController]),
      builder: (context, child) => CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: NeumorphicIndicatorListPainter(
              indicatorSize:
                  Size(itemWidth * (1 + _bounceTween.value * 0.05), 4),
              offset: Offset(
                  _positionTween.value * width + _bounceTween.value * 10, 24),
              blur: 0,
              color: widget.color,
              gradient: widget.gradient),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: buildItems(width),
                ),
              ])),
    );
  }
}
