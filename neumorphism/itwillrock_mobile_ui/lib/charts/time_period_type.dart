// Time period type enum
/// An enumeration representing different time periods.
///
/// This enum is used to specify the type of time period, which can be one of the following:
/// - `year`: Represents a yearly time period.
/// - `month`: Represents a monthly time period.
/// - `week`: Represents a weekly time period.
/// - `day`: Represents a daily time period.
enum TimePeriodType {
  /// Represents a time period type for a year.
  year,

  /// Represents a time period type for a month.
  month,

  /// Represents a time period type for a week.
  week,

  /// Represents a time period type for a day.
  day
}

/// Extension methods for the [TimePeriodType] enum.
extension TimePeriodTypeExtension on TimePeriodType {
  /// Returns the name of the time period type.
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
