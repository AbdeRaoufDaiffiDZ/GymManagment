// ignore_for_file: file_names, non_constant_identifier_names, duplicate_ignore

import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageScreen extends StatefulWidget {
  final String Language;
  // ignore: non_constant_identifier_names
  const LanguageScreen({
    super.key,
    required this.Language,
  });

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<IntroductionBloc, IntroductionState>(
                builder: (context, state) {
              // String language;
              // if (state is LanguageState) {
              //   language = state.language;
              // } else {
              //   language = widget.Language;
              // }
              return Text(
                // language,
                widget.Language,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            const SizedBox(
              height: 0.05,
            ),
            MaterialButton(
              color: "Arabic" == widget.Language ? Colors.green : Colors.grey,
              onPressed: () {
                // Add the action you want to perform when the button is pressed
                // For example, you can show a dialog or navigate to another screen.
                bloc.add(const onLanguageChoose(language: "Arabic"));
              },
              child: const Text('Arabic'),
            ),
            MaterialButton(
              color: "English" == widget.Language ? Colors.green : Colors.grey,
              onPressed: () {
                // Add the action you want to perform when the button is pressed
                // For example, you can show a dialog or navigate to another screen.
                bloc.add(const onLanguageChoose(language: "English"));
              },
              child: const Text('English'),
            ),
            MaterialButton(
              color: "French" == widget.Language ? Colors.green : Colors.grey,
              onPressed: () {
                // Add the action you want to perform when the button is pressed
                // For example, you can show a dialog or navigate to another screen.
                bloc.add(const onLanguageChoose(language: "French"));
              },
              child: const Text('French'),
            ),
            const SizedBox(height: 0.05), // Add spacing between text and button
            SizedBox(
              width: 0.5,
              child: ElevatedButton(
                onPressed: () {
                  // Add the action you want to perform when the button is pressed
                  // For example, you can show a dialog or navigate to another screen.
                  bloc.add(const NextPage(id: 2));
                },
                child: const Text('next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
