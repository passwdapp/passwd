abstract class MigrationService {
  Future<bool> needsMigration();
  Future migrate();
}
