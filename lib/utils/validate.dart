import '../models/validator.dart';

/// [validate] provides a base validator to consume the validators
/// It accepts a [Validator], an input, a truthy and a falsey value
T validate<T>(Validator validator, String input, T truthy, T falsey) {
  return validator.validate(input) ? truthy : falsey;
}
