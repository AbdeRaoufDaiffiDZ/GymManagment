import 'package:admin/entities/user_data_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class Session_8Event extends Equatable {}

class AddUserEvent extends Session_8Event {
  final User_Data user;

  AddUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetUsersEvent extends Session_8Event {
  @override
  List<Object?> get props => [];
}

class DeleteUserEvent extends Session_8Event {
  final User_Data user;

  DeleteUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserEvent extends Session_8Event {
  final User_Data user;

  UpdateUserEvent({
    required this.user,
  });

  @override
  List<Object?> get props => [
        user,
      ];
}
