// ignore_for_file: camel_case_types

part of 'doctor_data_bloc.dart';

abstract class DoctorPatientsState extends Equatable {
  const DoctorPatientsState();
}

/// UnInitialized
class doctorInfoInitial extends DoctorPatientsState {
  @override
  List<Object> get props => [];
}

class doctorInfoLoaded extends DoctorPatientsState {
  final List<DoctorEntity> doctors;
  const doctorInfoLoaded(this.doctors);

  @override
  List<Object> get props => [doctors];
  doctorInfoLoaded copyWith(doctors) {
    return doctorInfoLoaded(doctors ?? this.doctors);
  }
}

/// Initialized
class doctorInfoLoading extends DoctorPatientsState {
  @override
  List<Object?> get props => [];
}

class doctorInfoLoadingError extends DoctorPatientsState {
  const doctorInfoLoadingError(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorDoctorPatientsState';

  @override
  List<Object> get props => [errorMessage];
  doctorInfoLoadingError copyWith(errorMessage) {
    return doctorInfoLoadingError(errorMessage ?? this.errorMessage);
  }
}
