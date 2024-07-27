enum AppError {
  NotFound, SettingDataError, DelettingUserError
  // some errors codes
}

class Failure {
  final AppError key;
  final String message;

  const Failure({
    required this.key, 
    required this.message,
  });
}