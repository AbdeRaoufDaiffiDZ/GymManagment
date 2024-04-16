// ignore_for_file: no_logic_in_create_state

import 'package:dawini_full/auth/presentation/welcomePage.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages/localization.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages/typeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/myApp.dart';

class PagesShower extends StatefulWidget {
  final int fontSize;
  final int? pageNumber;
  final String? uid;
  const PagesShower({
    super.key,
    this.uid,
    required this.fontSize,
    this.pageNumber,
  });

  @override
  State<PagesShower> createState() => _PagesShowerState(uid: uid);
}

class _PagesShowerState extends State<PagesShower> {
  final String? uid;

  _PagesShowerState({required this.uid});
  @override
  Widget build(BuildContext context) {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);

    return BlocBuilder<IntroductionBloc, IntroductionState>(
      builder: (context, state) {
        if (state is LanguageState) {
          return Localisation(languageSys: state.language);
        } else if (state is TypeState) {
          return UserTypeSelector(
            type: state.type,
          );
        } else if (state is LoadingState) {
          return const Loading();
        } else if (state is IgnoreIntorductionState) {
          if (state.Screen == 'doctor') {
            if (uid == null) {
              return doctorsideHome(fontSize: widget.fontSize);
            } else {
              return WelcomePage(fontSize: widget.fontSize);
            }
            /////////////////////////////////////    here you will go to patients screen
          } else {
            return Mypage(
              fontSize: widget.fontSize,
              popOrNot: false,
            );
          }
        } else {
          if (widget.pageNumber != null) {
            bloc.add(NextPage(id: widget.pageNumber!));
          } else {
            bloc.add(const NextPage(id: 1));
          }

          return const Center();
        }
      },
    );
  }

  Future<bool> chack() async {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);
    final status = await bloc.checkWatchingStatusUseCase.execute();
    return status;
  }
}
