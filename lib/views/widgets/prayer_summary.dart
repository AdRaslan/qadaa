
import 'package:flutter/material.dart';
import 'package:qadaa/models/prayer_results.dart';

class PrayerSummary extends StatelessWidget {
  final PrayerResults results;

  const PrayerSummary({
    super.key,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prayer Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'Total Missed Prayers: ${results.totalMissedPrayers}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Breakdown by Prayer Type:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            ...results.missedByType.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '${entry.key}: ${entry.value} prayers',
                  style: const TextStyle(fontSize: 15),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
