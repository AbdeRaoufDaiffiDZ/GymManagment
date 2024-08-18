
part of 'expense_plan_bloc.dart';

sealed class Expense_PlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IinitialState extends Expense_PlanState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends Expense_PlanState {
  final List<Expense>? expense;
  final GymParam? gymParam;
  SuccessState({required this.expense, required this.gymParam});

  @override
  List<Object?> get props => [expense,gymParam];
}

class LoadingState extends Expense_PlanState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends Expense_PlanState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}