# Indo Form Validator Examples

This directory contains examples demonstrating how to use the `indo_form_validator` package.

## Running the Example

To run the example Flutter app:

```bash
cd example
flutter run
```

## Quick Examples

### Basic Form Validation

```dart
import 'package:indo_form_validator/indo_form_validator.dart';

TextFormField(
  validator: IndoValidator.phone(),
)
```

### With Custom Configuration

```dart
TextFormField(
  validator: IndoValidator.phone(
    config: ValidationConfig.english,
  ),
)
```

### Standalone Validation

```dart
final result = IndoValidator.validatePhone('081234567890');
if (result.isValid) {
  print('Valid phone number');
} else {
  print('Error: ${result.message}');
}
```

### Validator Chaining

```dart
TextFormField(
  validator: IndoValidator.chain([
    IndoValidator.phone(),
    (value) => value?.length == 12 ? null : 'Must be 12 digits',
  ]),
)
```

See `example.dart` for a complete working example with all validators.
