class Validators {
  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Empty is valid (will be treated as 0)
    }
    
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    
    if (int.parse(value) < 0) {
      return 'Please enter a non-negative number';
    }
    
    return null;
  }
}