
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qadaa/models/prayer_periods.dart';
import 'package:qadaa/utils/validators.dart';
import 'package:qadaa/viewmodels/prayer_viewmodel.dart';

class PrayerInputForm extends StatefulWidget {
  const PrayerInputForm({super.key});

  @override
  _PrayerInputFormState createState() => _PrayerInputFormState();
}

class _PrayerInputFormState extends State<PrayerInputForm> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _weeksController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load existing values if any
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<PrayerViewModel>(context, listen: false);
      final periods = viewModel.periods;
      if (periods != null) {
        _daysController.text = periods.days > 0 ? periods.days.toString() : '';
        _weeksController.text = periods.weeks > 0 ? periods.weeks.toString() : '';
        _monthsController.text = periods.months > 0 ? periods.months.toString() : '';
        _yearsController.text = periods.years > 0 ? periods.years.toString() : '';
      }
    });
  }

  @override
  void dispose() {
    _daysController.dispose();
    _weeksController.dispose();
    _monthsController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  void _calculatePrayers() {
    if (_formKey.currentState!.validate()) {
      final periods = PrayerPeriods(
        days: int.tryParse(_daysController.text) ?? 0,
        weeks: int.tryParse(_weeksController.text) ?? 0,
        months: int.tryParse(_monthsController.text) ?? 0,
        years: int.tryParse(_yearsController.text) ?? 0,
      );

      // At least one period must be greater than 0
      if (periods.days <= 0 && periods.weeks <= 0 && 
          periods.months <= 0 && periods.years <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter at least one period'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      // Calculate prayers using the ViewModel
      final viewModel = Provider.of<PrayerViewModel>(context, listen: false);
      viewModel.calculatePrayers(periods);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calculate Missed Prayers',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _daysController,
                decoration: const InputDecoration(
                  labelText: 'Days without prayer',
                  hintText: '0',
                ),
                keyboardType: TextInputType.number,
                validator: Validators.validateNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _weeksController,
                decoration: const InputDecoration(
                  labelText: 'Weeks without prayer',
                  hintText: '0',
                ),
                keyboardType: TextInputType.number,
                validator: Validators.validateNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _monthsController,
                decoration: const InputDecoration(
                  labelText: 'Months without prayer',
                  hintText: '0',
                ),
                keyboardType: TextInputType.number,
                validator: Validators.validateNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _yearsController,
                decoration: const InputDecoration(
                  labelText: 'Years without prayer',
                  hintText: '0',
                ),
                keyboardType: TextInputType.number,
                validator: Validators.validateNumber,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculatePrayers,
                  child: const Text('Calculate'),
                ),
              ),
              const SizedBox(height: 8),
              Consumer<PrayerViewModel>(
                builder: (context, viewModel, _) {
                  if (viewModel.hasResults) {
                    return Center(
                      child: TextButton(
                        onPressed: viewModel.clearResults,
                        child: const Text('Clear Results'),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}