/// Thrown when a server response returns an unexpected error
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({this.message = 'Server error occurred', this.statusCode});

  @override
  String toString() => 'ServerException: $message (statusCode: $statusCode)';
}

/// Thrown when there is a caching failure (e.g. local storage read/write issues)
class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache error occurred']);

  @override
  String toString() => 'CacheException: $message';
}

/// Thrown when there is no internet connection

/// Generic exception for unexpected failures
class UnexpectedException implements Exception {
  final String message;

  UnexpectedException([this.message = 'Unexpected error occurred']);

  @override
  String toString() => 'UnexpectedException: $message';
}
