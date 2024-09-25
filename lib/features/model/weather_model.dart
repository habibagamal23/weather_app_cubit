class WeatherModel {
  DateTime date;
  double temp;
  double maxtemp;
  double mintemp;
  String weathercondion;

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxtemp,
      required this.mintemp,
      required this.weathercondion});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    var jsonefromcastday = json['forecast']["forecastday"][0]["day"];

    return WeatherModel(
        date: DateTime.parse(json["current"]["last_updated"]),
        temp: jsonefromcastday["avgtemp_c"],
        maxtemp: jsonefromcastday["maxtemp_c"],
        mintemp: jsonefromcastday['mintemp_c'],
        weathercondion: jsonefromcastday["condition"]["text"]);
  }
}
