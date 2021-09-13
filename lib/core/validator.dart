import 'package:fluent_validator/results/validation_failure.dart';
import 'package:fluent_validator/results/validation_result.dart';

typedef ExpressionName = String;
typedef ExpressionFunc<T> = dynamic Function(T value);

abstract class Rule {
  const Rule(this.errorMessage);

  final String errorMessage;

  bool isValid(dynamic value);
}

class RuleBuilder<T> {
  const RuleBuilder(this.expression);

  final Expression expression;
}

class Expression<T> {
  Expression({required this.expressionName, required this.expressionFunc});

  final ExpressionName expressionName;
  final ExpressionFunc<T> expressionFunc;
  final List<Rule> _rules = [];

  void addRule(Rule rule) {
    _rules.add(rule);
  }
}

class ValidationContext {
  final Map<ExpressionName, Validator> registeredValidatiors = {};

  void registerValidator(ExpressionName expressionName, Validator validator) {
    registeredValidatiors[expressionName] = validator;
  }
}

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
      final a = _validateExpressionWithRegisteredValidator(expression);
      print(a);
    }

    final errors = expression._rules.map((rule) {
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

  ValidationResult _validateExpressionWithRegisteredValidator(Expression<T> expression) {
    final validator = _validationContext.registeredValidatiors[expression.expressionName];
    final dynamic expressionValue = expression.expressionFunc(objectToValidate);

    final validationResult = validator!.validate(expressionValue);
    return validationResult;
  }
}

class ValidatorBuilder<T> {
  const ValidatorBuilder(this.expression, this.validationContext);

  final Expression<T> expression;
  final ValidationContext validationContext;

  void setValidator(Validator validator) {
    validationContext.registerValidator(expression.expressionName, validator);
  }

  void setRule(Rule rule) {
    expression.addRule(rule);
  }
}
