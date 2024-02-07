part of 'doctor_auth_bloc.dart';

sealed class DoctorAuthEvent extends Equatable {
  const DoctorAuthEvent();

  @override
  List<Object> get props => [];
}

final class onSignIn extends DoctorAuthEvent {
  final String email;
  final String password;

  onSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
