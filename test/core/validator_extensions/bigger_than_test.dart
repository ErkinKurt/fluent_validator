import 'package:fluent_validator/core/validator.dart';
import 'package:flutter_test/flutter_test.dart';

class TestClass {
  const TestClass(this.prop1, this.prop2);

  final double? prop1;
  final double? prop2;
}

class TestValidator extends Validator<TestClass> {
  TestValidator() {
    rulesFor('Prop1', (TestClass testClass) => testClass.prop1).biggerThan(10);
    rulesFor('Prop2', (TestClass testClass) => testClass.prop2).biggerThan(5.2);
  }
}

void main() {
  group('ValidatorBuilderExtensions', () {
    late TestValidator testValidator;
    group('BiggerThan', () {
      testValidator = TestValidator();

      test(
          'should return invalid validation result'
          ' when value is less than given number', () {
        const testClass = TestClass(5, 4.3);
        final validationResult = testValidator.validate(testClass);

        expect(false, validationResult.isValid);
      });

      test(
          'should return valid validation result'
          ' when value is bigger than 10', () {
        const testClass = TestClass(15, 5.3);
        final validationResult = testValidator.validate(testClass);

        expect(true, validationResult.isValid);
      });
    });
  });
}
