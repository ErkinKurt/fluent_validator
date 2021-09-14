import 'package:fluent_validator/core/rule.dart';
import 'package:fluent_validator/exceptions/not_supported_type_exception.dart';

typedef Predicate<T> = bool Function(T value);

class MustRule<T> extends Rule {
  MustRule(this.predicate, String errorMessage) : super(errorMessage);

  final Predicate<T> predicate;

  @override
  bool isValid(dynamic value) {
    if (value is T) return _must(value);
    throw NotSupportedTypeException();
  }

  bool _must(T value) {
    return predicate(value);
  }
}
