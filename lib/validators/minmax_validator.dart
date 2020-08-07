import 'package:passwd/models/validator.dart';

class MinValidator implements Validator {
  int min;
  int max;

  MinValidator({
    this.min,
    this.max,
  })  : assert(min != null),
        assert(max != null);

  bool validate(String input) {
    return input.length >= min && input.length <= max;
  }
}
