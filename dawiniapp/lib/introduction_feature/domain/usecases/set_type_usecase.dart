import 'package:dawini_full/introduction_feature/data/repositoryImpl/itroduction_repository_impl.dart';
import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class SetTypeUseCase {
  final IntroductionRepository repository = IntroductionRepositoryImpl();

  Future<String> execute(String type) {
    return repository.setType(type);
  }
}
