import '../models/validator.dart';

class MaxValidator implements Validator {
  int max;

  MaxValidator({this.max}) : assert(max != null);

  @override
  bool validate(String input) {
    return input.length <= max;
  }
}
