import 'package:fluent_validator/core/expression.dart';
import 'package:fluent_validator/core/rule.dart';
import 'package:fluent_validator/core/validation_context.dart';
import 'package:fluent_validator/core/validator.dart';

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
