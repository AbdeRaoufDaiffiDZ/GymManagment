// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_event.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState) {
    on<AuthEvent>((event, emit) {});
  }
}
