
part of '16session_bloc.dart';

sealed class session_16_PlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IinitialState extends session_16_PlanState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends session_16_PlanState {
  final List<User_Data> users;

  SuccessState({required this.users});

  @override
  List<Object?> get props => [users];
}

class LoadingState extends session_16_PlanState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends session_16_PlanState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}