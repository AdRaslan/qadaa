import 'package:qadaa/models/prayer_periods.dart';
import 'package:qadaa/models/prayer_results.dart';

class PrayerCalculator {
  static PrayerResults calculateMissedPrayers(PrayerPeriods periods) {
    const int prayersPerDay = 5;
    const int prayersPerWeek = prayersPerDay * 7;
    const int prayersPerMonth = prayersPerDay * 30; // Approximate
    const int prayersPerYear = prayersPerDay * 365; // Approximate

    int totalMissedPrayers = 0;

    // Sum up all missed prayers
    totalMissedPrayers += periods.days * prayersPerDay;
    totalMissedPrayers += periods.weeks * prayersPerWeek;
    totalMissedPrayers += periods.months * prayersPerMonth;
    totalMissedPrayers += periods.years * prayersPerYear;

    // Calculate how many of each prayer type was missed
    // Assuming equal distribution for simplicity in v1
    final Map<String, int> missedByType = {
      'Fajr': totalMissedPrayers ~/ 5,
      'Dhuhr': totalMissedPrayers ~/ 5,
      'Asr': totalMissedPrayers ~/ 5,
      'Maghrib': totalMissedPrayers ~/ 5,
      'Isha': totalMissedPrayers ~/ 5,
    };

    // Adjust for any remainder due to rounding
    final int remainder = totalMissedPrayers % 5;
    final List<String> prayerTypes = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
    for (var i = 0; i < remainder; i++) {
      missedByType[prayerTypes[i]] = (missedByType[prayerTypes[i]] ?? 0) + 1;
    }

    return PrayerResults(
      totalMissedPrayers: totalMissedPrayers,
      missedByType: missedByType,
    );
  }
}