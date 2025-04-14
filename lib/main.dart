
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qadaa/app.dart';
import 'package:qadaa/viewmodels/prayer_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PrayerViewModel(),
      child: const QadaaApp(),
    ),
  );
}