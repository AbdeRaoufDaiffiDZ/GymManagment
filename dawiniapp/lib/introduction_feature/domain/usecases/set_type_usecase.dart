import 'package:dawini_full/introduction_feature/data/data_source/local_data_source.dart';
import 'package:dawini_full/introduction_feature/data/repositoryImpl/itroduction_repository_impl.dart';
import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class SetTypeUseCase {
  final IntroductionRepository repository =
      IntroductionRepositoryImpl(dataSource: LocalDataSourceImpl());

  Future<String> execute(String type) {
    return repository.setType(type);
  }
}
