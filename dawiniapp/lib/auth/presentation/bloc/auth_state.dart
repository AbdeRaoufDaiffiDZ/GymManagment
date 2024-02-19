import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class LoginState extends AuthState {}
class SuccessasfulLogin extends AuthState {}

/// Initialized
class RegisterState extends AuthState {}

class ResetPassSatate extends AuthState {}

class LoadAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String error;

  const ErrorAuthState({required this.error});
}
