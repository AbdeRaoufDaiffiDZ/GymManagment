
part of 'unlimited_plan_bloc.dart';

sealed class Unlimited_PlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IinitialState extends Unlimited_PlanState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends Unlimited_PlanState {
  final List<User_Data> users;

  SuccessState({required this.users});

  @override
  List<Object?> get props => [users];
}

class LoadingState extends Unlimited_PlanState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends Unlimited_PlanState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}