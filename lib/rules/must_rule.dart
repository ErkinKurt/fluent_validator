import 'package:fluent_validator/core/rule.dart';

typedef Predicate = bool Function(dynamic value);

class MustRule extends Rule {
  MustRule(this.predicate, String errorMessage) : super(errorMessage);

  final Predicate predicate;

  @override
  bool isValid(dynamic value) {
    if (predicate(value)) {
      return true;
    }

    throw UnimplementedError();
  }
}
