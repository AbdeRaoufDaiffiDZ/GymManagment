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
  LoadFavoriteDoctor copyWith(doctor) {
    return LoadFavoriteDoctor(doctor: doctor ?? this.doctor);
  }
}

final class DoctorFilterSpeciality extends DoctorState {
  final String speciality;

  final List<DoctorEntity> doctor;

  const DoctorFilterSpeciality(
      {required this.speciality, required this.doctor});

  @override
  List<Object> get props => [doctor, speciality];
  DoctorFilterSpeciality copyWith(doctor, speciality) {
    return DoctorFilterSpeciality(
        doctor: doctor ?? this.doctor,
        speciality: speciality ?? this.speciality);
  }
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

  const DoctorSearchName({required this.name});

  @override
  List<Object> get props => [name];
  DoctorSearchName copyWith(name) {
    return DoctorSearchName(
      name: name ?? this.name,
    );
  }
}

final class DoctorLoadingFailure extends DoctorState {
  final String message;

  const DoctorLoadingFailure({required this.message});

  @override
  List<Object> get props => [message];
  DoctorLoadingFailure copyWith(message) {
    return DoctorLoadingFailure(
      message: message ?? this.message,
    );
  }
}

final class SeeAllDoctors extends DoctorState {
  @override
  List<Object> get props => [];
}

final class FilterByWilaya extends DoctorState {
  final String wilaya;

  const FilterByWilaya({required this.wilaya});
  @override
  List<Object> get props => [wilaya];
  FilterByWilaya copyWith(wilaya) {
    return FilterByWilaya(
      wilaya: wilaya ?? this.wilaya,
    );
  }
}
