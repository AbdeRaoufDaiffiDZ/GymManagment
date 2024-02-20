import 'package:dawini_full/introduction_feature/data/data_source/local_data_source.dart';
import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';

class IntroductionRepositoryImpl implements IntroductionRepository {
  final LocalDataSource dataSource;

  IntroductionRepositoryImpl({required this.dataSource});
  @override
  Future<bool> isWatched() {
    return dataSource.isWatched();
  }

  @override
  Stream<String> choosenLanguage() {
    return dataSource.choosenLanguage();
  }

  @override
  Stream<String> getType() {
    return dataSource.getType();
  }

  @override
  Future<String> ignorIntroduction(bool status) {
    return dataSource.ignorIntroduction(status);
  }

  @override
  Future<String> setLanguage(String language) {
    return dataSource.setLanguage(language);
  }

  @override
  Future<String> setType(String type) {
    return dataSource.setType(type);
  }
}
