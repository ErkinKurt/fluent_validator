import 'package:fluent_validator/core/expression.dart';
import 'package:fluent_validator/core/type_defs.dart';
import 'package:fluent_validator/core/validation_context.dart';
import 'package:fluent_validator/core/validator_builder.dart';
import 'package:fluent_validator/results/validation_failure.dart';
import 'package:fluent_validator/results/validation_result.dart';
import 'package:fluent_validator/rules/bigger_than_rule.dart';
import 'package:fluent_validator/rules/email_rule.dart';
import 'package:fluent_validator/rules/longer_than_rule.dart';
import 'package:fluent_validator/rules/must_rule.dart';
import 'package:fluent_validator/rules/not_empty_rule.dart';
import 'package:fluent_validator/rules/not_null_rule.dart';
import 'package:fluent_validator/rules/url_rule.dart';

part 'validator_builder_extensions.dart';

abstract class Validator<T> {
  final List<Expression<T>> _expressions = [];
  final ValidationContext _validationContext = ValidationContext();
  late T _objectToValidate;

  ValidatorBuilder rulesFor(ExpressionName name, ExpressionFunc<T> expressionFunc) {
    final expression = Expression<T>(expressionName: name, expressionFunc: expressionFunc);
    _expressions.add(expression);
    return ValidatorBuilder<T>(expression, _validationContext);
  }

  ValidationResult validate(T object) {
    _objectToValidate = object;
    final validationFailures = _expressions.map(_validateExpression).whereType<ValidationFailure>().toList();
    return ValidationResult(validationFailures);
  }

  ValidationFailure? _validateExpression(Expression<T> expression) {
    final dynamic expressionValue = expression.expressionFunc(_objectToValidate);
    if (_isValidatorRegistered(expression)) {
      return _validateExpressionWithRegisteredValidator(expression);
    }

    final errors = expression.rules.map((rule) {
      final isValid = rule.isValid(expression.expressionFunc(_objectToValidate));
      if (!isValid) {
        return rule.errorMessage;
      }
    }).whereType<String>();

    if (errors.isNotEmpty) {
      final validationFailure = ValidationFailure(
        name: '$T.${expression.expressionName}',
        attemptedValue: expressionValue,
        message: errors.join(', '),
      );

      return validationFailure;
    }
  }

  bool _isValidatorRegistered(Expression expression) =>
      _validationContext.registeredValidatiors.containsKey(expression.expressionName);

  ValidationFailure? _validateExpressionWithRegisteredValidator(Expression<T> expression) {
    final validator = _validationContext.registeredValidatiors[expression.expressionName];
    final dynamic expressionValue = expression.expressionFunc(_objectToValidate);

    final validationResult = validator!.validate(expressionValue);
    if (!validationResult.isValid) {
      return ValidationFailure(
        name: '$T.${expression.expressionName}',
        message: validationResult.errors.join(', '),
      );
    }
  }
}
