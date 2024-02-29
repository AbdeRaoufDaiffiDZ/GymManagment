// ignore_for_file: must_be_immutable

part of 'patients_info_bloc.dart';

abstract class PatientsInfoState extends Equatable {
  PatientsInfoState();
}

/// UnInitialized
class PatientsInfoLoaded extends PatientsInfoState {
  List<PatientEntity> patients;
  PatientsInfoLoaded(
    this.patients,
  );

  @override
  List<Object> get props => [patients];
}

class PatientsInfoinitial extends PatientsInfoState {
  @override
  List<Object> get props => [];
}

/// Initialized
class PatientsInfoLoading extends PatientsInfoState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PatientsInfoLoadingError extends PatientsInfoState {
  PatientsInfoLoadingError(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorPatientsInfoState';

  @override
  List<Object> get props => [errorMessage];
}
