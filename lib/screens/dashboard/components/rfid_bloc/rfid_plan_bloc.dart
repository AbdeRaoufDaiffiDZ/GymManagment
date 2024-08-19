import 'dart:async';

import 'package:admin/data/mongo_db.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'rfid_plan_event.dart';
part 'rfid_plan_state.dart';

final MongoDatabase dataSource = MongoDatabase();
final collectionName = "Expense";

class Rfid_PlanBloc extends Bloc<Rfid_PlanEvent, Rfid_PlanState> {
  Rfid_PlanBloc() : super(IinitialState()) {
    on<Rfid_PlanEvent>((event, emit) async {
      if (event is UpdateUserEvent) {
        emit(LoadingState());
        final result = await dataSource.UpdateUserUsingRFID(id: event.id);
        if (result.isRight) {
          if (result.right == 'try again') {
            emit(ErrorState(error: result.right));
          } else {
            emit(SuccessState(done: result.right));
          }
        } else if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        }
      }
    });
  }

  @override
  Future<void> close() async {
    await super.close();
    MongoDatabase.close();
  }
}
