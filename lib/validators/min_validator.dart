import 'package:passwd/models/validator.dart';

class MinValidator implements Validator {
  int min;

  MinValidator({this.min}) : assert(min != null);

  @override
  bool validate(String input) {
    return input.length >= min;
  }
}
