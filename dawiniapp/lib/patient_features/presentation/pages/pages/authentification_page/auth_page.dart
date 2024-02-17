// ignore_for_file: non_constant_identifier_names

import 'package:dawini_full/patient_features/presentation/bloc/auth_bloc/bloc/doctor_auth_bloc.dart';
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
          child: BlocBuilder<DoctorAuthBloc, DoctorAuthState>(
              builder: (context, state) {
            if (state is DoctorAuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DoctorAuthSuccessful) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("hello"),
                ),
              );
            }
            if (state is DoctorAuthInitial) {
              return LoginScreen(context);
            }
            if (state is DoctorAuthFailed) {
              return LoginScreen(context,
                  showSnackBar: true, message: state.error);
            }
            return Container();
          }),
        ));
  }
}

Widget LoginScreen(context, {showSnackBar = false, message = ''}) {
  final DoctorAuthBloc authBloc = BlocProvider.of<DoctorAuthBloc>(context);
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
              final email = emailController.text;
              final password = passwordController.text;
              authBloc.add(
                  onSignIn(email: email, password: password, context: context));
            },
            child: const Text('Login'),
          ),
        ],
      ),
    ),
  );
}
