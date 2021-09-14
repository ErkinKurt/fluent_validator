import 'package:fluent_validator/core/validator.dart';
import 'package:flutter_test/flutter_test.dart';

class TestClass {
  const TestClass(this.prop1);

  final String? prop1;
}

class TestValidator extends Validator<TestClass> {
  TestValidator() {
    rulesFor('Prop1', (TestClass testClass) => testClass.prop1).notNull();
  }
}

void main() {
  group('ValidatorBuilderExtensions', () {
    late TestValidator testValidator;
    group('NotNull', () {
      testValidator = TestValidator();
      test(
          'should return invalid validation result'
          ' when value is null', () {
        const testClass = TestClass(null);
        final validationResult = testValidator.validate(testClass);

        expect(false, validationResult.isValid);
      });

      test('should return valid validation result' ' when value is not null', () {
        const testClass = TestClass('prop1');
        final validationResult = testValidator.validate(testClass);

        expect(true, validationResult.isValid);
      });
    });
  });
}
