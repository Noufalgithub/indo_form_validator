// Simple standalone validation examples
// Run with: dart run example/simple_example.dart

import 'package:indo_form_validator/indo_form_validator.dart';

void main() {
  print('=== Indo Form Validator Examples ===\n');

  // Phone Number Validation
  print('1. Phone Number Validation:');
  testPhone('081234567890'); // Valid
  testPhone('+628123456789'); // Valid
  testPhone('0712345678'); // Invalid
  print('');

  // NIK Validation
  print('2. NIK Validation:');
  testNik('3201234567890123'); // Valid
  testNik('123456789012345'); // Invalid (15 digits)
  print('');

  // NPWP Validation
  print('3. NPWP Validation:');
  testNpwp('123456789012345'); // Valid
  testNpwp('12.345.678.9-012.345'); // Valid (formatted)
  testNpwp('12345678901234'); // Invalid (14 digits)
  print('');

  // Email Validation
  print('4. Email Validation:');
  testEmail('user@example.com'); // Valid
  testEmail('invalid@'); // Invalid
  print('');

  // NPWP Formatting
  print('5. NPWP Formatting:');
  final formatted = NpwpValidator.format('123456789012345');
  print('   Formatted: $formatted');
  print('');

  // Custom Configuration
  print('6. English Error Messages:');
  final result = PhoneValidator.validate(
    'invalid',
    config: ValidationConfig.english,
  );
  print('   Error: ${result.message}');
  print('');

  // Validator Chaining
  print('7. Validator Chaining:');
  final chainedValidator = IndoValidator.chain([
    IndoValidator.phone(),
    (value) {
      final cleaned = value?.replaceAll(RegExp(r'[\s\-]'), '');
      return cleaned?.length == 12 ? null : 'Must be exactly 12 digits';
    },
  ]);
  print('   081234567890: ${chainedValidator('081234567890')}');
  print('   08123456789: ${chainedValidator('08123456789')}');
}

void testPhone(String phone) {
  final result = PhoneValidator.validate(phone);
  print('   $phone: ${result.isValid ? "✓ Valid" : "✗ ${result.message}"}');
}

void testNik(String nik) {
  final result = NikValidator.validate(nik);
  print('   $nik: ${result.isValid ? "✓ Valid" : "✗ ${result.message}"}');
}

void testNpwp(String npwp) {
  final result = NpwpValidator.validate(npwp);
  print('   $npwp: ${result.isValid ? "✓ Valid" : "✗ ${result.message}"}');
}

void testEmail(String email) {
  final result = EmailValidator.validate(email);
  print('   $email: ${result.isValid ? "✓ Valid" : "✗ ${result.message}"}');
}
