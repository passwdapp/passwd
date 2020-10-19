import '../../models/biometrics_result.dart';

abstract class BiometricsService {
  Future<bool> biometricsAvailable();
  Future<BiometricsResult> authenticate(String reason);
}
