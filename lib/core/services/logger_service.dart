import 'dart:developer' as developer;

/// A service for structured logging across the app
class LoggerService {
  /// Logs an info message
  static void info(String message, {String tag = 'INFO'}) {
    developer.log(message, name: tag, level: 800);
  }

  /// Logs a warning message
  static void warning(String message, {String tag = 'WARNING'}) {
    developer.log(message, name: tag, level: 900);
  }

  /// Logs an error message
  static void error(
    String message, {
    String tag = 'ERROR',
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: tag,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Logs a debug message (only in debug mode)
  static void debug(String message, {String tag = 'DEBUG'}) {
    assert(() {
      developer.log(message, name: tag, level: 500);
      return true;
    }());
  }
}
