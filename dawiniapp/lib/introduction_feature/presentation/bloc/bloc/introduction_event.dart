// ignore_for_file: camel_case_types

part of 'introduction_bloc.dart';

sealed class IntroductionEvent extends Equatable {
  const IntroductionEvent();

  @override
  List<Object> get props => [];
}

class NextPage extends IntroductionEvent {
  final int id;

  const NextPage({required this.id});

  @override
  List<Object> get props => [id];
}

class onLanguageChoose extends IntroductionEvent {
  final String language;

  const onLanguageChoose({required this.language});
  @override
  List<Object> get props => [language];
}

class onTypeChoose extends IntroductionEvent {
  final String type;

  const onTypeChoose({required this.type});
  @override
  List<Object> get props => [type];
}
