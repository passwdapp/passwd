import '../../models/entries.dart';

abstract class CloudSyncService {
  Future<Entries> fetchRemoteEntries(
    Uri endpoint,
    String secretKey,
    String accessToken,
    String encryptionPassword,
  );

  Future<bool> syncLocalEntries(
    Entries entries,
    Uri endpoint,
    String secretKey,
    String accessToken,
    String encryptionPassword,
  );
}
