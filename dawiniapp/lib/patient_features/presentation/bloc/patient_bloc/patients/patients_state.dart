// ignore_for_file: must_be_immutable

part of 'patients_bloc.dart';

sealed class PatientsState extends Equatable {
  const PatientsState();

  @override
  List<Object> get props => [];
}

final class PatientsInitial extends PatientsState {}

final class PatientsLoading extends PatientsState {}

final class PatientsLoaded extends PatientsState {
  final List<PatientEntity> patients;

  const PatientsLoaded(this.patients);

  @override
  List<Object> get props => [patients];
}

final class PatientsLoadingError extends PatientsState {
  final String error;

  const PatientsLoadingError(this.error);

  @override
  List<Object> get props => [error];
}
