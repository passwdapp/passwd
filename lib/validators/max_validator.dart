import 'package:flutter/foundation.dart';

import '../models/validator.dart';

/// [MaxValidator] implements [Validator] interface to provide with a configurable validator
/// This returns true if the max length condition is met
class MaxValidator implements Validator {
  int max;

  MaxValidator({@required this.max}) : assert(max != null);

  @override
  bool validate(String input) {
    return input.length <= max;
  }
}
