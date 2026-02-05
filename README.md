# indo_form_validator

A lightweight form validation library for Indonesian applications. Provides validators for phone numbers, NIK, NPWP, and email with bilingual error messages.

## Features

- Phone number validation (Indonesian formats: 08xx, +62, 62)
- NIK validation (16 digits with optional region code checking)
- NPWP validation (15 digits with formatting support)
- Email validation (RFC 5322 compliant)
- Bilingual error messages (Indonesian and English)
- Validator chaining and custom validators
- Strict validation mode
- Null-safe and zero dependencies
- Direct Flutter Form integration

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  indo_form_validator: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Form Validation

```dart
import 'package:indo_form_validator/indo_form_validator.dart';

TextFormField(
  decoration: const InputDecoration(labelText: 'Phone Number'),
  validator: IndoValidator.phone(),
)

TextFormField(
  decoration: const InputDecoration(labelText: 'NIK'),
  validator: IndoValidator.nik(),
)

TextFormField(
  decoration: const InputDecoration(labelText: 'NPWP'),
  validator: IndoValidator.npwp(),
)

TextFormField(
  decoration: const InputDecoration(labelText: 'Email'),
  validator: IndoValidator.email(),
)
```

### English Error Messages

```dart
TextFormField(
  validator: IndoValidator.phone(
    config: ValidationConfig.english,
  ),
)
```

### Strict Validation Mode

```dart
// NIK with region code validation
TextFormField(
  validator: IndoValidator.nik(
    config: ValidationConfig.strictMode,
    validateRegion: true,
  ),
)

// NPWP with format validation
TextFormField(
  validator: IndoValidator.npwp(
    config: ValidationConfig.strictMode,
  ),
)
```

### Validator Chaining

```dart
TextFormField(
  validator: IndoValidator.chain([
    IndoValidator.phone(),
    (value) {
      final cleaned = value?.replaceAll(RegExp(r'[\s\-]'), '');
      return cleaned?.length == 12 ? null : 'Must be 12 digits';
    },
  ]),
)
```

### Custom Validators

```dart
TextFormField(
  validator: IndoValidator.custom(
    (value) => value?.startsWith('08') ?? false,
    'Phone must start with 08',
  ),
)
```

### Standalone Validation

```dart
// Using ValidationResult
final result = IndoValidator.validatePhone('081234567890');
if (result.isValid) {
  print('Phone is valid');
} else {
  print('Error: ${result.message}');
}

// Using boolean check
if (PhoneValidator.isValid('081234567890')) {
  print('Valid phone number');
}

// Direct validation
final nikResult = NikValidator.validate('3201234567890123');
print(nikResult.isValid); // true or false
print(nikResult.message); // error message or null
```

### NPWP Formatting

```dart
final formatted = NpwpValidator.format('123456789012345');
print(formatted); // 12.345.678.9-012.345
```

## Validation Rules

### Phone Number
- Supports formats: `08xxxxxxxxxx`, `+628xxxxxxxxxx`, `628xxxxxxxxxx`
- Length: 10-13 digits after prefix
- Automatically removes spaces, dashes, and parentheses

### NIK (Nomor Induk Kependudukan)
- Exactly 16 digits
- Numeric only
- Optional region code validation (province: 11-94)
- Supports formatted input with spaces/dashes

### NPWP (Nomor Pokok Wajib Pajak)
- Exactly 15 digits
- Numeric only
- Supports formatted (`XX.XXX.XXX.X-XXX.XXX`) and non-formatted input
- Strict mode validates format structure

### Email
- RFC 5322 compliant regex
- Strict mode checks for consecutive dots and valid TLD length

## API Reference

### IndoValidator

Main validator class providing convenient access to all validators.

```dart
// Form validators (returns String? for FormField)
IndoValidator.phone({ValidationConfig config})
IndoValidator.nik({ValidationConfig config, bool validateRegion})
IndoValidator.npwp({ValidationConfig config})
IndoValidator.email({ValidationConfig config})

// Validation methods (returns ValidationResult)
IndoValidator.validatePhone(String? value, {ValidationConfig config})
IndoValidator.validateNik(String? value, {ValidationConfig config, bool validateRegion})
IndoValidator.validateNpwp(String? value, {ValidationConfig config})
IndoValidator.validateEmail(String? value, {ValidationConfig config})

// Utility methods
IndoValidator.chain(List<String? Function(String?)> validators)
IndoValidator.custom(bool Function(String?) validationFunction, String errorMessage)
```

### Individual Validators

Each validator has three methods:

```dart
// Returns ValidationResult with isValid and message
PhoneValidator.validate(String? value, {ValidationConfig config})

// Returns String? for FormField.validator
PhoneValidator.validator({ValidationConfig config})

// Returns bool for quick checks
PhoneValidator.isValid(String? value)
```

### ValidationConfig

```dart
const ValidationConfig({
  String language = 'id',  // 'id' or 'en'
  bool strict = false,
})

// Predefined configs
ValidationConfig.defaultConfig  // Indonesian, non-strict
ValidationConfig.english        // English, non-strict
ValidationConfig.strictMode     // Indonesian, strict
```

### ValidationResult

```dart
class ValidationResult {
  final bool isValid;
  final String? message;
  
  const ValidationResult.valid();
  const ValidationResult.invalid(String message);
}
```

## Complete Example

```dart
class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Phone'),
            validator: IndoValidator.phone(),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'NIK'),
            validator: IndoValidator.nik(),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'NPWP'),
            validator: IndoValidator.npwp(),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            validator: IndoValidator.email(),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

## Testing

Run tests:

```bash
flutter test
```

The package includes comprehensive unit tests covering valid and invalid inputs, edge cases, error messages in both languages, and strict mode validation.

## Contributing

Contributions are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.
