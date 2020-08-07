import 'package:passwd/models/validator.dart';

T validate<T>(Validator validator, String input, T truthy, T falsey) {
  return validator.validate(input) ? truthy : falsey;
}
