part of 'doctor_patients_bloc.dart';

abstract class DoctorPatientsState extends Equatable {
  DoctorPatientsState();
}

/// UnInitialized
class patintsInfoLoaded extends DoctorPatientsState {
  final List<DoctorEntity> doctors;
  patintsInfoLoaded(this.doctors);

  @override
  List<Object> get props => [doctors];
}

/// Initialized
class patintsInfoLoading extends DoctorPatientsState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class patintsInfoLoadingError extends DoctorPatientsState {
  patintsInfoLoadingError(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorDoctorPatientsState';

  @override
  List<Object> get props => [errorMessage];
}
