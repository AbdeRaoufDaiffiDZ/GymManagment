import 'package:dawini_full/introduction_feature/data/repositoryImpl/itroduction_repository_impl.dart';
import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class SetLanguageUseCase {
  final IntroductionRepository repository = IntroductionRepositoryImpl();

  Future<String> execute(String language) {
    return repository.setLanguage(language);
  }
}
