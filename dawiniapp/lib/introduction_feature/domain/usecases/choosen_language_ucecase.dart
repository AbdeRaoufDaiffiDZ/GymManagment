import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class ChossenLanguageUseCase {
  final IntroductionRepository repository;

  ChossenLanguageUseCase({required this.repository});

  Stream<String> execute() {
    return repository.choosenLanguage();
  }
}
