part of 'doctor_data_bloc.dart';

abstract class DoctorPatientsState extends Equatable {
  DoctorPatientsState();
}

/// UnInitialized
class doctorInfoInitial extends DoctorPatientsState {
  @override
  List<Object> get props => [];
}

class doctorInfoLoaded extends DoctorPatientsState {
  final List<DoctorEntity> doctors;
  doctorInfoLoaded(this.doctors);

  @override
  List<Object> get props => [doctors];
}

/// Initialized
class doctorInfoLoading extends DoctorPatientsState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class doctorInfoLoadingError extends DoctorPatientsState {
  doctorInfoLoadingError(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorDoctorPatientsState';

  @override
  List<Object> get props => [errorMessage];
}
