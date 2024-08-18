
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

class UpdateUserEvent extends Expense_PlanEvent {
   final User_Data user;
    
  UpdateUserEvent({required this.user, });

  @override
  List<Object?> get props => [user,];
}