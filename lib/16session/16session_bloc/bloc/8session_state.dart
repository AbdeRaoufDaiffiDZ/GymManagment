
part of '8session_bloc.dart';

sealed class session_8_PlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IinitialState extends session_8_PlanState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends session_8_PlanState {
  final List<User_Data> users;

  SuccessState({required this.users});

  @override
  List<Object?> get props => [users];
}

class LoadingState extends session_8_PlanState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends session_8_PlanState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}