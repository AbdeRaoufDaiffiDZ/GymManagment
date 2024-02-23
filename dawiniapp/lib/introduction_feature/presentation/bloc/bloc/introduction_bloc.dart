// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/check_status_is_watched_usecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/choosen_language_ucecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/ignore_intoduction_usecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/is_introduction_watched_usecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/set_language_usecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/set_type_usecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/user_type_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'introduction_event.dart';
part 'introduction_state.dart';

class IntroductionBloc extends Bloc<IntroductionEvent, IntroductionState> {
  final CheckWatchingStatusUseCase checkWatchingStatusUseCase;
  final ChossenLanguageUseCase chossenLanguageUseCase;
  final UserTypeUseCase userTypeUseCase;
  final SetLanguageUseCase setLanguageUseCase;
  final SetTypeUseCase setTypeUseCase;
  final IgnorIntroductionUseCase ignorIntroductionUseCase;
  final IsIntroductionWatchedUseCase isIntroductionWatchedUseCase;

  IntroductionBloc(
      this.checkWatchingStatusUseCase,
      this.chossenLanguageUseCase,
      this.userTypeUseCase,
      this.setLanguageUseCase,
      this.setTypeUseCase,
      this.ignorIntroductionUseCase,
      this.isIntroductionWatchedUseCase)
      : super(WelcomeState()) {
    on<IntroductionEvent>((event, emit) async {
      if (event is NextPage) {
        switch (event.id) {
          case 0:
            emit(WelcomeState());
            break;
          case 1:
            String languageData = '';
            chossenLanguageUseCase.execute().listen((language) {
              languageData = language;
            });
            emit(LanguageState(language: languageData));
            break;
          case 2:
            String Screen = '';

            userTypeUseCase.execute().listen((screen) {
              Screen = screen;
              if (kDebugMode) {
                print(screen);
              }
            });
            emit(TypeState(type: Screen));

            break;

          default:
            await ignorIntroductionUseCase
                .execute(true); ///// will be changed later
            String Screen = '';

            userTypeUseCase.execute().listen((screen) {
              Screen = screen;
            });
            emit(IgnoreIntorductionState(Screen: Screen));
        }
      } else if (event is onLanguageChoose) {
        final result = await setLanguageUseCase.execute(event.language);
        if (kDebugMode) {
          print(result);
        }
        emit(LanguageState(language: event.language));
      } else if (event is onTypeChoose) {
        await setTypeUseCase.execute(event.type);
        emit(TypeState(type: event.type));
      }
    });
  }
}
