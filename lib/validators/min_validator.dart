import 'package:flutter/foundation.dart';

import '../models/validator.dart';

/// [MinValidator] implements [Validator] interface to provide with a configurable validator
/// This returns true if the min length condition is met
class MinValidator implements Validator {
  int min;

  MinValidator({@required this.min}) : assert(min != null);

  @override
  bool validate(String input) {
    return input.length >= min;
  }
}
