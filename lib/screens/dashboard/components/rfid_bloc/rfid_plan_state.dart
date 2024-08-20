
part of 'rfid_plan_bloc.dart';

sealed class Rfid_PlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IinitialState extends Rfid_PlanState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends Rfid_PlanState {
  final String? done;
  final User_Data? user;
  SuccessState({required this.done, required this.user});

  @override
  List<Object?> get props => [done,user];
}

class LoadingState extends Rfid_PlanState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends Rfid_PlanState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}