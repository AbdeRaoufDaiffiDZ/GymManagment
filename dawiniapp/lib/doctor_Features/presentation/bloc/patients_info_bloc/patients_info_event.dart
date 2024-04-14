// ignore_for_file: camel_case_types

part of 'patients_info_bloc.dart';

abstract class PatientsInfoEvent extends Equatable {}

class onGetPatinets extends PatientsInfoEvent {
  final BuildContext context;
  final bool today;
  final String uid;

  onGetPatinets(this.today, this.context, {required this.uid});

  @override
  List<Object> get props => [uid, today, context];
}

class LoadPatientsInfoEvent extends PatientsInfoEvent {
  @override
  List<Object?> get props => [];
}
