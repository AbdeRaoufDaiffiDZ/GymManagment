class Failure {
  final String message;
  final String key;

  Failure({required this.message, required this.key});
}

class AppError {
  static const String SettingDataError = 'SettingDataError';
  static const String NotFound = 'NotFound';
  static const String DelettingUserError = 'DelettingUserError';
}
