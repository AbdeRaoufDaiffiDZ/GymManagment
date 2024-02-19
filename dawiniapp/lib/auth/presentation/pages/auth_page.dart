// ignore_for_file: non_constant_identifier_names

import 'package:dawini_full/auth/domain/entity/auth_entity.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_bloc.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_event.dart';
import 'package:dawini_full/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctgorAuthPage extends StatelessWidget {
  const DoctgorAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.all(1),
          color: Colors.white,
          child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is LoadAuthState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SuccessasfulLogin) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("hello"),
                ),
              );
            }
            if (state is LoginState) {
              return LoginScreen(context);
            }
            if (state is ErrorAuthState) {
              return LoginScreen(context,
                  showSnackBar: true, message: state.error);
            }
            return Container();
          }),
        ));
  }
}

Widget LoginScreen(context, {showSnackBar = false, message = ''}) {
  final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  if (showSnackBar) {
    print("error");
  }
  return Scaffold(
    appBar: AppBar(
      title: const Text('Login Page'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final AuthEntity data = AuthEntity(
                  email: emailController.text,
                  password: passwordController.text);

              authBloc.add(onLoginEvent(context: context, data: data));
            },
            child: const Text('Login'),
          ),
        ],
      ),
    ),
  );
}
