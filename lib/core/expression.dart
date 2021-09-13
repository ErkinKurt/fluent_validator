import 'package:fluent_validator/core/rule.dart';
import 'package:fluent_validator/core/type_defs.dart';

class Expression<T> {
  Expression({required this.expressionName, required this.expressionFunc});

  final ExpressionName expressionName;
  final ExpressionFunc<T> expressionFunc;
  final List<Rule> _rules = [];

  void addRule(Rule rule) {
    _rules.add(rule);
  }

  List<Rule> get rules => _rules;
}
