import 'package:equatable/equatable.dart';

class IntroductionEntity extends Equatable {
  final String language;
  final String whoAreYou;
  final bool isShowed;

  const IntroductionEntity(
      {this.language = 'English',
      required this.whoAreYou,
      this.isShowed = false});

  @override
  // TODO: implement props
  List<Object?> get props => [language, whoAreYou, isShowed];
}
