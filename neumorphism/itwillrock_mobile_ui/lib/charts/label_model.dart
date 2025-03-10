/// A model representing a series of labels in a chart.
class LabelSeriesModel {
  /// The data to display on the chart.
  List<LabelModel> data = <LabelModel>[];

  /// The reference value for the chart.
  double referenceValue = -1;
}

/// A model representing a single label in a chart.
class LabelModel {
  /// The value of the label.
  final double value;

  /// The label text.
  final String label;

  /// Creates a [LabelModel].
  LabelModel({required this.label, required this.value});
}
