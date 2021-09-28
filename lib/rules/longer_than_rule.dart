import 'package:fluent_validator/core/rule.dart';

class LongerThanRule extends Rule {
  LongerThanRule(this.lenght, String errorMessage) : super(errorMessage);

  final int lenght;

  @override
  bool isValid(dynamic value) {
    if (value is String) {
      return value.length > lenght;
    }
    throw UnimplementedError();
  }
}
