import 'package:flutter/widgets.dart';
import '../neumorphism.dart';
import 'chart_painter.dart';
import 'label_model.dart';

class ChartSeries extends StatefulWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color textColor;
  final ValueNotifier<LabelSeriesModel> values;

  const ChartSeries({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    required this.textColor,
    required this.values,
  });

  @override
  State<ChartSeries> createState() => _ChartSeriesState();
}

class _ChartSeriesState extends State<ChartSeries> {
  List<Widget> buildItems(double width) {
    var items = <Widget>[];

    var length = widget.values.value.data.length;
    var itemWidth = width / length;
    for (int i = 0; i < length; i++) {
      items.add(Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        alignment: const Alignment(0, 0),
        width: itemWidth,
        child: Neumorphism.text(widget.values.value.data[i].label),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;
        return ValueListenableBuilder<LabelSeriesModel>(
          valueListenable: widget.values,
          builder: (context, values, child) {
            return CustomPaint(
              size: Size(width, double.infinity),
              painter: ChartPainter(
                verticalOffset: 15,
                series: values,
                blur: 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: height - 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: buildItems(width),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
