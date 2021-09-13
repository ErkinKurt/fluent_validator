// typedef ExpressionName = String;
// typedef Expression = dynamic Function(dynamic value);
// typedef ExpressionRulesMap = Map<Expression, List<Rule>>;

// class Rule {}

// abstract class Validator<T> {
//   final Map<ExpressionName, ExpressionRulesMap> _properties = {};

//   void rulesFor<T>(ExpressionName expressionName, Expression expression) {
//     _properties[expressionName] = {expression: const []};
//     return;
//   }
// }

import 'package:fluent_validator/results/validation_failure.dart';
import 'package:fluent_validator/results/validation_result.dart';

typedef ExpressionName = String;
typedef ExpressionFunc<T> = dynamic Function(T value);

abstract class Rule {
  const Rule(this.errorMessage);

  final String errorMessage;

  bool isValid(dynamic value);
}

class RuleBuilder<T> {
  const RuleBuilder(this.expression);

  final Expression expression;
}

class Expression<T> {
  Expression({required this.expressionName, required this.expressionFunc});

  final ExpressionName expressionName;
  final ExpressionFunc<T> expressionFunc;
  final List<Rule> _rules = [];

  void addRule(Rule rule) {
    _rules.add(rule);
  }
}

class ValidationContext {
  final Map<ExpressionName, Validator> registeredValidatiors = {};

  void registerValidator(ExpressionName expressionName, Validator validator) {
    registeredValidatiors[expressionName] = validator;
  }
}

abstract class Validator<T> {
  final List<Expression<T>> expressions = [];
  final ValidationContext _validationContext = ValidationContext();
  late T objectToValidate;

  ValidatorBuilder rulesFor(ExpressionName name, ExpressionFunc<T> expressionFunc) {
    final expression = Expression<T>(expressionName: name, expressionFunc: expressionFunc);
    expressions.add(expression);
    return ValidatorBuilder<T>(expression, _validationContext);
  }

  ValidationResult validate(T object) {
    objectToValidate = object;
    final validationFailures = expressions.map(_validateExpression).toList();
    return ValidationResult(validationFailures);
  }

  ValidationFailure _validateExpression(Expression<T> expression) {
    final dynamic expressionValue = expression.expressionFunc(objectToValidate);

    if (_isValidatorRegistered(expression)) {
      final a = _validateExpressionWithRegisteredValidator(expression);
      print(a);
    }

    final errors = expression._rules.map((rule) {
      final isValid = rule.isValid(expression.expressionFunc(objectToValidate));
      if (!isValid) {
        return rule.errorMessage;
      }
    });

    final validationFailure = ValidationFailure(
      name: expression.expressionName,
      attemptedValue: expressionValue,
      message: errors.join(', '),
    );

    return validationFailure;
  }

  bool _isValidatorRegistered(Expression expression) =>
      _validationContext.registeredValidatiors.containsKey(expression.expressionName);

  ValidationResult _validateExpressionWithRegisteredValidator(Expression expression) {
    final validator = _validationContext.registeredValidatiors[expression.expressionName];
    final dynamic expressionValue = expression.expressionFunc(objectToValidate);

    final validationResult = validator!.validate(expressionValue);
    return validationResult;
  }
}

class ValidatorBuilder<T> {
  const ValidatorBuilder(this.expression, this.validationContext);

  final Expression<T> expression;
  final ValidationContext validationContext;

  void setValidator(Validator<T> validator) {
    validationContext.registerValidator(expression.expressionName, validator);
  }

  void setRule(Rule rule) {
    expression.addRule(rule);
  }
}





// abstract class Validator {
//   // Map<ExpressionName, Expression> expressions = {};
//   final List<Expression> expressions = const [];

//   ValidatorBuilder rulesFor(Expression expression) {
//     expressions.add(expression);
//     return ValidatorBuilder(expression);
//   }

//   ValidationResult validate() {
//     const validationFailures = <ValidationFailure>[];
//   }

//   bool isValid(dynamic value);

//   List<ValidationFailure> _validateExpressionValidators(List<Validator> validators) {}
// }

// class ValidatorBuilder {
//   const ValidatorBuilder(this.expression);

//   final Expression expression;

//   void setValidator(Validator validator) {
//     expression.addValidator(validator);
//   }
// }

// class ValidationResult {
//   const ValidationResult({required this.errors});

//   final List<ValidationFailure> errors;
//   bool get isValid => errors.isNotEmpty;
// }

// class ValidationFailure {
//   const ValidationFailure({
//     required this.propertyName,
//     required this.attemptedValue,
//     required this.errorMessage,
//   });

//   final String propertyName;
//   final dynamic attemptedValue;
//   final String errorMessage;
// }
// // typedef ExpressionName = String;
// // typedef Expression = dynamic Function(dynamic value);
// // typedef ExpressionRulesMap = Map<Expression, List<Rule>>;

// // class Rule {}

// // abstract class Validator<T> {
// //   final Map<ExpressionName, ExpressionRulesMap> _properties = {};

// //   void rulesFor<T>(ExpressionName expressionName, Expression expression) {
// //     _properties[expressionName] = {expression: const []};
// //     return;
// //   }
// // }

// typedef ExpressionName = String;
// typedef ExpressionFunc = dynamic Function(dynamic value);

// class Expression {
//   Expression({required this.expressionName, required this.expressionFunc});

//   final ExpressionName expressionName;
//   final ExpressionFunc expressionFunc;
//   final List<Validator> _validators = [];

//   void addValidator(Validator validator) {
//     _validators.add(validator);
//   }
// }

// abstract class Validator {
//   // Map<ExpressionName, Expression> expressions = {};
//   final List<Expression> expressions = const [];

//   ValidatorBuilder rulesFor(Expression expression) {
//     expressions.add(expression);
//     return ValidatorBuilder(expression);
//   }

//   ValidationResult validate() {
//     const validationFailures = <ValidationFailure>[];
//   }

//   bool isValid(dynamic value);

//   List<ValidationFailure> _validateExpressionValidators(List<Validator> validators) {}
// }

// class ValidatorBuilder {
//   const ValidatorBuilder(this.expression);

//   final Expression expression;

//   void setValidator(Validator validator) {
//     expression.addValidator(validator);
//   }
// }

// class ValidationResult {
//   const ValidationResult({required this.errors});

//   final List<ValidationFailure> errors;
//   bool get isValid => errors.isNotEmpty;
// }

// class ValidationFailure {
//   const ValidationFailure({
//     required this.propertyName,
//     required this.attemptedValue,
//     required this.errorMessage,
//   });

//   final String propertyName;
//   final dynamic attemptedValue;
//   final String errorMessage;
// }
// // typedef ExpressionName = String;
// // typedef Expression = dynamic Function(dynamic value);
// // typedef ExpressionRulesMap = Map<Expression, List<Rule>>;

// // class Rule {}

// // abstract class Validator<T> {
// //   final Map<ExpressionName, ExpressionRulesMap> _properties = {};

// //   void rulesFor<T>(ExpressionName expressionName, Expression expression) {
// //     _properties[expressionName] = {expression: const []};
// //     return;
// //   }
// // }

// typedef ExpressionName = String;
// typedef ExpressionFunc = dynamic Function(dynamic value);

// class Expression {
//   Expression({required this.expressionName, required this.expressionFunc});

//   final ExpressionName expressionName;
//   final ExpressionFunc expressionFunc;
//   final List<Validator> _validators = [];

//   void addValidator(Validator validator) {
//     _validators.add(validator);
//   }
// }

// abstract class Validator {
//   // Map<ExpressionName, Expression> expressions = {};
//   final List<Expression> expressions = const [];

//   ValidatorBuilder rulesFor(Expression expression) {
//     expressions.add(expression);
//     return ValidatorBuilder(expression);
//   }

//   ValidationResult validate() {
//     const validationFailures = <ValidationFailure>[];
//   }

//   bool isValid(dynamic value);

//   List<ValidationFailure> _validateExpressionValidators(List<Validator> validators) {}
// }

// class ValidatorBuilder {
//   const ValidatorBuilder(this.expression);

//   final Expression expression;

//   void setValidator(Validator validator) {
//     expression.addValidator(validator);
//   }
// }

// class ValidationResult {
//   const ValidationResult({required this.errors});

//   final List<ValidationFailure> errors;
//   bool get isValid => errors.isNotEmpty;
// }

// class ValidationFailure {
//   const ValidationFailure({
//     required this.propertyName,
//     required this.attemptedValue,
//     required this.errorMessage,
//   });

//   final String propertyName;
//   final dynamic attemptedValue;
//   final String errorMessage;
// }
