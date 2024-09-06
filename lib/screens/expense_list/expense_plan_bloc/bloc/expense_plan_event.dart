
part of 'expense_plan_bloc.dart';
@immutable
sealed class Expense_PlanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class AddExpenseEvent extends Expense_PlanEvent {
  final Expense expense;
final BuildContext context;
  AddExpenseEvent({
    required this.context,required this.expense});

  @override
  List<Object?> get props => [expense, context];
}

class GetExpensesEvent extends Expense_PlanEvent {
  final BuildContext context;
  GetExpensesEvent({
    required this.context});
  @override
  List<Object?> get props => [context];
}
class DeleteExpenseEvent extends Expense_PlanEvent {
  final Expense expense;
final BuildContext context;
  DeleteExpenseEvent({
    required this.context,required this.expense});

  @override
  List<Object?> get props => [expense, context];
}

class UpdateExpenseEvent extends Expense_PlanEvent {
  final Expense expense;
  final Expense oldExpense;final BuildContext context;
  UpdateExpenseEvent({
    required this.context,required this.expense,required this.oldExpense });

  @override
  List<Object?> get props => [expense,oldExpense, context];
}