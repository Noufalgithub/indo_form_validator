import '../validation_result.dart';
import '../validation_config.dart';

/// Validator for email addresses.
class EmailValidator {
  /// RFC 5322 compliant email regex pattern.
  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
  );

  /// Validates email address format.
  ///
  /// Uses RFC 5322 compliant regex pattern.
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

    // Trim whitespace
    final trimmed = value.trim();

    // Check email format
    if (!_emailRegex.hasMatch(trimmed)) {
      return ValidationResult.invalid(
        ErrorMessages.get(ErrorMessages.email, config.language),
      );
    }

    // Additional strict validation
    if (config.strict) {
      // Check for consecutive dots
      if (trimmed.contains('..')) {
        return ValidationResult.invalid(
          ErrorMessages.get(ErrorMessages.email, config.language),
        );
      }

      // Check for valid TLD length (at least 2 characters)
      final parts = trimmed.split('@');
      if (parts.length == 2) {
        final domainParts = parts[1].split('.');
        if (domainParts.isNotEmpty && domainParts.last.length < 2) {
          return ValidationResult.invalid(
            ErrorMessages.get(ErrorMessages.email, config.language),
          );
        }
      }
    }

    return const ValidationResult.valid();
  }

  /// Validates email and returns error message or null.
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

  /// Quick boolean check for email validity.
  static bool isValid(String? value) {
    return validate(value).isValid;
  }
}
