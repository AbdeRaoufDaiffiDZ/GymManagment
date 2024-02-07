part of 'doctor_auth_bloc.dart';

sealed class DoctorAuthState extends Equatable {
  const DoctorAuthState();

  @override
  List<Object> get props => [];
}

final class DoctorAuthInitial extends DoctorAuthState {}

final class DoctorAuthLoading extends DoctorAuthState {}

final class DoctorAuthSuccessful extends DoctorAuthState {
  final UserCredential doctorAuth;

  DoctorAuthSuccessful({required this.doctorAuth});

  @override
  List<Object> get props => [doctorAuth];
}

final class DoctorAuthFailed extends DoctorAuthState {
  final String error;

  DoctorAuthFailed({required this.error});

  @override
  List<Object> get props => [error];
}
