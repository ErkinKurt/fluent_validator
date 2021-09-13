import 'package:equatable/equatable.dart';
import 'package:fluent_validator/results/validation_result.dart';

class ValidationFailure extends Equatable {
  const ValidationFailure({
    required this.name,
    this.attemptedValue = Object,
    required this.message,
  });

  factory ValidationFailure.flat(String failureName, ValidationResult validationResult) {
    return ValidationFailure(
      name: failureName,
      message: validationResult.errors.join(', '),
    );
  }

  final String name;
  final Object attemptedValue;
  final String message;

  @override
  List<Object?> get props => [
        name,
        attemptedValue,
        message,
      ];
}
