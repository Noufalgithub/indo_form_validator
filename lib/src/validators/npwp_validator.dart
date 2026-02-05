import '../validation_result.dart';
import '../validation_config.dart';

/// Validator for Indonesian NPWP (Nomor Pokok Wajib Pajak).
class NpwpValidator {
  /// Validates Indonesian NPWP format.
  ///
  /// Requirements:
  /// - 15 digits
  /// - Numeric only
  /// - Supports formatted (XX.XXX.XXX.X-XXX.XXX) and non-formatted input
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

    // Remove formatting characters (dots, dashes, spaces)
    final cleaned = value.replaceAll(RegExp(r'[\s\.\-]'), '');

    // Check if exactly 15 digits
    if (cleaned.length != 15) {
      return ValidationResult.invalid(
        ErrorMessages.get(ErrorMessages.npwp, config.language),
      );
    }

    // Check if numeric only
    if (!RegExp(r'^\d{15}$').hasMatch(cleaned)) {
      return ValidationResult.invalid(
        ErrorMessages.get(ErrorMessages.npwp, config.language),
      );
    }

    // Optional: Validate formatted input structure
    if (config.strict && value.contains('.')) {
      // Expected format: XX.XXX.XXX.X-XXX.XXX
      if (!RegExp(
        r'^\d{2}\.\d{3}\.\d{3}\.\d{1}-\d{3}\.\d{3}$',
      ).hasMatch(value)) {
        return ValidationResult.invalid(
          ErrorMessages.get(ErrorMessages.npwp, config.language),
        );
      }
    }

    return const ValidationResult.valid();
  }

  /// Validates NPWP and returns error message or null.
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

  /// Quick boolean check for NPWP validity.
  static bool isValid(String? value) {
    return validate(value).isValid;
  }

  /// Formats a valid NPWP string to standard format (XX.XXX.XXX.X-XXX.XXX).
  ///
  /// Returns null if the input is invalid.
  static String? format(String? value) {
    if (value == null || value.isEmpty) return null;

    final cleaned = value.replaceAll(RegExp(r'[\s\.\-]'), '');
    if (cleaned.length != 15 || !RegExp(r'^\d{15}$').hasMatch(cleaned)) {
      return null;
    }

    return '${cleaned.substring(0, 2)}.${cleaned.substring(2, 5)}.${cleaned.substring(5, 8)}.${cleaned.substring(8, 9)}-${cleaned.substring(9, 12)}.${cleaned.substring(12, 15)}';
  }
}
