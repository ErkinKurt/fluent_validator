import 'package:fluent_validator/core/validator.dart';

abstract class Rule {
  bool isValid();
}

class RuleBuilder<T> {
  const RuleBuilder(this.expression);

  final Expression expression;
}
