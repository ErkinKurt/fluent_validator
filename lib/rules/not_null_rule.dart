import 'package:fluent_validator/core/rule.dart';

class NotNullRule extends Rule {
  NotNullRule(String errorMessage) : super(errorMessage);

  @override
  bool isValid(dynamic value) {
    return value != null;
  }
}
