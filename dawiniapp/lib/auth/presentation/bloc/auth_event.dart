// ignore_for_file: depend_on_referenced_packages, camel_case_types

import 'package:dawini_full/auth/domain/entity/auth_entity.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent {}

class onLoginEvent extends AuthEvent {
  final AuthEntity data;
  final BuildContext context;

  onLoginEvent({required this.context, required this.data});
}

class onRegisterEvent extends AuthEvent {
  final AuthEntity data;
  final DoctorEntity doctorData;
  final BuildContext context;

  onRegisterEvent(
      {required this.context, required this.data, required this.doctorData});
}

class onResetPassEvent extends AuthEvent {
  final AuthEntity data;
  final BuildContext context;

  onResetPassEvent({required this.context, required this.data});
}
