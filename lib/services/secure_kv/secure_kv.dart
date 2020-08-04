abstract class SecureKVService {
  Future<String> getValue(String key);
  Future putValue(String key, String value);
}
