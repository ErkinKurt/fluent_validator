import 'package:fluent_validator/core/expression.dart';
import 'package:fluent_validator/core/type_defs.dart';
import 'package:fluent_validator/core/validation_context.dart';
import 'package:fluent_validator/core/validator_builder.dart';
import 'package:fluent_validator/results/validation_failure.dart';
import 'package:fluent_validator/results/validation_result.dart';

abstract class Validator<T> {
  final List<Expression<T>> expressions = [];
  final ValidationContext _validationContext = ValidationContext();
  late T objectToValidate;

  ValidatorBuilder rulesFor(ExpressionName name, ExpressionFunc<T> expressionFunc) {
    final expression = Expression<T>(expressionName: name, expressionFunc: expressionFunc);
    expressions.add(expression);
    return ValidatorBuilder<T>(expression, _validationContext);
  }

  ValidationResult validate(T object) {
    objectToValidate = object;
    final validationFailures = expressions.map(_validateExpression).toList();
    return ValidationResult(validationFailures);
  }

  ValidationFailure _validateExpression(Expression<T> expression) {
    final dynamic expressionValue = expression.expressionFunc(objectToValidate);

    if (_isValidatorRegistered(expression)) {
      return _validateExpressionWithRegisteredValidator(expression);
    }

    final errors = expression.rules.map((rule) {
      final isValid = rule.isValid(expression.expressionFunc(objectToValidate));
      if (!isValid) {
        return rule.errorMessage;
      }
    });

    final validationFailure = ValidationFailure(
      name: expression.expressionName,
      attemptedValue: expressionValue,
      message: errors.join(', '),
    );

    return validationFailure;
  }

  bool _isValidatorRegistered(Expression expression) =>
      _validationContext.registeredValidatiors.containsKey(expression.expressionName);

  ValidationFailure _validateExpressionWithRegisteredValidator(Expression<T> expression) {
    final validator = _validationContext.registeredValidatiors[expression.expressionName];
    final dynamic expressionValue = expression.expressionFunc(objectToValidate);

    final validationResult = validator!.validate(expressionValue);
    return ValidationFailure(
      name: expression.expressionName,
      message: validationResult.errors.join(', '),
      attemptedValue: expressionValue,
    );
  }
}
