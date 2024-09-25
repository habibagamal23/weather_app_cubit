import 'package:dio/dio.dart';
import 'package:weather_app_test/features/model/weather_model.dart';

class WebService {
  Dio _dio = Dio();

  Future<WeatherModel> fetchWeather(String cityName) async {
    try {
      final resp = await _dio.get(
        'http://api.weatherapi.com/v1/forecast.json?key=5f384f5ab7594073b8d192145242509&q=$cityName&aqi=no',
      );
      print("Response Data: ${resp.data}");
      if (resp.statusCode == 200) {
        Map<String, dynamic> data = resp.data;
        WeatherModel weatherModel = WeatherModel.fromJson(data);
        return weatherModel;
      } else {
        throw Exception(resp.data["error"]["message"]);
      }
    } catch (e) {
      throw Exception("Failed to fetch weather: $e");
    }
  }
}
