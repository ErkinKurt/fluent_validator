import 'package:fluent_validator/core/validator.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fluent_validator/fluent_validator.dart';

class TestUser {
  final String id;

  TestUser(this.id);
}

class TestUserValidator extends Validator<TestUser> {
  TestUserValidator() {
    rulesFor(
      'id',
    );
  }
}

void main() {}
