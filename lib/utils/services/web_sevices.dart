import 'package:dio/dio.dart';

import '../../model/weather_model.dart';

class WebService {
  final Dio _dio = Dio();
  final String apiKey = "49a2ca78a7b7493f9b383424241909";
  final String baseUrl = 'http://api.weatherapi.com/v1';

  Future<Weather> fetchWeather(String cityName) async {
    try {
      final String url =
          'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$cityName&days=7';
      final response = await _dio.get(
        url,
      );
      if (response.statusCode == 200) {
        // Decode the JSON data and create a WeatherModel instance
        Map<String, dynamic> data = response.data;

        Weather weather = Weather.fromJson(data);
        return weather;
      } else {
        // Handle error responses, such as 400 Bad Request
        throw Exception(response.data['error']['message']);
      }
    } catch (e) {
      // Handle network or other errors
      throw Exception('Failed to load weather: $e');
    }
  }
}
