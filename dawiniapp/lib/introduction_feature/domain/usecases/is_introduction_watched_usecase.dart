import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class IsIntroductionWatchedUseCase {
  final IntroductionRepository repository;

  IsIntroductionWatchedUseCase({required this.repository});
  Future<bool> execute() {
    return repository.isWatched();
  }
}
