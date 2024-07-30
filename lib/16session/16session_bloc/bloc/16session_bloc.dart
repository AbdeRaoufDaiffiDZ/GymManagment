import 'dart:async';

import 'package:admin/16session/16session_bloc/bloc/session_16_event.dart';
import 'package:admin/data/mongo_db.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '16session_state.dart';

final MongoDatabase dataSource = MongoDatabase();
final collectionName = "16 session";

class Session_16_PlanBloc extends Bloc<Session_16Event, session_16_PlanState> {
  Session_16_PlanBloc() : super(IinitialState()) {
    on<Session_16Event>((event, emit) async {
      if (event is AddUserEvent) {
        emit(LoadingState());
        final result = await dataSource.InsertUser(
            user: event.user, collectionName: collectionName);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data =
              await dataSource.RetriveData(collectionName: collectionName);
          data.isRight
              ? emit(SuccessState(users: data.right))
              : emit(ErrorState(error: data.left.message));
        }
      } else if (event is GetUsersEvent) {
        emit(LoadingState());
        final data =
            await dataSource.RetriveData(collectionName: collectionName);
        data.isRight
            ? emit(SuccessState(users: data.right))
            : emit(ErrorState(error: data.left.message));
      } else if (event is DeleteUserEvent) {
        emit(LoadingState());
        final result = await dataSource.DeleteUser(
            user: event.user, collectionName: collectionName);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data =
              await dataSource.RetriveData(collectionName: collectionName);
          data.isRight
              ? emit(SuccessState(users: data.right))
              : emit(ErrorState(error: data.left.message));
        }
      } else if (event is UpdateUserEvent) {
        emit(LoadingState());
        final result = await dataSource.UpdateUserData(
            user: event.user, collectionName: collectionName);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data =
              await dataSource.RetriveData(collectionName: collectionName);
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
