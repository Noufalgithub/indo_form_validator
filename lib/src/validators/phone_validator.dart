import '../validation_result.dart';
import '../validation_config.dart';

/// Validator for Indonesian phone numbers.
class PhoneValidator {
  /// Validates Indonesian phone number format.
  ///
  /// Supports formats:
  /// - 08xxxxxxxxxx (10-13 digits)
  /// - +628xxxxxxxxxx
  /// - 628xxxxxxxxxx
  ///
  /// Returns [ValidationResult] with validation status and error message.
  static ValidationResult validate(
    String? value, {
    ValidationConfig config = ValidationConfig.defaultConfig,
  }) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid(
        ErrorMessages.get(ErrorMessages.required, config.language),
      );
    }

    // Remove spaces, dashes, and parentheses
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check for valid Indonesian phone number patterns
    final patterns = [
      RegExp(r'^08\d{8,11}$'), // 08xxxxxxxxxx
      RegExp(r'^\+628\d{8,11}$'), // +628xxxxxxxxxx
      RegExp(r'^628\d{8,11}$'), // 628xxxxxxxxxx
    ];

    final isValid = patterns.any((pattern) => pattern.hasMatch(cleaned));

    if (!isValid) {
      return ValidationResult.invalid(
        ErrorMessages.get(ErrorMessages.phone, config.language),
      );
    }

    return const ValidationResult.valid();
  }

  /// Validates phone number and returns error message or null.
  ///
  /// Compatible with Flutter's [FormField.validator].
  static String? Function(String?) validator({
    ValidationConfig config = ValidationConfig.defaultConfig,
  }) {
    return (value) {
      final result = validate(value, config: config);
      return result.isValid ? null : result.message;
    };
  }

  /// Quick boolean check for phone number validity.
  static bool isValid(String? value) {
    return validate(value).isValid;
  }
}
