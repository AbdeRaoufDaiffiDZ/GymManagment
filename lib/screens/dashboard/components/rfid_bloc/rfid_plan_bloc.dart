import 'dart:async';

import 'package:admin/data/mongo_db.dart';
import 'package:admin/entities/user_data_entity.dart';
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
        final result = await dataSource.UpdateUserUsingRFID(id: event.id,context: event.context);
        if (result.isRight) {
          if (result.right[0] == 'try again') {
            emit(ErrorState(error: result.right[0]));
          } else {
            emit(SuccessState(done: result.right[0], user: result.right[1], usersChecked:result.right[3]));
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
  }
}