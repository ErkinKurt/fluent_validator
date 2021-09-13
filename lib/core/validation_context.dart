import 'package:fluent_validator/core/validator.dart';
import 'package:fluent_validator/core/type_defs.dart';

class ValidationContext {
  final Map<ExpressionName, Validator> registeredValidatiors = {};

  void registerValidator(ExpressionName expressionName, Validator validator) {
    registeredValidatiors[expressionName] = validator;
  }
}
