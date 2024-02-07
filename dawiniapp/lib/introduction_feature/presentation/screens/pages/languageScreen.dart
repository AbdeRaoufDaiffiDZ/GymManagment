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
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            SizedBox(
              height: 0.05,
            ),
            MaterialButton(
              color: "Arabic" == widget.Language ? Colors.green : Colors.grey,
              onPressed: () {
                // Add the action you want to perform when the button is pressed
                // For example, you can show a dialog or navigate to another screen.
                bloc.add(onLanguageChoose(language: "Arabic"));
              },
              child: Text('Arabic'),
            ),
            MaterialButton(
              color: "English" == widget.Language ? Colors.green : Colors.grey,
              onPressed: () {
                // Add the action you want to perform when the button is pressed
                // For example, you can show a dialog or navigate to another screen.
                bloc.add(onLanguageChoose(language: "English"));
              },
              child: Text('English'),
            ),
            MaterialButton(
              color: "French" == widget.Language ? Colors.green : Colors.grey,
              onPressed: () {
                // Add the action you want to perform when the button is pressed
                // For example, you can show a dialog or navigate to another screen.
                bloc.add(onLanguageChoose(language: "French"));
              },
              child: Text('French'),
            ),
            SizedBox(height: 0.05), // Add spacing between text and button
            SizedBox(
              width: 0.5,
              child: ElevatedButton(
                onPressed: () {
                  // Add the action you want to perform when the button is pressed
                  // For example, you can show a dialog or navigate to another screen.
                  bloc.add(NextPage(id: 2));
                },
                child: Text('next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
