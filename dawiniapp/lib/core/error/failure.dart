import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({required super.message});
}

class UnKnownFailure extends Failure {
  const UnKnownFailure({required super.message});
}

class TimeOutFailure extends Failure {
  const TimeOutFailure({required super.message});
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({required super.message});
}

class AuthenticatinFailure extends Failure {
  const AuthenticatinFailure({required super.message});
}
