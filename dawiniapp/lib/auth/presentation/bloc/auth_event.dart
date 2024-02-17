import 'dart:async';
import 'dart:developer' as developer;

import 'package:dawini_full/auth/presentation/bloc/auth_bloc.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_state.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {
  Stream<AuthState> applyAsync({AuthState currentState, AuthBloc bloc});
}

class UnAuthEvent extends AuthEvent {
  @override
  Stream<AuthState> applyAsync(
      {AuthState? currentState, AuthBloc? bloc}) async* {
    yield UnAuthState();
  }
}

class LoadAuthEvent extends AuthEvent {
  @override
  Stream<AuthState> applyAsync(
      {AuthState? currentState, AuthBloc? bloc}) async* {
    try {
      yield UnAuthState();
      await Future.delayed(const Duration(seconds: 1));
      yield InAuthState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadAuthEvent', error: _, stackTrace: stackTrace);
      yield ErrorAuthState(_.toString());
    }
  }
}
