import 'package:fluent_validator/core/rule.dart';

class UrlRule extends Rule {
  UrlRule(String errorMessage) : super(errorMessage);
  @override
  bool isValid(dynamic value) {
    if (value is String) {
      return Uri.parse(value).isAbsolute;
    }
    throw UnimplementedError();
  }
}
