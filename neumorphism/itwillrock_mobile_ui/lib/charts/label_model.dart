class LabelSeriesModel {
  List<LabelModel> data = <LabelModel>[];
  int splitIndex = 0;
}


class LabelModel {
  final double value;
  final String label;
  LabelModel({required this.label, required this.value});
}