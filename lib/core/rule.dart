abstract class Rule {
  const Rule(this.errorMessage);

  final String errorMessage;

  bool isValid(dynamic value);
}
