import 'package:dawini_full/auth/presentation/bloc/auth_bloc.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_state.dart';
import 'package:dawini_full/auth/presentation/loginPage.dart';
import 'package:dawini_full/auth/presentation/signup.dart';
import 'package:dawini_full/auth/presentation/welcomePage.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBlocMap extends StatefulWidget {
  final int fontSize;

  const AuthBlocMap({super.key, required this.fontSize});

  @override
  State<AuthBlocMap> createState() => _AuthBlocMapState();
}

class _AuthBlocMapState extends State<AuthBlocMap> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoginState) {
          return LoginPage(fontSize: widget.fontSize);
        } else if (state is SuccessasfulLogin) {
          return doctorsideHome(
            fontSize: widget.fontSize,
          );
        } else if (state is LoadAuthState) {
          return const Loading();
        } else if (state is ErrorAuthState) {
          return LoginPage(error: state.error, fontSize: widget.fontSize);
        } else if (state is RegisterState) {
          return SignUpPage(fontSize: widget.fontSize);
        } else if (state is ResetPassSatate) {}
        return Container();
      },
    );
  }

  showDialogBox(error) => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text("Error when trying to login"),
            content: Text(error),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Ok'))
            ],
          ));
}
