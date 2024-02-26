part of 'doctor_bloc.dart';

sealed class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

final class DoctorInitial extends DoctorState {}

final class DoctorLoading extends DoctorState {}

final class LoadFavoriteDoctor extends DoctorState {
  final List<DoctorEntity> doctor;

  const LoadFavoriteDoctor({required this.doctor});

  @override
  List<Object> get props => [doctor];
}

final class DoctorFilterSpeciality extends DoctorState {
  final String speciality;

  final List<DoctorEntity> doctor;

  const DoctorFilterSpeciality(
      {required this.speciality, required this.doctor});

  @override
  List<Object> get props => [doctor, speciality];
}

final class DoctorLoaded extends DoctorState {}

final class ChossenDoctor extends DoctorState {}

final class DoctorSearchName extends DoctorState {
  final String name;

  const DoctorSearchName({required this.name});

  @override
  List<Object> get props => [name];
}

final class DoctorLoadingFailure extends DoctorState {
  final String message;

  const DoctorLoadingFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class SeeAllDoctors extends DoctorState {}

final class FilterByWilaya extends DoctorState {
  final String wilaya;

  const FilterByWilaya({required this.wilaya});
  @override
  List<Object> get props => [wilaya];
}
