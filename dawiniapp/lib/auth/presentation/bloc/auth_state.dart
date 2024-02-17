import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  AuthState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnAuthState extends AuthState {

  UnAuthState();

  @override
  String toString() => 'UnAuthState';
}

/// Initialized
class InAuthState extends AuthState {
  InAuthState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InAuthState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorAuthState extends AuthState {
  ErrorAuthState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorAuthState';

  @override
  List<Object> get props => [errorMessage];
}
