import 'package:fluent_validator/core/rule.dart';
import 'package:fluent_validator/core/validator.dart';
import 'package:fluent_validator/core/validator_builder.dart';
import 'package:flutter_test/flutter_test.dart';

class TestUser {
  const TestUser(this.id, this.nodeUser);

  final String? id;
  final NodeUser nodeUser;
}

class NodeUser {
  const NodeUser(this.name, this.nestedNodeUser);

  final NestedNodeUser nestedNodeUser;
  final String? name;
}

class NestedNodeUser {
  const NestedNodeUser(this.surname);

  final String? surname;
}

class IsEmptyRule extends Rule {
  IsEmptyRule(String errorMessage) : super(errorMessage);

  @override
  bool isValid(dynamic value) {
    return value != null;
  }
}

class LongerThanRule extends Rule {
  LongerThanRule(this.lenght, String errorMessage) : super(errorMessage);

  final int lenght;

  @override
  bool isValid(dynamic value) {
    if (value is String) {
      return value.length >= lenght;
    }
    throw UnimplementedError();
  }
}

extension on ValidatorBuilder {
  ValidatorBuilder isEmpty() {
    setRule(IsEmptyRule('Cant be empty'));
    return this;
  }

  ValidatorBuilder isLongerThan(int value) {
    setRule(LongerThanRule(value, 'Should be longer than'));
    return this;
  }
}

class TestUserValidator extends Validator<TestUser> {
  TestUserValidator() {
    rulesFor('id', (TestUser user) => user.id).isEmpty();
    rulesFor('NodeUser', (TestUser user) => user.nodeUser).setValidator(NodeUserValidator());
  }
}

class NodeUserValidator extends Validator<NodeUser> {
  NodeUserValidator() {
    rulesFor('name', (NodeUser nodeUser) => nodeUser.name).isEmpty();
    rulesFor('NestedNodeUser', (NodeUser nodeUser) => nodeUser.nestedNodeUser).setValidator(NestedNodeUserValidator());
  }
}

class NestedNodeUserValidator extends Validator<NestedNodeUser> {
  NestedNodeUserValidator() {
    rulesFor('surname', (NestedNodeUser nestedNodeUser) => nestedNodeUser.surname).isEmpty().isLongerThan(10);
  }
}

void main() {
  test('ins aclisiit', () {
    final testUserValidator = TestUserValidator();
    const nodeUser = NodeUser(null, NestedNodeUser('erkin'));
    const testUser = TestUser(null, nodeUser);

    testUserValidator.validate(testUser);
  });
}
