// ignore_for_file: camel_case_types

part of 'doctor_bloc.dart';

sealed class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class onDoctorChoose extends DoctorEvent {
  final DoctorEntity doctor;

  const onDoctorChoose({
    required this.doctor,
  });

  @override
  List<Object> get props => [doctor];
}

class onLoadFavoriteDoctor extends DoctorEvent {}

class doctorsInfoUpdated extends DoctorEvent {
  final List<DoctorEntity> doctors;

  const doctorsInfoUpdated({required this.doctors});

  @override
  List<Object> get props => [doctors];
}

class onDoctorsearchByName extends DoctorEvent {
  final String doctorName;

  const onDoctorsearchByName({required this.doctorName});

  @override
  List<Object> get props => [
        doctorName,
      ];
}

class onDoctorsearchByspeciality extends DoctorEvent {
  final String speciality;
  final List<DoctorEntity> doctors;
  const onDoctorsearchByspeciality(
      {required this.doctors, required this.speciality});

  @override
  List<Object> get props => [speciality, doctors];
}

class onDoctorsearchByWilaya extends DoctorEvent {
  final String wilaya;

  const onDoctorsearchByWilaya({required this.wilaya});

  @override
  List<Object> get props => [
        wilaya,
      ];
}

class DoctorinitialEvent extends DoctorEvent {}

class onSeeAllDoctors extends DoctorEvent {
  @override
  List<Object> get props => [];
}
