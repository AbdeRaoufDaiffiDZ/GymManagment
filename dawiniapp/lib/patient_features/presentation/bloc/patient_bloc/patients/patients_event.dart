// ignore_for_file: camel_case_types

part of 'patients_bloc.dart';

sealed class PatientsEvent extends Equatable {
  const PatientsEvent();
  @override
  List<Object> get props => [];
}

class PatientsinitialEvent extends PatientsEvent {}

class onPatientsInfoUpdated extends PatientsEvent {
  final PatientEntity patients;

  const onPatientsInfoUpdated({required this.patients});

  @override
  List<Object> get props => [patients];
}

class onPatientsReload extends PatientsEvent {}

class onPatientsSetAppointments extends PatientsEvent {
  final PatientEntity patients;
  final BuildContext context;
  final bool ifADoctor;

  const onPatientsSetAppointments(this.context, this.ifADoctor,
      {required this.patients});

  @override
  List<Object> get props => [patients, context];
}

class onPatientsAppointmentDelete extends PatientsEvent {
  final PatientEntity patients;
  final BuildContext context;

  const onPatientsAppointmentDelete(this.context, {required this.patients});

  @override
  List<Object> get props => [patients, context];
}

class onSetFavoriteDoctor extends PatientsEvent {
  final String doctorUid;
  final BuildContext context;

  const onSetFavoriteDoctor(this.context, {required this.doctorUid});

  @override
  List<Object> get props => [doctorUid, context];
}

class onDeleteFavoriteDoctor extends PatientsEvent {
  final String doctorUid;
  final BuildContext context;

  const onDeleteFavoriteDoctor(this.context, {required this.doctorUid});

  @override
  List<Object> get props => [doctorUid, context];
}
