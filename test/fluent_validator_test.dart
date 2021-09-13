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
  const NodeUser(this.name);

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

extension on ValidatorBuilder {
  ValidatorBuilder isEmpty() {
    setRule(IsEmptyRule('Cant be empty'));
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
  }
}

void main() {
  test('ins aclisiit', () {
    final testUserValidator = TestUserValidator();
    const nodeUser = NodeUser(null);
    const testUser = TestUser(null, nodeUser);

    final a = testUserValidator.validate(testUser);
    print(a);
  });
}
