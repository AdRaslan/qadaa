
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qadaa/viewmodels/prayer_viewmodel.dart';
import 'package:qadaa/views/widgets/prayer_chart.dart';
import 'package:qadaa/views/widgets/prayer_input_form.dart';
import 'package:qadaa/views/widgets/prayer_summary.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize the ViewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PrayerViewModel>(context, listen: false).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qadaa Prayer Calculator'),
      ),
      body: Consumer<PrayerViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const PrayerInputForm(),
                if (viewModel.results != null) ...[
                  const SizedBox(height: 16),
                  PrayerSummary(results: viewModel.results!),
                  const SizedBox(height: 16),
                  PrayerChart(results: viewModel.results!),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}