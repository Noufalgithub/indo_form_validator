/// Configuration for validation behavior and error messages.
class ValidationConfig {
  /// Language for error messages ('id' for Indonesian, 'en' for English).
  final String language;

  /// Whether to use strict validation rules.
  final bool strict;

  /// Creates a validation configuration.
  const ValidationConfig({this.language = 'id', this.strict = false});

  /// Default configuration with Indonesian messages.
  static const ValidationConfig defaultConfig = ValidationConfig();

  /// Configuration with English messages.
  static const ValidationConfig english = ValidationConfig(language: 'en');

  /// Configuration with strict validation.
  static const ValidationConfig strictMode = ValidationConfig(strict: true);
}

/// Error messages for validators.
class ErrorMessages {
  /// Phone number error messages.
  static const Map<String, String> phone = {
    'id': 'Nomor telepon tidak valid',
    'en': 'Invalid phone number',
  };

  /// NIK error messages.
  static const Map<String, String> nik = {
    'id': 'NIK tidak valid',
    'en': 'Invalid NIK',
  };

  /// NPWP error messages.
  static const Map<String, String> npwp = {
    'id': 'NPWP tidak valid',
    'en': 'Invalid NPWP',
  };

  /// Email error messages.
  static const Map<String, String> email = {
    'id': 'Email tidak valid',
    'en': 'Invalid email',
  };

  /// Required field error messages.
  static const Map<String, String> required = {
    'id': 'Field ini wajib diisi',
    'en': 'This field is required',
  };

  /// Gets error message for the specified type and language.
  static String get(Map<String, String> messages, String language) {
    return messages[language] ?? messages['id']!;
  }
}
