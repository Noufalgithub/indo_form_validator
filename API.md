# API Reference

Complete API documentation for `indo_form_validator` package.

## Table of Contents

- [IndoValidator](#indovalidator)
- [Individual Validators](#individual-validators)
  - [PhoneValidator](#phonevalidator)
  - [NikValidator](#nikvalidator)
  - [NpwpValidator](#npwpvalidator)
  - [EmailValidator](#emailvalidator)
- [ValidationResult](#validationresult)
- [ValidationConfig](#validationconfig)
- [ErrorMessages](#errormessages)

---

## IndoValidator

Main validator class providing convenient access to all validators.

### Static Methods

#### `phone({ValidationConfig config})`

Returns a validator function for Indonesian phone numbers.

**Parameters:**
- `config` (optional): Validation configuration. Default: `ValidationConfig.defaultConfig`

**Returns:** `String? Function(String?)`

**Example:**
```dart
TextFormField(
  validator: IndoValidator.phone(),
)
```

#### `nik({ValidationConfig config, bool validateRegion})`

Returns a validator function for Indonesian NIK.

**Parameters:**
- `config` (optional): Validation configuration. Default: `ValidationConfig.defaultConfig`
- `validateRegion` (optional): Enable region code validation. Default: `false`

**Returns:** `String? Function(String?)`

**Example:**
```dart
TextFormField(
  validator: IndoValidator.nik(validateRegion: true),
)
```

#### `npwp({ValidationConfig config})`

Returns a validator function for Indonesian NPWP.

**Parameters:**
- `config` (optional): Validation configuration. Default: `ValidationConfig.defaultConfig`

**Returns:** `String? Function(String?)`

**Example:**
```dart
TextFormField(
  validator: IndoValidator.npwp(),
)
```

#### `email({ValidationConfig config})`

Returns a validator function for email addresses.

**Parameters:**
- `config` (optional): Validation configuration. Default: `ValidationConfig.defaultConfig`

**Returns:** `String? Function(String?)`

**Example:**
```dart
TextFormField(
  validator: IndoValidator.email(),
)
```

#### `validatePhone(String? value, {ValidationConfig config})`

Validates phone number and returns ValidationResult.

**Parameters:**
- `value`: Phone number to validate
- `config` (optional): Validation configuration

**Returns:** `ValidationResult`

**Example:**
```dart
final result = IndoValidator.validatePhone('081234567890');
if (result.isValid) {
  print('Valid');
}
```

#### `validateNik(String? value, {ValidationConfig config, bool validateRegion})`

Validates NIK and returns ValidationResult.

**Parameters:**
- `value`: NIK to validate
- `config` (optional): Validation configuration
- `validateRegion` (optional): Enable region code validation

**Returns:** `ValidationResult`

#### `validateNpwp(String? value, {ValidationConfig config})`

Validates NPWP and returns ValidationResult.

**Parameters:**
- `value`: NPWP to validate
- `config` (optional): Validation configuration

**Returns:** `ValidationResult`

#### `validateEmail(String? value, {ValidationConfig config})`

Validates email and returns ValidationResult.

**Parameters:**
- `value`: Email to validate
- `config` (optional): Validation configuration

**Returns:** `ValidationResult`

#### `chain(List<String? Function(String?)> validators)`

Chains multiple validators together.

**Parameters:**
- `validators`: List of validator functions

**Returns:** `String? Function(String?)`

**Example:**
```dart
TextFormField(
  validator: IndoValidator.chain([
    IndoValidator.phone(),
    (value) => value?.length == 12 ? null : 'Must be 12 digits',
  ]),
)
```

#### `custom(bool Function(String?) validationFunction, String errorMessage)`

Creates a custom validator with a custom error message.

**Parameters:**
- `validationFunction`: Function that returns true if valid
- `errorMessage`: Error message to display if invalid

**Returns:** `String? Function(String?)`

**Example:**
```dart
TextFormField(
  validator: IndoValidator.custom(
    (value) => value?.startsWith('08') ?? false,
    'Must start with 08',
  ),
)
```

---

## Individual Validators

### PhoneValidator

Validator for Indonesian phone numbers.

#### Methods

##### `validate(String? value, {ValidationConfig config})`

Validates phone number and returns ValidationResult.

**Supported Formats:**
- `08xxxxxxxxxx` (10-13 digits)
- `+628xxxxxxxxxx`
- `628xxxxxxxxxx`

**Example:**
```dart
final result = PhoneValidator.validate('081234567890');
```

##### `validator({ValidationConfig config})`

Returns validator function for FormField.

**Example:**
```dart
TextFormField(
  validator: PhoneValidator.validator(),
)
```

##### `isValid(String? value)`

Quick boolean check for validity.

**Example:**
```dart
if (PhoneValidator.isValid('081234567890')) {
  print('Valid');
}
```

---

### NikValidator

Validator for Indonesian NIK (Nomor Induk Kependudukan).

#### Methods

##### `validate(String? value, {ValidationConfig config, bool validateRegion})`

Validates NIK and returns ValidationResult.

**Requirements:**
- Exactly 16 digits
- Numeric only
- Optional region code validation (province: 11-94)

**Example:**
```dart
final result = NikValidator.validate('3201234567890123');
```

##### `validator({ValidationConfig config, bool validateRegion})`

Returns validator function for FormField.

##### `isValid(String? value, {bool validateRegion})`

Quick boolean check for validity.

---

### NpwpValidator

Validator for Indonesian NPWP (Nomor Pokok Wajib Pajak).

#### Methods

##### `validate(String? value, {ValidationConfig config})`

Validates NPWP and returns ValidationResult.

**Requirements:**
- Exactly 15 digits
- Numeric only
- Supports formatted (`XX.XXX.XXX.X-XXX.XXX`) and non-formatted input

**Example:**
```dart
final result = NpwpValidator.validate('123456789012345');
```

##### `validator({ValidationConfig config})`

Returns validator function for FormField.

##### `isValid(String? value)`

Quick boolean check for validity.

##### `format(String? value)`

Formats a valid NPWP string to standard format.

**Returns:** Formatted NPWP string or null if invalid

**Example:**
```dart
final formatted = NpwpValidator.format('123456789012345');
// Returns: '12.345.678.9-012.345'
```

---

### EmailValidator

Validator for email addresses.

#### Methods

##### `validate(String? value, {ValidationConfig config})`

Validates email and returns ValidationResult.

**Features:**
- RFC 5322 compliant regex
- Strict mode checks for consecutive dots and valid TLD length

**Example:**
```dart
final result = EmailValidator.validate('user@example.com');
```

##### `validator({ValidationConfig config})`

Returns validator function for FormField.

##### `isValid(String? value)`

Quick boolean check for validity.

---

## ValidationResult

Represents the result of a validation operation.

### Properties

- `isValid` (bool): Whether the validation passed
- `message` (String?): Error message if validation failed, null otherwise

### Constructors

#### `ValidationResult({required bool isValid, String? message})`

Creates a validation result.

#### `ValidationResult.valid()`

Creates a successful validation result.

#### `ValidationResult.invalid(String message)`

Creates a failed validation result with an error message.

### Example

```dart
final result = ValidationResult.invalid('Invalid input');
if (!result.isValid) {
  print(result.message); // 'Invalid input'
}
```

---

## ValidationConfig

Configuration for validation behavior and error messages.

### Properties

- `language` (String): Language for error messages ('id' or 'en'). Default: 'id'
- `strict` (bool): Whether to use strict validation rules. Default: false

### Constructors

#### `ValidationConfig({String language = 'id', bool strict = false})`

Creates a validation configuration.

### Predefined Configurations

#### `ValidationConfig.defaultConfig`

Default configuration with Indonesian messages.

#### `ValidationConfig.english`

Configuration with English messages.

#### `ValidationConfig.strictMode`

Configuration with strict validation.

### Example

```dart
// Custom configuration
const config = ValidationConfig(
  language: 'en',
  strict: true,
);

TextFormField(
  validator: IndoValidator.phone(config: config),
)
```

---

## ErrorMessages

Static error messages for validators.

### Properties

- `phone`: Phone number error messages
- `nik`: NIK error messages
- `npwp`: NPWP error messages
- `email`: Email error messages
- `required`: Required field error messages

### Methods

#### `get(Map<String, String> messages, String language)`

Gets error message for the specified type and language.

**Example:**
```dart
final message = ErrorMessages.get(ErrorMessages.phone, 'en');
// Returns: 'Invalid phone number'
```

---

## Type Definitions

### Validator Function

```dart
String? Function(String?)
```

A function that takes a nullable string and returns a nullable string (error message).
Compatible with Flutter's `FormField.validator`.

---

## Best Practices

1. **Use predefined configs** for common scenarios:
   ```dart
   IndoValidator.phone(config: ValidationConfig.english)
   ```

2. **Chain validators** for complex validation:
   ```dart
   IndoValidator.chain([
     IndoValidator.phone(),
     customValidator,
   ])
   ```

3. **Use ValidationResult** for detailed validation info:
   ```dart
   final result = IndoValidator.validatePhone(value);
   if (!result.isValid) {
     showError(result.message);
   }
   ```

4. **Use isValid()** for quick checks:
   ```dart
   if (PhoneValidator.isValid(value)) {
     // proceed
   }
   ```

5. **Enable strict mode** for production:
   ```dart
   IndoValidator.nik(
     config: ValidationConfig.strictMode,
     validateRegion: true,
   )
   ```
