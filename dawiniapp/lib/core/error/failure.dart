import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({required this.message});
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class ConnectionFailure extends Failure {
  ConnectionFailure({required super.message});
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required super.message});
}

class AuthenticatinFailure extends Failure {
  AuthenticatinFailure({required super.message});
}
