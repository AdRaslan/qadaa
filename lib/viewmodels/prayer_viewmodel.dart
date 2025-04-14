import 'package:flutter/material.dart';
import 'package:qadaa/models/prayer_periods.dart';
import 'package:qadaa/models/prayer_results.dart';
import 'package:qadaa/services/prayer_calculator.dart';
import 'package:qadaa/services/storage_service.dart';

class PrayerViewModel extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  
  PrayerResults? _results;
  PrayerPeriods? _periods;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  PrayerResults? get results => _results;
  PrayerPeriods? get periods => _periods;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasResults => _results != null;

  // Initialize ViewModel - load saved data if available
  Future<void> initialize() async {
    _setLoading(true);
    try {
      final savedData = await _storageService.loadSavedCalculation();
      if (savedData != null) {
        _results = savedData['results'] as PrayerResults;
        _periods = savedData['periods'] as PrayerPeriods;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to load saved data';
    } finally {
      _setLoading(false);
    }
  }

  // Calculate missed prayers
  void calculatePrayers(PrayerPeriods periods) {
    _periods = periods;
    _results = PrayerCalculator.calculateMissedPrayers(periods);
    _saveData();
    notifyListeners();
  }

  // Save data to local storage
  Future<void> _saveData() async {
    if (_results != null && _periods != null) {
      await _storageService.saveResults(_results!, _periods!);
    }
  }

  // Clear current results
  void clearResults() {
    _results = null;
    _periods = null;
    notifyListeners();
  }

  // Helper to set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}