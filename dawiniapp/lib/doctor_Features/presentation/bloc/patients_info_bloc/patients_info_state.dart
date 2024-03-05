// ignore_for_file: must_be_immutable, unnecessary_this

part of 'patients_info_bloc.dart';

abstract class PatientsInfoState extends Equatable {
  const PatientsInfoState();
}

/// UnInitialized
class PatientsInfoLoaded extends PatientsInfoState {
  List<PatientEntity> patients;
  PatientsInfoLoaded(
    this.patients,
  );

  @override
  List<Object> get props => [patients];
  PatientsInfoLoaded copyWith(patients) {
    return PatientsInfoLoaded(patients ?? this.patients);
  }
}

class PatientsInfoinitial extends PatientsInfoState {
  @override
  List<Object> get props => [];
}

/// Initialized
class PatientsInfoLoading extends PatientsInfoState {
  @override
  List<Object?> get props => [];
}

class PatientsInfoLoadingError extends PatientsInfoState {
  const PatientsInfoLoadingError(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorPatientsInfoState';

  @override
  List<Object> get props => [errorMessage];
  PatientsInfoLoadingError copyWith(errorMessage) {
    return PatientsInfoLoadingError(errorMessage ?? this.errorMessage);
  }
}
