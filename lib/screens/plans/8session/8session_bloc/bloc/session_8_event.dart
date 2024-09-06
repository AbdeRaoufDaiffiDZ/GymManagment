import 'package:admin/entities/user_data_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class Session_8Event extends Equatable {}

class AddUserEvent extends Session_8Event {
  final User_Data user;
  final BuildContext context;
  AddUserEvent({required this.user, required this.context});

  @override
  List<Object?> get props => [user, context];
}

class GetUsersEvent extends Session_8Event {
  final BuildContext context;

  GetUsersEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class DeleteUserEvent extends Session_8Event {
  final User_Data user;
  final BuildContext context;

  DeleteUserEvent({required this.context, required this.user});

  @override
  List<Object?> get props => [user, context];
}

class UpdateUserEvent extends Session_8Event {
  final User_Data user;
  final BuildContext context;

  UpdateUserEvent({
    required this.context,
    required this.user,
  });

  @override
  List<Object?> get props => [
        user,context
      ];
}
