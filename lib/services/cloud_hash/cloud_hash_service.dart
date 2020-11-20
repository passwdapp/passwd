abstract class CloudHashService {
  String deriveSyncPassword(String username, String password);
  String deriveSyncEncryptionPassword(String username, String password);
}
