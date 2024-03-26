part of 'doctor_bloc.dart';

sealed class DoctorState extends Equatable {
  const DoctorState();
}

final class DoctorInitial extends DoctorState {
  @override
  List<Object> get props => [];
}

final class DoctorLoading extends DoctorState {
  @override
  List<Object> get props => [];
}

final class LoadFavoriteDoctor extends DoctorState {
  final List<DoctorEntity> doctor;

  const LoadFavoriteDoctor({required this.doctor});

  @override
  List<Object> get props => [doctor];
}

final class DoctorFilterSpeciality extends DoctorState {
  final String speciality;
  final String? doctorName;
  final String? doctorWilaya;
  const DoctorFilterSpeciality({
    required this.doctorWilaya,
    required this.doctorName,
    required this.speciality,
  });

  @override
  List<Object?> get props => [speciality, doctorName, doctorWilaya];
}

final class DoctorLoaded extends DoctorState {
  @override
  List<Object> get props => [];
}

final class ChossenDoctor extends DoctorState {
  @override
  List<Object> get props => [];
}

final class DoctorSearchName extends DoctorState {
  final String name;
  final String? doctorSpeciality;
  final String? doctorWilaya;
  const DoctorSearchName(
      {required this.doctorSpeciality,
      required this.doctorWilaya,
      required this.name});

  @override
  List<Object?> get props => [name, doctorSpeciality, doctorWilaya];
}

final class DoctorLoadingFailure extends DoctorState {
  final String message;

  const DoctorLoadingFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class SeeAllDoctors extends DoctorState {
  @override
  List<Object> get props => [];
}

final class FilterByWilaya extends DoctorState {
  final String wilaya;
  final String? doctorName;
  final String? doctorSpeciality;
  const FilterByWilaya(
      {required this.doctorSpeciality,
      required this.doctorName,
      required this.wilaya});
  @override
  List<Object?> get props => [wilaya, doctorName, doctorSpeciality];
}
