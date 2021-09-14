import 'package:fluent_validator/core/validator.dart';
import 'package:flutter_test/flutter_test.dart';

class TestClass {
  const TestClass(this.email);

  final String email;
}

class TestValidator extends Validator<TestClass> {
  TestValidator() {
    rulesFor('Email', (TestClass testClass) => testClass.email).emailAddress();
  }
}

void main() {
  group('ValidatorBuilderExtensions', () {
    late TestValidator testValidator;
    group('Email', () {
      testValidator = TestValidator();
      test(
        'should return invalid validation result'
        ' when value is not a valid email',
        () {
          const testClass = TestClass('email.a@rde@gmai.com');
          final validationResult = testValidator.validate(testClass);

          expect(false, validationResult.isValid);
        },
      );

      test(
          'should return valid validation result'
          ' when value is valid email', () {
        const testClass = TestClass('email.com@ad.com');
        final validationResult = testValidator.validate(testClass);

        expect(true, validationResult.isValid);
      });
    });
  });
}
