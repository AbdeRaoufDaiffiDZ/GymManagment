import 'dart:async';

import 'package:admin/screens/plans/12sess/12session_bloc/bloc/session_12_event.dart';
import 'package:admin/data/mongo_db.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '12session_state.dart';

final MongoDatabase dataSource = MongoDatabase();
final collectionName = "12 session";

class Session_12_PlanBloc extends Bloc<Session_12Event, session_12_PlanState> {
  Session_12_PlanBloc() : super(IinitialState()) {
    on<Session_12Event>((event, emit) async {
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
