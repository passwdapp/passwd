import '../models/validator.dart';

/// [MinMaxValidator] implements [Validator] interface to provide with a configurable validator
/// This returns true if length is between the min and the max values
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
