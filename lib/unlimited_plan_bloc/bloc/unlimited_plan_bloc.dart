import 'dart:async';

import 'package:admin/data/mongo_db.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'unlimited_plan_event.dart';
part 'unlimited_plan_state.dart';

final MongoDatabase dataSource = MongoDatabase();

class Unlimited_PlanBloc
    extends Bloc<Unlimited_PlanEvent, Unlimited_PlanState> {
  Unlimited_PlanBloc() : super(IinitialState()) {
    on<Unlimited_PlanEvent>((event, emit) async {
      if (event is AddUserEvent) {
        emit(LoadingState());
        final result = await dataSource.InsertUser(user: event.user);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data = await dataSource.RetriveData();
          data.isRight
              ? emit(SuccessState(users: data.right))
              : emit(ErrorState(error: data.left.message));
        }
      } else if (event is GetUsersEvent) {
        emit(LoadingState());
        final data = await dataSource.RetriveData();
        data.isRight
            ? emit(SuccessState(users: data.right))
            : emit(ErrorState(error: data.left.message));
      } else if (event is DeleteUserEvent) {
        emit(LoadingState());
        final result = await dataSource.DeleteUser(user: event.user);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data = await dataSource.RetriveData();
          data.isRight
              ? emit(SuccessState(users: data.right))
              : emit(ErrorState(error: data.left.message));
        }
      }
      else if (event is UpdateUserEvent) {
        emit(LoadingState());
        final result = await dataSource.UpdateUserData(user: event.user );
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data = await dataSource.RetriveData();
          data.isRight
              ? emit(SuccessState(users: data.right))
              : emit(ErrorState(error: data.left.message));
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
