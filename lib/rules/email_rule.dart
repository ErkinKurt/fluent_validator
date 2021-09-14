import 'package:fluent_validator/core/rule.dart';
import 'package:fluent_validator/exceptions/not_supported_type_exception.dart';

class EmailRule extends Rule {
  EmailRule(String errorMessage, {this.emailRegExp}) : super(errorMessage);

  final RegExp? emailRegExp;

  @override
  bool isValid(dynamic value) {
    if (value is String) return _validateEmail(value);
    throw NotSupportedTypeException();
  }

  bool _validateEmail(String value) {
    if (emailRegExp != null) {
      return emailRegExp!.hasMatch(value);
    }
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }
}
