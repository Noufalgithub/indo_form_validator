/// Represents the result of a validation operation.
///
/// Contains both the validation status and an optional error message.
class ValidationResult {
  /// Whether the validation passed.
  final bool isValid;

  /// Error message if validation failed, null otherwise.
  final String? message;

  /// Creates a validation result.
  const ValidationResult({required this.isValid, this.message});

  /// Creates a successful validation result.
  const ValidationResult.valid() : this(isValid: true, message: null);

  /// Creates a failed validation result with an error message.
  const ValidationResult.invalid(String message)
    : this(isValid: false, message: message);

  @override
  String toString() => 'ValidationResult(isValid: $isValid, message: $message)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValidationResult &&
          runtimeType == other.runtimeType &&
          isValid == other.isValid &&
          message == other.message;

  @override
  int get hashCode => isValid.hashCode ^ message.hashCode;
}
