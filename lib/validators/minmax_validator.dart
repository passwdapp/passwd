import 'package:passwd/models/validator.dart';

class MinMaxValidator implements Validator {
  int min;
  int max;

  MinMaxValidator({
    this.min,
    this.max,
  })  : assert(min != null),
        assert(max != null);

  @override
  bool validate(String input) {
    return input.length >= min && input.length <= max;
  }
}
