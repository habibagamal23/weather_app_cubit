import 'package:dio/dio.dart';
import 'package:weather_app_test/features/model/weather_model.dart';

class WebService {
  Dio _dio = Dio();

  // Constructor to initialize interceptors
  WebService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("Request Path: ${options.path}");
          print("Request Method: ${options.method}");
          print("Request Query Params: ${options.queryParameters}");
          return handler.next(options); // Proceed to the next interceptor or the actual request
        },
        onResponse: (response, handler) {
          print("Response Status Code: ${response.statusCode}");
          return handler.next(response); // Proceed to the next interceptor
        },
        onError: (err, handler) {
          print('Error [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
          return handler.next(err); // Proceed to the next interceptor
        },
      ),
    );
  }

  // Your API key
  final String apiKey = "49a2ca78a7b7493f9b383424241909";

  // Function to fetch weather details
  Future<WeatherModel> fetchWeather(String cityName) async {
    // Use HTTPS instead of HTTP

    try {
      // Building the query parameters dynamically
      final resp = await _dio.get(
      'http://api.weatherapi.com/v1/forecast.json?key=5f384f5ab7594073b8d192145242509&q=$cityName&aqi=no'
      ,
      );

      // Print the whole response for debugging
      print("Response Data: ${resp.data}");

      // Check the response status code and process the data
      if (resp.statusCode == 200) {
        Map<String, dynamic> data = resp.data;
        WeatherModel weatherModel = WeatherModel.fromJson(data);
        return weatherModel;
      } else {
        // Handling error responses from the API
        throw Exception(resp.data["error"]["message"]);
      }
    } catch (e) {
      // Catching and throwing any network or request-related errors
      throw Exception("Failed to fetch weather: $e");
    }
  }
}
