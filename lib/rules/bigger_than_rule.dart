import 'package:fluent_validator/core/rule.dart';

class BiggerThanRule extends Rule {
  BiggerThanRule(this.numberOne, String errorMessage) : super(errorMessage);

  final num numberOne;

  @override
  bool isValid(dynamic value) {
    if (value is num) {
      return value > numberOne;
    }
    throw UnimplementedError();
  }
}
