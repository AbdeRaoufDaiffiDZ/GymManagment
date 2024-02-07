import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class SetTypeUseCase {
  final IntroductionRepository repository;

  SetTypeUseCase({required this.repository});
  Future<String> execute(String type) {
    return repository.setType(type);
  }
}
