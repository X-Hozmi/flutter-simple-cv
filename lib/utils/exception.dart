class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'An error occured. Please try again later']);
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache error occurred']);
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class BiometricNotAvailableException implements Exception {
  final String message;

  BiometricNotAvailableException([this.message = 'Biometric not available']);
}

class BiometricNotEnabledException implements Exception {
  final String message;

  BiometricNotEnabledException([this.message = 'Biometric not enrolled']);
}

class BiometricAuthenticationException implements Exception {
  final String code;
  final String message;

  BiometricAuthenticationException(this.code,
      [this.message = 'Authentication failed']);
}
