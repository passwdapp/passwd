abstract class AuthenticationService {
  Future writePin(int pin);
  Future writeBiometrics(bool allow);
  Future<String> readEncryptionKey();
  Future<bool> comparePin(int pin);
  Future<bool> allowBiometrics();
}
