import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class IgnorIntroductionUseCase {
  final IntroductionRepository repository;

  IgnorIntroductionUseCase({required this.repository});

  Future<String> execute(bool status) {
    return repository.ignorIntroduction(status);
  }
}
