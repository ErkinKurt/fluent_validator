part of 'validator.dart';

extension CustomBuilders on ValidatorBuilder {
  ValidatorBuilder notNull() {
    setRule(NotNullRule('Value should not be null'));
    return this;
  }

  ValidatorBuilder notEmpty() {
    setRule(NotEmptyRule('Value should not be empty'));
    return this;
  }

  ValidatorBuilder must<T>(Predicate<T> predicate) {
    setRule(MustRule<T>(predicate, 'The specified condition was not met'));
    return this;
  }

  ValidatorBuilder emailAddress({RegExp? pattern}) {
    setRule(EmailRule(
      'Email is not a valid email address.',
      emailRegExp: pattern,
    ));
    return this;
  }

  ValidatorBuilder longerThan(int length) {
    setRule(LongerThanRule(length, 'Value is longer than $length'));
    return this;
  }
}
