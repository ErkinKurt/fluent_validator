import 'package:fluent_validator/core/rule.dart';
import 'package:fluent_validator/exceptions/not_supported_type_exception.dart';

class NotEmptyRule extends Rule {
  NotEmptyRule(String errorMessage) : super(errorMessage);

  @override
  bool isValid(dynamic value) {
    if (value is String) {
      return value.isNotEmpty;
    }
    throw NotSupportedTypeException();
  }
}
