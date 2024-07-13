class LabelSeriesModel {
  List<LabelModel> data = <LabelModel>[];
  double referenceValue = -1;
}

class LabelModel {
  final double value;
  final String label;
  LabelModel({required this.label, required this.value});
}
