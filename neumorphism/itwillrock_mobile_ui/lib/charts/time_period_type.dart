enum TimePeriodType { year, month, week, day }

extension TimePeriodTypeExtension on TimePeriodType {
  String get name {
    switch (this) {
      case TimePeriodType.year:
        return 'Year';
      case TimePeriodType.month:
        return 'Month';
      case TimePeriodType.week:
        return 'Week';
      case TimePeriodType.day:
        return 'Day';
    }
  }
}
