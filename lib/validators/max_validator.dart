import 'package:passwd/models/validator.dart';

class MinValidator implements Validator {
  int max;

  MinValidator({this.max}) : assert(max != null);

  bool validate(String input) {
    return input.length <= max;
  }
}
