import 'package:fluent_validator/core/expression.dart';
import 'package:fluent_validator/core/rule.dart';
import 'package:fluent_validator/core/validation_context.dart';
import 'package:fluent_validator/core/validator.dart';

class ValidatorBuilder<T> {
  const ValidatorBuilder(this._expression, this._validationContext);

  final Expression<T> _expression;
  final ValidationContext _validationContext;

  void setValidator(Validator validator) {
    _validationContext.registerValidator(_expression.expressionName, validator);
  }

  void setRule(Rule rule) {
    _expression.addRule(rule);
  }
}
