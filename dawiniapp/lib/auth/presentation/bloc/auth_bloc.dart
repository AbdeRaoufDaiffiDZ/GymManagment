// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dawini_full/auth/domain/usecases/auth_usecase.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_event.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  DoctorAuthStateUseCase authStateUseCase = DoctorAuthStateUseCase();
  AuthBloc(super.initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is onLoginEvent) {
        emit(LoadAuthState());
        final result = await authStateUseCase.signIn(event.data);
        result.fold((l) {
          // showSnackBar(event.context, l.message);
          emit(ErrorAuthState(error: l.message));
        }, (r) => emit(SuccessasfulLogin()));
      } else if (event is onRegisterEvent) {
        emit(LoadAuthState());
        final result =
            await authStateUseCase.registerDoctor(event.data, event.doctorData);
        result.fold((l) {
          // showSnackBar(event.context, l.message);
          emit(ErrorAuthState(error: l.message));
        }, (r) => emit(LoginState()));
      } else if (event is onResetPassEvent) {
        emit(LoadAuthState());
        final result = await authStateUseCase.forgetPassword(event.data);
        result.fold((l) {
          {
            // showSnackBar(event.context, l.message);
            emit(ErrorAuthState(error: l.message));
          }
        }, (r) => emit(LoginState()));
      }
    });
  }
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
