class PrayerResults {
  final int totalMissedPrayers;
  final Map<String, int> missedByType;

  PrayerResults({
    required this.totalMissedPrayers,
    required this.missedByType,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalMissedPrayers': totalMissedPrayers,
      'missedByType': missedByType,
    };
  }

  factory PrayerResults.fromJson(Map<String, dynamic> json) {
    // Convert the map back from JSON
    Map<String, int> missedByType = {};
    if (json['missedByType'] != null) {
      (json['missedByType'] as Map).forEach((key, value) {
        missedByType[key.toString()] = (value as num).toInt();
      });
    }

    return PrayerResults(
      totalMissedPrayers: json['totalMissedPrayers'] ?? 0,
      missedByType: missedByType,
    );
  }
}