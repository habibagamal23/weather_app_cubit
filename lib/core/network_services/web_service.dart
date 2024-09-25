import 'package:dio/dio.dart';
import 'package:weather_app_test/features/model/weather_model.dart';

class WebService {
  Dio _dio = Dio();
  WebService() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print("Req : ${options.path}");
      print("Req : ${options.method}");
      print("Req : ${options.queryParameters}");
    }, onResponse: (res, handler) {
      print("Req : ${res.statusCode}");
      return handler.next(res);
    },
    onError:  (err, handler){
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return handler.next(err);
    }
    ));
  }

  final String key = "49a2ca78a7b7493f9b383424241909";

  Future<WeatherModel> featchWeather(String cityName) async {
    final String base_url = 'http://api.weatherapi.com/v1/forecast.json?key=49a2ca78a7b7493f9b383424241909&q=cairo&days=1';

    try {
      final resp = await _dio.get(base_url);
      print(resp);

      if (resp.statusCode == 200) {
        Map<String, dynamic> datresp = resp.data;
        WeatherModel wethmodel = WeatherModel.fromJson(datresp);
        return wethmodel;
      } else {
        throw Exception(resp.data["error"]["message"]);
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}
