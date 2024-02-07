import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class SetLanguageUseCase {
  final IntroductionRepository repository;

  SetLanguageUseCase({required this.repository});

  Future<String> execute(String language) {
    return repository.setLanguage(language);
  }
}
