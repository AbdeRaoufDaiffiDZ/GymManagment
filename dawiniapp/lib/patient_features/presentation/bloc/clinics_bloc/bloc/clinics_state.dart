part of 'clinics_bloc.dart';

sealed class ClinicsState extends Equatable {
  const ClinicsState();

  @override
  List<Object> get props => [];
}

final class ClinicsInitial extends ClinicsState {}

final class ClinicLoading extends ClinicsState {}

final class SeeAllClinics extends ClinicsState {}

final class FilterByWilayaClinic extends ClinicsState {
  final String wilaya;

  const FilterByWilayaClinic({required this.wilaya});
  @override
  List<Object> get props => [wilaya];
}

final class ClinicsFilterSpeciality extends ClinicsState {
  final String speciality;

  const ClinicsFilterSpeciality({required this.speciality});

  @override
  List<Object> get props => [speciality];
}

final class ClinicLoaded extends ClinicsState {}

final class ClinicsSearchName extends ClinicsState {
  final String name;

  const ClinicsSearchName({required this.name});

  @override
  List<Object> get props => [name];
}

final class ChossenClinic extends ClinicsState {}

final class ClinicLoadingFailure extends ClinicsState {
  final String message;

  const ClinicLoadingFailure({required this.message});

  @override
  List<Object> get props => [message];
}
