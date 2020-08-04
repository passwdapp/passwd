abstract class AuthenticationService {
  Future writePin(int pin);
  Future<String> readEncryptionKey();
  Future<bool> comparePin(int pin);
}
