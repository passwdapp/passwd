import 'package:passwd/models/validator.dart';

class OtpSecretValidator implements Validator {
  @override
  bool validate(String input) {
    return (input.length == 16 || input.length == 32) &&
        RegExp(
          r"^(?:[A-Z2-7]{8})*(?:[A-Z2-7]{2}={6}|[A-Z2-7]{4}={4}|[A-Z2-7]{5}={3}|[A-Z2-7]{7}=)?$",
        ).hasMatch(
          input,
        );
  }
}
