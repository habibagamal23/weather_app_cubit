class WeatherModel {
  DateTime date;
  double temp;
  double maxtemp;
  double mintemp;
  String weathercondion;

  WeatherModel({
    required this.date,
    required this.temp,
    required this.maxtemp,
    required this.mintemp,
    required this.weathercondion,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {

    var jsonefromcastday = json['forecast']["forecastday"][0]["day"];
    return WeatherModel(
      date: DateTime.parse(json["current"]["last_updated"] ?? DateTime.now().toIso8601String()),
      temp: jsonefromcastday["avgtemp_c"] ?? 0.0,
      maxtemp: jsonefromcastday["maxtemp_c"] ?? 0.0,
      mintemp: jsonefromcastday['mintemp_c'] ?? 0.0,
      weathercondion: jsonefromcastday["condition"]?["text"] ?? "Unknown",
    );
  }
}
