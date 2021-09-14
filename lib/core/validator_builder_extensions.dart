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
}
