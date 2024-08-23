
part of 'expense_plan_bloc.dart';
@immutable
sealed class Expense_PlanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class AddExpenseEvent extends Expense_PlanEvent {
  final Expense expense;

  AddExpenseEvent({required this.expense});

  @override
  List<Object?> get props => [expense];
}

class GetExpensesEvent extends Expense_PlanEvent {
  @override
  List<Object?> get props => [];
}
class DeleteExpenseEvent extends Expense_PlanEvent {
  final Expense expense;

  DeleteExpenseEvent({required this.expense});

  @override
  List<Object?> get props => [expense];
}

class UpdateExpenseEvent extends Expense_PlanEvent {
  final Expense expense;
  final Expense oldExpense;
  UpdateExpenseEvent({required this.expense,required this.oldExpense });

  @override
  List<Object?> get props => [expense,oldExpense];
}