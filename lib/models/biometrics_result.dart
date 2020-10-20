/// [BiometricsResult] is used by services to return the state of biometric authentication
/// [AUTHENTICATED] is returned when Authentication is successful
/// [REJECTED] is returned when either the Authentication was cancelled or the max biometric attempts were exceeded
/// [UNAVAILABLE] is returned when biometrics are not available on the platform
enum BiometricsResult {
  AUTHENTICATED,
  REJECTED,
  UNAVAILABLE,
}
