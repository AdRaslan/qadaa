class PrayerPeriods {
  final int days;
  final int weeks;
  final int months;
  final int years;

  PrayerPeriods({
    this.days = 0,
    this.weeks = 0,
    this.months = 0,
    this.years = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'weeks': weeks,
      'months': months,
      'years': years,
    };
  }

  factory PrayerPeriods.fromJson(Map<String, dynamic> json) {
    return PrayerPeriods(
      days: json['days'] ?? 0,
      weeks: json['weeks'] ?? 0,
      months: json['months'] ?? 0,
      years: json['years'] ?? 0,
    );
  }
}