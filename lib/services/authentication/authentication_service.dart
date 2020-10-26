abstract class AuthenticationService {
  Future writePin(int pin, bool biometrics);
  Future writeBiometrics(bool allow);
  Future<String> readEncryptionKey();
  Future<bool> comparePin(int pin);
  Future<bool> allowBiometrics();
  Future<bool> isAppSetup();
}
