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
  final DoctorAuthStateUseCase doctorAuthStateUseCase;
  DoctorAuthBloc(this.doctorAuthStateUseCase) : super(DoctorAuthInitial()) {
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

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void showOTPDialog({
    required BuildContext context,
    required TextEditingController codeController,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Enter OTP"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: codeController,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: const Text("Done"),
          )
        ],
      ),
    );
  }
}
