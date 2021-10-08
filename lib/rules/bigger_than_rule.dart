import 'package:fluent_validator/core/rule.dart';

class BiggerThanRule extends Rule {
  BiggerThanRule(this.lenght, String errorMessage) : super(errorMessage);

  final double lenght;

  @override
  bool isValid(dynamic value) {
    if (value is double) {
      return value > lenght;
    }
    throw UnimplementedError();
  }
}
