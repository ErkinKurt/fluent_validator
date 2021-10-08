import 'package:fluent_validator/core/rule.dart';

class BiggerThanRule extends Rule {
  BiggerThanRule(this.number, String errorMessage) : super(errorMessage);

  final num number;

  @override
  bool isValid(dynamic value) {
    if (value is num) {
      return value > number;
    }
    throw UnimplementedError();
  }
}
