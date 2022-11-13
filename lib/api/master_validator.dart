enum ValidatorFlags {
  NonEmpty,
  OnlyDigits,
  Email,
  OnlyDouble,
}

class MasterValidator {
  static String? Function(String? value)? attach({
    List<ValidatorFlags>? flags,
    String msgPrefix = 'Field',
    String? Function(String value)? customValidation,
  }) {
    if (flags == null || flags.isEmpty) {
      return null;
    }
    return (value) {
      if (flags.contains(ValidatorFlags.NonEmpty) &&
          (value == null || value.trim().isEmpty)) {
        return '$msgPrefix is required';
      }
      if (flags.contains(ValidatorFlags.OnlyDigits) &&
          (int.tryParse(value!) == null)) {
        return '$msgPrefix can only contain numbers';
      }
      if (flags.contains(ValidatorFlags.OnlyDouble) &&
          (double.tryParse(value!) == null)) {
        return 'Invalid $msgPrefix format';
      }
      if (flags.contains(ValidatorFlags.Email) && (!value!.contains('@'))) {
        return 'Invalid email';
      }
      if (customValidation != null) {
        return customValidation(value!);
      }
      return null;
    };
  }
}
