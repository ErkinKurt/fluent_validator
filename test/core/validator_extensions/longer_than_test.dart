import 'package:fluent_validator/core/validator.dart';
import 'package:flutter_test/flutter_test.dart';

class TestClass {
  const TestClass(this.prop1);

  final String? prop1;
}

class TestValidator extends Validator<TestClass> {
  TestValidator() {
    rulesFor('Prop1', (TestClass testClass) => testClass.prop1).longerThan(10);
  }
}

void main() {
  group('ValidatorBuilderExtensions', () {
    late TestValidator testValidator;
    group('LongerThan', () {
      testValidator = TestValidator();

      test(
          'should return invalid validation result'
          ' when value is shorter than given length', () {
        const testClass = TestClass('prop1');
        final validationResult = testValidator.validate(testClass);

        expect(false, validationResult.isValid);
      });

      test(
          'should return valid validation result'
          ' when value is greater than 10', () {
        final value = List.generate(15, (index) => index).join(',');
        final testClass = TestClass(value);
        final validationResult = testValidator.validate(testClass);

        expect(true, validationResult.isValid);
      });
    });
  });
}
