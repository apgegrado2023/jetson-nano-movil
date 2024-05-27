import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestFailure extends Failure {}

class ResponseFailure extends Failure {
  ResponseFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class SocketFailure extends Failure {}

class DatabaseFailure extends Failure {}

class NotFoundFailure extends Failure {
  NotFoundFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class InvalidResolutionFailure extends Failure {}

class ResultFailure extends Failure {
  ResultFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ConnectionFailure extends Failure {}

class UnauthorizedFailure extends Failure {}

class NoInternetFailure extends Failure {}

class ConflictFailure extends Failure {}

class InternalFailure extends Failure {}

class ExeptionFailure extends Failure {
  ExeptionFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
