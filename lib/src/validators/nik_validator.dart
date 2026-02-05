import '../validation_result.dart';
import '../validation_config.dart';

/// Validator for Indonesian NIK (Nomor Induk Kependudukan).
class NikValidator {
  /// Validates Indonesian NIK format.
  ///
  /// Requirements:
  /// - Exactly 16 digits
  /// - Numeric only
  /// - Optional: Basic region code validation (first 6 digits)
  ///
  /// Returns [ValidationResult] with validation status and error message.
  static ValidationResult validate(
    String? value, {
    ValidationConfig config = ValidationConfig.defaultConfig,
    bool validateRegion = false,
  }) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid(
        ErrorMessages.get(ErrorMessages.required, config.language),
      );
    }

    // Remove spaces and dashes
    final cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');

    // Check if exactly 16 digits
    if (cleaned.length != 16) {
      return ValidationResult.invalid(
        ErrorMessages.get(ErrorMessages.nik, config.language),
      );
    }

    // Check if numeric only
    if (!RegExp(r'^\d{16}$').hasMatch(cleaned)) {
      return ValidationResult.invalid(
        ErrorMessages.get(ErrorMessages.nik, config.language),
      );
    }

    // Optional: Basic region code validation
    if (config.strict || validateRegion) {
      final provinceCode = cleaned.substring(0, 2);
      final regencyCode = cleaned.substring(2, 4);
      final districtCode = cleaned.substring(4, 6);

      // Province code should be between 11-94
      final province = int.tryParse(provinceCode);
      if (province == null || province < 11 || province > 94) {
        return ValidationResult.invalid(
          ErrorMessages.get(ErrorMessages.nik, config.language),
        );
      }

      // Regency and district codes should be valid (01-99)
      final regency = int.tryParse(regencyCode);
      final district = int.tryParse(districtCode);
      if (regency == null ||
          regency < 1 ||
          regency > 99 ||
          district == null ||
          district < 1 ||
          district > 99) {
        return ValidationResult.invalid(
          ErrorMessages.get(ErrorMessages.nik, config.language),
        );
      }
    }

    return const ValidationResult.valid();
  }

  /// Validates NIK and returns error message or null.
  ///
  /// Compatible with Flutter's [FormField.validator].
  static String? Function(String?) validator({
    ValidationConfig config = ValidationConfig.defaultConfig,
    bool validateRegion = false,
  }) {
    return (value) {
      final result = validate(
        value,
        config: config,
        validateRegion: validateRegion,
      );
      return result.isValid ? null : result.message;
    };
  }

  /// Quick boolean check for NIK validity.
  static bool isValid(String? value, {bool validateRegion = false}) {
    return validate(value, validateRegion: validateRegion).isValid;
  }
}
