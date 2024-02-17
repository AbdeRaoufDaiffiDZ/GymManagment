// ignore_for_file: void_checks

import 'package:bloc/bloc.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/usecases/doctor_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'doctor_auth_event.dart';
part 'doctor_auth_state.dart';

class DoctorAuthBloc extends Bloc<DoctorAuthEvent, DoctorAuthState> {
  DoctorAuthBloc() : super(DoctorAuthInitial()) {
    on<DoctorAuthEvent>((event, emit) async {
      if (event is onSignIn) {
        emit(DoctorAuthLoading());
        final response = await doctorAuthStateUseCase.signIn(
            event.email, event.password, event.context);
        response.fold((l) {
          emit(DoctorAuthFailed(error: l.message));
          showSnackBar(event.context,
              l.message); // Displaying the usual firebase error message
          emit(DoctorAuthInitial());
        }, (r) => emit(DoctorAuthSuccessful(doctorAuth: r)));
      } else if (event is onRegisterDoctor) {
        emit(DoctorAuthLoading());
        final response = await doctorAuthStateUseCase.registerDoctor(
            event.email, event.password, event.doctorData, event.context);
        response.fold((l) {
          emit(DoctorAuthFailed(error: l.message));
          showSnackBar(event.context,
              l.message); // Displaying the usual firebase error message
          emit(DoctorAuthInitial());
        }, (r) => emit(DoctorAuthSuccessful(doctorAuth: r)));
      } else if (event is onPasswordForget) {
        emit(DoctorAuthLoading());
        final response = await doctorAuthStateUseCase.forgetPassword(
            event.email, event.context);
        response.fold((l) {
          emit(DoctorAuthFailed(error: l.message));
          showSnackBar(event.context,
              l.message); // Displaying the usual firebase error message
          emit(DoctorAuthInitial());
        }, (r) => emit(DoctorPasswordReset()));
      } else if (event is onSignOutDoctor) {
        emit(DoctorAuthLoading());
        final response =
            await doctorAuthStateUseCase.signOutDoctor(event.context);
        response.fold((l) {
          emit(DoctorAuthFailed(error: l.message));
          showSnackBar(event.context,
              l.message); // Displaying the usual firebase error message
          emit(DoctorAuthInitial());
        }, (r) => emit(DoctorAuthDisconnect()));
      }
    });
  }
}
