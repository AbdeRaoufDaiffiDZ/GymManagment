part of 'doctor_data_bloc.dart';

abstract class DoctorPatientsEvent extends Equatable {}

class LoadedDataDoctorPatinetsEvent extends DoctorPatientsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class onTurnUpdate extends DoctorPatientsEvent {
  final int turn;
  final DoctorEntity doctor;

  onTurnUpdate({required this.doctor, required this.turn});

  @override
  List<Object> get props => [turn];
}

class onStateUpdate extends DoctorPatientsEvent {
  final bool state;
  final DoctorEntity doctor;
  onStateUpdate({required this.doctor, required this.state});

  @override
  List<Object> get props => [state];
}

class onDataUpdate extends DoctorPatientsEvent {
  final int numberInList;
  final dynamic data;
  final String infoToUpdate;

  onDataUpdate(
      {required this.numberInList,
      required this.data,
      required this.infoToUpdate});
  @override
  List<Object> get props => [numberInList, data, infoToUpdate];
}
