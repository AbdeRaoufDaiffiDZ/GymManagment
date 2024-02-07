import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class CheckWatchingStatusUseCase {
  final IntroductionRepository repository;

  CheckWatchingStatusUseCase({required this.repository});
  Future<bool> execute() {
    return repository.isWatched();
  }
}
