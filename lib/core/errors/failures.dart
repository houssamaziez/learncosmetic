import 'package:equatable/equatable.dart';

/// Base class for all failure types
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure related to server responses
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(String message, {this.statusCode}) : super(message);

  @override
  List<Object?> get props => [message, statusCode];
}

/// Failure related to cache issues
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

/// Failure due to network issues (no connection)
class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

/// Failure due to unexpected unknown behavior
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String message) : super(message);
}
