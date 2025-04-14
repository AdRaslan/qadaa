
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qadaa/models/prayer_periods.dart';
import 'package:qadaa/models/prayer_results.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _resultsKey = 'prayer_results';
  static const String _periodsKey = 'prayer_periods';

  // Save calculation results
  Future<bool> saveResults(PrayerResults results, PrayerPeriods periods) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Convert to JSON and save
      await prefs.setString(_resultsKey, jsonEncode(results.toJson()));
      await prefs.setString(_periodsKey, jsonEncode(periods.toJson()));
      
      return true;
    } catch (e) {
      // Handle error
      debugPrint('Error saving data: $e');
      return false;
    }
  }

  // Load saved calculation results
  Future<Map<String, dynamic>?> loadSavedCalculation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final resultsJson = prefs.getString(_resultsKey);
      final periodsJson = prefs.getString(_periodsKey);
      
      if (resultsJson == null || periodsJson == null) {
        return null;
      }
      
      final PrayerResults results = PrayerResults.fromJson(
        jsonDecode(resultsJson)
      );
      
      final PrayerPeriods periods = PrayerPeriods.fromJson(
        jsonDecode(periodsJson)
      );
      
      return {
        'results': results,
        'periods': periods,
      };
    } catch (e) {
      // Handle error
      debugPrint('Error loading data: $e');
      return null;
    }
  }
}