import 'package:flutter_test/flutter_test.dart';
import 'package:indo_form_validator/indo_form_validator.dart';

void main() {
  group('PhoneValidator', () {
    test('validates correct phone numbers', () {
      expect(PhoneValidator.isValid('081234567890'), true);
      expect(PhoneValidator.isValid('08123456789'), true);
      expect(PhoneValidator.isValid('+628123456789'), true);
      expect(PhoneValidator.isValid('628123456789'), true);
      expect(PhoneValidator.isValid('0812 3456 7890'), true);
      expect(PhoneValidator.isValid('0812-3456-7890'), true);
    });

    test('rejects invalid phone numbers', () {
      expect(PhoneValidator.isValid('0712345678'), false);
      expect(PhoneValidator.isValid('08123'), false);
      expect(PhoneValidator.isValid('abc123456789'), false);
      expect(PhoneValidator.isValid(''), false);
      expect(PhoneValidator.isValid(null), false);
    });

    test('returns correct error messages', () {
      final resultId = PhoneValidator.validate('invalid');
      expect(resultId.isValid, false);
      expect(resultId.message, 'Nomor telepon tidak valid');

      final resultEn = PhoneValidator.validate(
        'invalid',
        config: ValidationConfig.english,
      );
      expect(resultEn.isValid, false);
      expect(resultEn.message, 'Invalid phone number');
    });

    test('works with FormField validator', () {
      final validator = IndoValidator.phone();
      expect(validator('081234567890'), null);
      expect(validator('invalid'), isNotNull);
    });
  });

  group('NikValidator', () {
    test('validates correct NIK', () {
      expect(NikValidator.isValid('3201234567890123'), true);
      expect(NikValidator.isValid('3201 2345 6789 0123'), true);
      expect(NikValidator.isValid('3201-2345-6789-0123'), true);
    });

    test('rejects invalid NIK', () {
      expect(NikValidator.isValid('123456789012345'), false); // 15 digits
      expect(NikValidator.isValid('12345678901234567'), false); // 17 digits
      expect(
        NikValidator.isValid('abcd123456789012'),
        false,
      ); // contains letters
      expect(NikValidator.isValid(''), false);
      expect(NikValidator.isValid(null), false);
    });

    test('validates region code in strict mode', () {
      // Valid province code (32 = Jawa Barat)
      expect(
        NikValidator.validate(
          '3201234567890123',
          config: ValidationConfig.strictMode,
        ).isValid,
        true,
      );

      // Invalid province code (05)
      expect(
        NikValidator.validate(
          '0501234567890123',
          config: ValidationConfig.strictMode,
        ).isValid,
        false,
      );

      // Invalid province code (99)
      expect(
        NikValidator.validate(
          '9901234567890123',
          config: ValidationConfig.strictMode,
        ).isValid,
        false,
      );
    });

    test('returns correct error messages', () {
      final resultId = NikValidator.validate('123');
      expect(resultId.isValid, false);
      expect(resultId.message, 'NIK tidak valid');

      final resultEn = NikValidator.validate(
        '123',
        config: ValidationConfig.english,
      );
      expect(resultEn.isValid, false);
      expect(resultEn.message, 'Invalid NIK');
    });
  });

  group('NpwpValidator', () {
    test('validates correct NPWP', () {
      expect(NpwpValidator.isValid('123456789012345'), true);
      expect(NpwpValidator.isValid('12.345.678.9-012.345'), true);
      expect(NpwpValidator.isValid('12 345 678 9 012 345'), true);
    });

    test('rejects invalid NPWP', () {
      expect(NpwpValidator.isValid('12345678901234'), false); // 14 digits
      expect(NpwpValidator.isValid('1234567890123456'), false); // 16 digits
      expect(
        NpwpValidator.isValid('abc456789012345'),
        false,
      ); // contains letters
      expect(NpwpValidator.isValid(''), false);
      expect(NpwpValidator.isValid(null), false);
    });

    test('formats NPWP correctly', () {
      expect(NpwpValidator.format('123456789012345'), '12.345.678.9-012.345');
      expect(
        NpwpValidator.format('12.345.678.9-012.345'),
        '12.345.678.9-012.345',
      );
      expect(NpwpValidator.format('invalid'), null);
    });

    test('validates formatted NPWP in strict mode', () {
      expect(
        NpwpValidator.validate(
          '12.345.678.9-012.345',
          config: ValidationConfig.strictMode,
        ).isValid,
        true,
      );

      expect(
        NpwpValidator.validate(
          '12.345.678.9.012.345', // wrong format (no dash)
          config: ValidationConfig.strictMode,
        ).isValid,
        false,
      );
    });

    test('returns correct error messages', () {
      final resultId = NpwpValidator.validate('123');
      expect(resultId.isValid, false);
      expect(resultId.message, 'NPWP tidak valid');

      final resultEn = NpwpValidator.validate(
        '123',
        config: ValidationConfig.english,
      );
      expect(resultEn.isValid, false);
      expect(resultEn.message, 'Invalid NPWP');
    });
  });

  group('EmailValidator', () {
    test('validates correct emails', () {
      expect(EmailValidator.isValid('test@example.com'), true);
      expect(EmailValidator.isValid('user.name@example.co.id'), true);
      expect(EmailValidator.isValid('user+tag@example.com'), true);
      expect(EmailValidator.isValid('user_name@example.com'), true);
    });

    test('rejects invalid emails', () {
      expect(EmailValidator.isValid('invalid'), false);
      expect(EmailValidator.isValid('invalid@'), false);
      expect(EmailValidator.isValid('@example.com'), false);
      expect(EmailValidator.isValid('user@.com'), false);
      expect(EmailValidator.isValid(''), false);
      expect(EmailValidator.isValid(null), false);
    });

    test('validates strict email rules', () {
      expect(
        EmailValidator.validate(
          'user..name@example.com',
          config: ValidationConfig.strictMode,
        ).isValid,
        false,
      );

      expect(
        EmailValidator.validate(
          'user@example.c',
          config: ValidationConfig.strictMode,
        ).isValid,
        false,
      );
    });

    test('returns correct error messages', () {
      final resultId = EmailValidator.validate('invalid');
      expect(resultId.isValid, false);
      expect(resultId.message, 'Email tidak valid');

      final resultEn = EmailValidator.validate(
        'invalid',
        config: ValidationConfig.english,
      );
      expect(resultEn.isValid, false);
      expect(resultEn.message, 'Invalid email');
    });
  });

  group('IndoValidator', () {
    test('provides convenient validator methods', () {
      expect(IndoValidator.phone()('081234567890'), null);
      expect(IndoValidator.nik()('3201234567890123'), null);
      expect(IndoValidator.npwp()('123456789012345'), null);
      expect(IndoValidator.email()('test@example.com'), null);
    });

    test('chains validators correctly', () {
      final validator = IndoValidator.chain([
        IndoValidator.phone(),
        (value) => value?.length == 13 ? null : 'Must be 13 characters',
      ]);

      expect(validator('081234567890'), 'Must be 13 characters');
      expect(validator('invalid'), 'Nomor telepon tidak valid');
    });

    test('creates custom validators', () {
      final validator = IndoValidator.custom(
        (value) => value == 'test',
        'Value must be "test"',
      );

      expect(validator('test'), null);
      expect(validator('other'), 'Value must be "test"');
    });

    test('returns ValidationResult objects', () {
      final result = IndoValidator.validatePhone('081234567890');
      expect(result.isValid, true);
      expect(result.message, null);

      final invalidResult = IndoValidator.validatePhone('invalid');
      expect(invalidResult.isValid, false);
      expect(invalidResult.message, isNotNull);
    });
  });

  group('ValidationResult', () {
    test('creates valid result', () {
      const result = ValidationResult.valid();
      expect(result.isValid, true);
      expect(result.message, null);
    });

    test('creates invalid result', () {
      const result = ValidationResult.invalid('Error message');
      expect(result.isValid, false);
      expect(result.message, 'Error message');
    });

    test('equality works correctly', () {
      const result1 = ValidationResult.valid();
      const result2 = ValidationResult.valid();
      const result3 = ValidationResult.invalid('Error');

      expect(result1, result2);
      expect(result1 == result3, false);
    });
  });
}
