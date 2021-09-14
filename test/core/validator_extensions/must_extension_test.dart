import 'package:fluent_validator/core/validator.dart';
import 'package:flutter_test/flutter_test.dart';

class TestClass {
  const TestClass(this.prop1);

  final int? prop1;
}

class TestValidator extends Validator<TestClass> {
  TestValidator() {
    rulesFor('Prop1', (TestClass testClass) => testClass.prop1).must<int?>((value) => value! < 5);
  }
}

void main() {
  group('ValidatorBuilderExtensions', () {
    late TestValidator testValidator;
    group('Must', () {
      testValidator = TestValidator();
      test(
        'should return invalid validation result'
        ' when value does not meet predicate criteria',
        () {
          const testClass = TestClass(9);
          final validationResult = testValidator.validate(testClass);

          expect(false, validationResult.isValid);
        },
      );

      test('should return valid validation result' ' when value is not null', () {
        const testClass = TestClass(3);
        final validationResult = testValidator.validate(testClass);

        expect(true, validationResult.isValid);
      });
    });
  });
}
