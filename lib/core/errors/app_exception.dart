sealed class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException({String message = 'No internet connection'})
      : super(message: message);
}

class TimeoutException extends AppException {
  const TimeoutException({String message = 'Request timed out'})
      : super(message: message);
}

class ServerException extends AppException {
  const ServerException({String message = 'Server error occurred', int? statusCode})
      : super(message: message, statusCode: statusCode);
}

class InvalidResponseException extends AppException {
  const InvalidResponseException({String message = 'Invalid response from server'})
      : super(message: message);
}

class CacheException extends AppException {
  const CacheException({String message = 'Failed to load cached data'})
      : super(message: message);
}

class ValidationException extends AppException {
  const ValidationException({String message = 'Validation error'})
      : super(message: message);
}
