import 'package:fluent_validator/core/validator.dart';
import 'package:flutter_test/flutter_test.dart';

class TestClass {
  const TestClass(this.prop1);

  final String? prop1;
}

class TestValidator extends Validator<TestClass> {
  TestValidator() {
    rulesFor('Prop1', (TestClass testClass) => testClass.prop1).setValidator(CustomValidator());
  }
}

class CustomValidator extends Validator<String?> {
  CustomValidator() {
    rulesFor('value', (value) => value).notNull();
  }
}

void main() {
  group('ValidatorBuilderExtensions', () {
    late TestValidator testValidator;
    group('CustomValidator', () {
      testValidator = TestValidator();
      test('should execute assigned rule of custom validator' ' when value is null', () {
        const testClass = TestClass(null);
        final validationResult = testValidator.validate(testClass);

        expect(false, validationResult.isValid);
      });

      test('should execute assigned rule of custom validator' ' when value is not null', () {
        const testClass = TestClass('prop1');
        final validationResult = testValidator.validate(testClass);

        expect(true, validationResult.isValid);
      });
    });
  });
}
