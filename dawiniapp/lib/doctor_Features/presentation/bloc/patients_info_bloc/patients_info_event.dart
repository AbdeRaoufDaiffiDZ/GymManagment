part of 'patients_info_bloc.dart';

abstract class PatientsInfoEvent extends Equatable {}

class onGetPatinets extends PatientsInfoEvent {
  final bool today;
  final String uid;

  onGetPatinets(this.today, {required this.uid});

  @override
  List<Object> get props => [uid];
}

class LoadPatientsInfoEvent extends PatientsInfoEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
