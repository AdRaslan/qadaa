
import 'package:flutter/material.dart';
import 'package:qadaa/core/theme/app_theme.dart';
import 'package:qadaa/views/screens/calculator_screen.dart';

class QadaaApp extends StatelessWidget {
  const QadaaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qadaa Prayer Tracker',
      theme: AppTheme.lightTheme,
      home: const CalculatorScreen(),
    );
  }
}