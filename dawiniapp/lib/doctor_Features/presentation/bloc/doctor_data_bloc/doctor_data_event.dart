// ignore_for_file: camel_case_types

part of 'doctor_data_bloc.dart';

abstract class DoctorPatientsEvent extends Equatable {}

class LoadedDataDoctorPatinetsEvent extends DoctorPatientsEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class onTurnUpdate extends DoctorPatientsEvent {
  final int turn;
  final DoctorEntity doctor;

  onTurnUpdate({required this.doctor, required this.turn});

  @override
  List<Object> get props => [doctor, turn];
}

class onStateUpdate extends DoctorPatientsEvent {
  final bool state;
  final DoctorEntity doctor;
  onStateUpdate({required this.doctor, required this.state});

  @override
  List<Object> get props => [doctor, state];
}

class onDataUpdate extends DoctorPatientsEvent {
  final DoctorEntity doctor;

  onDataUpdate({
    required this.doctor,
  });
  @override
  List<Object> get props => [
        doctor,
      ];
}
