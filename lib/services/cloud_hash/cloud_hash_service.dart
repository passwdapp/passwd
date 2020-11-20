abstract class CloudHashService {
  String deriveSyncPassword(String username, String password);
  Future<String> deriveSyncEncryptionPassword(String username, String password);
}
