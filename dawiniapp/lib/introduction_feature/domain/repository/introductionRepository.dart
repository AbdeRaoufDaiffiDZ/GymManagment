// ignore_for_file: file_names

abstract class IntroductionRepository {
  Future<bool> isWatched();
  Future<String> ignorIntroduction(bool status);

  Future<String> setLanguage(String language);
  Stream<String> choosenLanguage();

  Future<String> setType(String type);
  Stream<String> getType();
}
