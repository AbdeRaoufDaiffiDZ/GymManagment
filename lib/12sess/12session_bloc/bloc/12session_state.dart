
part of '12session_bloc.dart';

sealed class session_12_PlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IinitialState extends session_12_PlanState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends session_12_PlanState {
  final List<User_Data> users;

  SuccessState({required this.users});

  @override
  List<Object?> get props => [users];
}

class LoadingState extends session_12_PlanState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends session_12_PlanState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}