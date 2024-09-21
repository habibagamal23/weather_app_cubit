class Weather {
  DateTime date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;

  Weather(  {required this.date,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherStateName});



  factory Weather.fromJson(Map<String, dynamic> json) {

    var jsonData = json['forecast']['forecastday'][0]['day'];

    return Weather(
        date: DateTime.parse( json['current']['last_updated']),
        temp: jsonData['avgtemp_c'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        weatherStateName: jsonData['condition']['text']);
  }


}