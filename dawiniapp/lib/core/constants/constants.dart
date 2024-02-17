class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'cc95d932d5a45d33a9527d5019475f2c';
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
  static String doctorInfoUrl() =>
      'https://dawini-cec17-default-rtdb.europe-west1.firebasedatabase.app/doctorsList/.json';

  static String clinicInfoUrl() =>
      'https://dawini-cec17-default-rtdb.europe-west1.firebasedatabase.app/clinics/.json';
}
