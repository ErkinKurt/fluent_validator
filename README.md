# fluent_validator

Rule based Fluent Validation API that can be used with your entities. You not only are able to use built-in validators but also create your own validators and write extensions on ValidatorBuilder to use it effectively.

## Usage

Create a validator by extending `Validator` base class with the type of the class that you want to validate. You can chain the rules. Here is an example of a simple usage:

``` dart
class TestClass {
  const TestClass(this.prop1);

  final String prop1;
}

class TestValidator extends Validator<TestClass> {
  TestValidator() {
    rulesFor('Prop1', (TestClass testClass) => testClass.prop1).emailAddress();
  }
}
```

With this simple configuration now you can validate your class:

``` dart
 final testValidator = TestValidator();
 final testClass = TestClass();

 final validationResult = testValidator.validate(testClass);
```

ValidationResult will return with the errors which are encountered while validating the entity.
## Complex Class Validation

Sometimes you may wish to validate complex classes that doesn't have primitives but other classes as props. You can use `setValidator` method to register the validator for the prop

``` dart
class TestClass {
  const TestClass(this.prop1);

  final String prop1;
}

class TestValidator extends Validator<TestClass> {
  TestValidator() {
    rulesFor('Prop1', (TestClass testClass) => testClass.prop1).emailAddress();
  }
}


class ComplexClass {
    const ComplexClass(this.testClass);

    final TestClass testClass;
}

class ComplexClassValidator extends Validator<ComplexClass> {
    ComplexClassValidator() {
        rulesFor('TestClass', (ComplexClass compClass) => compClass.testClass).setValidator(TestValidator());
    }
}
```

## Custom Validators
The one can create custom validators for his/her demands. In order to achieve this:
* Create your own rule.
* Add an extension method on ValidatorBuilder.

``` dart
class FooRule extends Rule {
  FooRule(String message) : super(message);

  @override
  bool isValid(dynamic value) {
    if (value is String) {
      return _isValidFoo(value);
    }
    throw UnimplementedError();
  }

  bool _isValidFoo(String value) {
    // do your logic and return bool
    return toBeOrNotToBe;
  }
}

extension MyValidators on ValidatorBuilder {
  ValidatorBuilder notEmpty() {
    setRule(FooRule('Value should be valid foo'));
    return this;
  }
}
```
# Credits
Inspired by [Fluent Validation](https://fluentvalidation.net/).