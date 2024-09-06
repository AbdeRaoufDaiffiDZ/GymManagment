import 'dart:async';

import 'package:admin/data/mongo_db.dart';
import 'package:admin/entities/gym_parm_entity.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'expense_plan_event.dart';
part 'expense_plan_state.dart';

final MongoDatabase dataSource = MongoDatabase();
final collectionName = "Expense";
class Expense_PlanBloc
    extends Bloc<Expense_PlanEvent, Expense_PlanState> {
  Expense_PlanBloc() : super(IinitialState()) {
    on<Expense_PlanEvent>((event, emit) async {
      if (event is AddExpenseEvent) {
        emit(LoadingState());
        final result = await dataSource.UpdateExpenseData(collectionName: collectionName, expense: event.expense, context: event.context);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data = await dataSource.RetriveExpense(collectionName: collectionName, context: event.context);
          data.isRight
              ? emit(SuccessState(expense: data.right.expenses,gymParam: data.right))
              : emit(ErrorState(error: data.left.message));
        }
      } else if (event is GetExpensesEvent) {
        emit(LoadingState());
        final data = await dataSource.RetriveExpense(collectionName: collectionName, context: event.context);
        data.isRight
            ? emit(SuccessState(expense: data.right.expenses,gymParam: data.right))
            : emit(ErrorState(error: data.left.message));
      } else if (event is DeleteExpenseEvent) {
        emit(LoadingState());
        final result = await dataSource.RemoveExpense(expense: event.expense, collectionName: collectionName, context: event.context);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data = await dataSource.RetriveExpense(collectionName: collectionName, context: event.context);
          data.isRight
              ? emit(SuccessState(expense: data.right.expenses,gymParam: data.right))
              : emit(ErrorState(error: data.left.message));
        }
      }
      else if (event is UpdateExpenseEvent) {
        emit(LoadingState());
        final result = await dataSource.UpdateExpenseData(collectionName: collectionName, expense: event.expense, oldExpense: event.oldExpense, context: event.context);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data = await dataSource.RetriveExpense(collectionName: collectionName, context: event.context);
          data.isRight
              ? emit(SuccessState(expense: data.right.expenses,gymParam: data.right))
              : emit(ErrorState(error: data.left.message));
        }
      }
    });
  }

  @override
  Future<void> close() async {
    await super.close();
  }
}