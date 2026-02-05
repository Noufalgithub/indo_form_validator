# Quick Start Guide

Get started with `indo_form_validator` in 5 minutes!

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  indo_form_validator: ^1.0.0
```

Run:

```bash
flutter pub get
```

## Basic Usage

### 1. Import the package

```dart
import 'package:indo_form_validator/indo_form_validator.dart';
```

### 2. Use in your forms

```dart
class MyForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Phone Number
          TextFormField(
            decoration: InputDecoration(labelText: 'Phone'),
            validator: IndoValidator.phone(),
          ),
          
          // NIK
          TextFormField(
            decoration: InputDecoration(labelText: 'NIK'),
            validator: IndoValidator.nik(),
          ),
          
          // NPWP
          TextFormField(
            decoration: InputDecoration(labelText: 'NPWP'),
            validator: IndoValidator.npwp(),
          ),
          
          // Email
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: IndoValidator.email(),
          ),
          
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid!
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

## Common Use Cases

### English Error Messages

```dart
TextFormField(
  validator: IndoValidator.phone(
    config: ValidationConfig.english,
  ),
)
```

### Strict Validation

```dart
TextFormField(
  validator: IndoValidator.nik(
    config: ValidationConfig.strictMode,
    validateRegion: true,
  ),
)
```

### Standalone Validation

```dart
// Check if valid
if (PhoneValidator.isValid('081234567890')) {
  print('Valid phone');
}

// Get detailed result
final result = IndoValidator.validatePhone('081234567890');
if (result.isValid) {
  print('Valid');
} else {
  print('Error: ${result.message}');
}
```

### Chain Multiple Validators

```dart
TextFormField(
  validator: IndoValidator.chain([
    IndoValidator.phone(),
    (value) => value?.length == 12 ? null : 'Must be 12 digits',
  ]),
)
```

### Custom Validator

```dart
TextFormField(
  validator: IndoValidator.custom(
    (value) => value?.startsWith('08') ?? false,
    'Must start with 08',
  ),
)
```

## Validation Rules

| Validator | Format | Example |
|-----------|--------|---------|
| Phone | 08xx, +628xx, 628xx | 081234567890 |
| NIK | 16 digits | 3201234567890123 |
| NPWP | 15 digits | 12.345.678.9-012.345 |
| Email | RFC 5322 | user@example.com |

## Next Steps

- Read the [full documentation](README.md)
- Check out [API reference](API.md)
- See [examples](example/)
- Learn about [contributing](CONTRIBUTING.md)

## Need Help?

- [GitHub Issues](https://github.com/yourusername/indo_form_validator/issues)
- [API Documentation](API.md)
- [Examples](example/)

## Tips

✅ Use `ValidationConfig.english` for English messages  
✅ Enable `strict` mode for production  
✅ Chain validators for complex validation  
✅ Use `isValid()` for quick boolean checks  
✅ Use `ValidationResult` for detailed error info  

That's it! You're ready to validate Indonesian forms. 🎉
