import 'package:equatable/equatable.dart';
import 'package:fluent_validator/results/validation_failure.dart';

class ValidationResult extends Equatable {
  const ValidationResult(
    this.errors,
  );

  final List<ValidationFailure> errors;
  bool get isValid => errors.isEmpty;

  @override
  List<Object?> get props => [errors];
}
