# Contributing to Indo Form Validator

Thank you for your interest in contributing to Indo Form Validator! This document provides guidelines for contributing to the project.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/indo_form_validator.git`
3. Create a new branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Run tests: `flutter test`
6. Commit your changes: `git commit -am 'Add some feature'`
7. Push to the branch: `git push origin feature/your-feature-name`
8. Submit a pull request

## Development Setup

### Prerequisites

- Flutter SDK (>=1.17.0)
- Dart SDK (^3.10.7)

### Installation

```bash
flutter pub get
```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/indo_form_validator_test.dart
```

### Code Analysis

```bash
flutter analyze
```

## Code Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dartfmt` to format your code
- Add documentation comments (`///`) for public APIs
- Keep functions small and focused
- Write descriptive variable and function names

## Adding New Validators

When adding a new validator:

1. Create a new file in `lib/src/validators/`
2. Implement the validator class with these methods:
   - `validate()` - Returns `ValidationResult`
   - `validator()` - Returns `String? Function(String?)`
   - `isValid()` - Returns `bool`
3. Add error messages to `ErrorMessages` in `validation_config.dart`
4. Export the validator in `lib/indo_form_validator.dart`
5. Add convenience methods to `IndoValidator` class
6. Write comprehensive tests
7. Update README.md and API.md

### Example Structure

```dart
class NewValidator {
  static ValidationResult validate(
    String? value, {
    ValidationConfig config = ValidationConfig.defaultConfig,
  }) {
    // Implementation
  }

  static String? Function(String?) validator({
    ValidationConfig config = ValidationConfig.defaultConfig,
  }) {
    return (value) {
      final result = validate(value, config: config);
      return result.isValid ? null : result.message;
    };
  }

  static bool isValid(String? value) {
    return validate(value).isValid;
  }
}
```

## Testing Guidelines

- Write tests for all new features
- Ensure 100% code coverage for validators
- Test both valid and invalid inputs
- Test edge cases
- Test error messages in both languages
- Test strict mode behavior

### Test Structure

```dart
group('NewValidator', () {
  test('validates correct input', () {
    expect(NewValidator.isValid('valid'), true);
  });

  test('rejects invalid input', () {
    expect(NewValidator.isValid('invalid'), false);
  });

  test('returns correct error messages', () {
    final resultId = NewValidator.validate('invalid');
    expect(resultId.message, 'Error in Indonesian');

    final resultEn = NewValidator.validate(
      'invalid',
      config: ValidationConfig.english,
    );
    expect(resultEn.message, 'Error in English');
  });
});
```

## Documentation

- Add documentation comments for all public APIs
- Update README.md with new features
- Update API.md with detailed API documentation
- Add examples to `example/` directory
- Update CHANGELOG.md

## Pull Request Process

1. Ensure all tests pass
2. Update documentation
3. Add entry to CHANGELOG.md
4. Ensure code follows style guidelines
5. Write a clear PR description explaining:
   - What changes were made
   - Why the changes were necessary
   - How to test the changes

## Reporting Issues

When reporting issues, please include:

- Flutter/Dart version
- Package version
- Steps to reproduce
- Expected behavior
- Actual behavior
- Code samples (if applicable)

## Feature Requests

Feature requests are welcome! Please:

- Check if the feature already exists
- Explain the use case
- Provide examples of how it would be used
- Consider submitting a PR

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Help others learn and grow

## Questions?

Feel free to open an issue for questions or discussions.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
