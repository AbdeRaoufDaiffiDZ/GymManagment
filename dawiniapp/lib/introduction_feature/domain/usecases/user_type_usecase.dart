import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class UserTypeUseCase {
  final IntroductionRepository repository;

  UserTypeUseCase({required this.repository});
  Stream<String> execute() {
    return repository.getType();
  }
}
