import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<bool> isWatched();

  Future<String> ignorIntroduction(bool ignore);
  Future<String> setLanguage(String language);
  Stream<String> choosenLanguage();

  Future<String> setType(String type);
  Stream<String> getType();
}

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences prefs;

  LocalDataSourceImpl({required this.prefs});

  @override
  Future<bool> isWatched() async {
    final bool? status = prefs.getBool('ignore');
    if (status == null) {
      return false;
    } else {
      return status;
    }
  }

  @override
  Future<String> ignorIntroduction(bool ignore) async {
    try {
      prefs.setBool('ignore', ignore);
      return 'ignore done';
    } catch (e) {
      throw 'error when setting ignore';
    }
  }

  @override
  Future<String> setLanguage(String language) async {
    try {
      prefs.setString('language', language);
      return 'lanuage setting done';
    } catch (e) {
      throw 'error when setting language';
    }
  }

  @override
  Stream<String> choosenLanguage() async* {
    final String? status = prefs.getString('language');
    if (status == null) {
      yield 'English';
    } else {
      yield status;
    }
  }

  @override
  Future<String> setType(String type) async {
    try {
      prefs.setString('type', type);
      return 'type setting done';
    } catch (e) {
      throw 'error when setting type';
    }
  }

  @override
  Stream<String> getType() async* {
    final String? status = prefs.getString('type');
    if (status == null) {
      yield 'noon';
    } else {
      yield status;
    }
  }
}
