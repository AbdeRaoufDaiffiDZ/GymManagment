// ignore_for_file: camel_case_types

part of 'doctor_auth_bloc.dart';

sealed class DoctorAuthEvent extends Equatable {
  const DoctorAuthEvent();

  @override
  List<Object> get props => [];
}

final class onSignIn extends DoctorAuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const onSignIn(
      {required this.context, required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class onPasswordForget extends DoctorAuthEvent {
  final String email;
  final BuildContext context;

  const onPasswordForget({required this.context, required this.email});

  @override
  List<Object> get props => [email];
}

final class onRegisterDoctor extends DoctorAuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  final DoctorEntity doctorData;

  const onRegisterDoctor(
      {required this.context,
      required this.email,
      required this.doctorData,
      required this.password});

  @override
  List<Object> get props => [email, doctorData, password];
}

final class onSignOutDoctor extends DoctorAuthEvent {
  final BuildContext context;

  const onSignOutDoctor({required this.context});

  @override
  List<Object> get props => [context];
}

// final class onDeleteDoctorAccount extends DoctorAuthEvent {
//   final BuildContext context;

//   const onDeleteDoctorAccount({required this.context});

//   @override
//   List<Object> get props => [context];
// }
