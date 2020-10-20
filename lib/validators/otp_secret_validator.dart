import '../models/validator.dart';

/// [OtpSecret] implements [Validator] interface to provide a validator used to validate the OTP secrets
/// It uses a regex to check validity of the input as a base32 input
/// The official TOTP spec allows the OTP secrets to be base32
/// References:
/// https://github.com/google/google-authenticator/wiki/Key-Uri-Format#secret
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
