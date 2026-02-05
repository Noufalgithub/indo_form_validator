import 'validation_result.dart';
import 'validation_config.dart';
import 'validators/phone_validator.dart';
import 'validators/nik_validator.dart';
import 'validators/npwp_validator.dart';
import 'validators/email_validator.dart';

/// Main validator class providing convenient access to all validators.
///
/// This class provides static methods that can be used directly in Flutter's
/// [FormField.validator] or for standalone validation.
///
/// Example:
/// ```dart
/// TextFormField(
///   validator: IndoValidator.phone(),
/// )
/// ```
class IndoValidator {
  /// Validates Indonesian phone number.
  ///
  /// Supports formats: 08xxxxxxxxxx, +628xxxxxxxxxx, 628xxxxxxxxxx
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: IndoValidator.phone(),
  /// )
  /// ```
  static String? Function(String?) phone({
    ValidationConfig config = ValidationConfig.defaultConfig,
  }) {
    return PhoneValidator.validator(config: config);
  }

  /// Validates Indonesian NIK (Nomor Induk Kependudukan).
  ///
  /// Validates 16-digit NIK with optional region code validation.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: IndoValidator.nik(),
  /// )
  /// ```
  static String? Function(String?) nik({
    ValidationConfig config = ValidationConfig.defaultConfig,
    bool validateRegion = false,
  }) {
    return NikValidator.validator(
      config: config,
      validateRegion: validateRegion,
    );
  }

  /// Validates Indonesian NPWP (Nomor Pokok Wajib Pajak).
  ///
  /// Validates 15-digit NPWP, supports formatted and non-formatted input.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: IndoValidator.npwp(),
  /// )
  /// ```
  static String? Function(String?) npwp({
    ValidationConfig config = ValidationConfig.defaultConfig,
  }) {
    return NpwpValidator.validator(config: config);
  }

  /// Validates email address.
  ///
  /// Uses RFC 5322 compliant regex pattern.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: IndoValidator.email(),
  /// )
  /// ```
  static String? Function(String?) email({
    ValidationConfig config = ValidationConfig.defaultConfig,
  }) {
    return EmailValidator.validator(config: config);
  }

  /// Chains multiple validators together.
  ///
  /// Returns the first error message encountered, or null if all pass.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: IndoValidator.chain([
  ///     IndoValidator.phone(),
  ///     (value) => value?.length == 12 ? null : 'Must be 12 digits',
  ///   ]),
  /// )
  /// ```
  static String? Function(String?) chain(
    List<String? Function(String?)> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }

  /// Creates a custom validator with a custom error message.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: IndoValidator.custom(
  ///     PhoneValidator.isValid,
  ///     'Nomor telepon harus valid',
  ///   ),
  /// )
  /// ```
  static String? Function(String?) custom(
    bool Function(String?) validationFunction,
    String errorMessage,
  ) {
    return (value) {
      return validationFunction(value) ? null : errorMessage;
    };
  }

  /// Validates phone number and returns [ValidationResult].
  static ValidationResult validatePhone(
    String? value, {
    ValidationConfig config = ValidationConfig.defaultConfig,
  }) {
    return PhoneValidator.validate(value, config: config);
  }

  /// Validates NIK and returns [ValidationResult].
  static ValidationResult validateNik(
    String? value, {
    ValidationConfig config = ValidationConfig.defaultConfig,
    bool validateRegion = false,
  }) {
    return NikValidator.validate(
      value,
      config: config,
      validateRegion: validateRegion,
    );
  }

  /// Validates NPWP and returns [ValidationResult].
  static ValidationResult validateNpwp(
    String? value, {
    ValidationConfig config = ValidationConfig.defaultConfig,
  }) {
    return NpwpValidator.validate(value, config: config);
  }

  /// Validates email and returns [ValidationResult].
  static ValidationResult validateEmail(
    String? value, {
    ValidationConfig config = ValidationConfig.defaultConfig,
  }) {
    return EmailValidator.validate(value, config: config);
  }
}
