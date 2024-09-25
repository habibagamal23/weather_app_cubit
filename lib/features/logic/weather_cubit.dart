import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_test/features/model/weather_model.dart';

import '../../core/network_services/web_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  WebService weatherService = WebService();

  WeatherModel? weatherModel;
  String cityName = "";

  Future<void> getWeather(String cityName) async {
    emit(WeatherLoading());
    try {
      weatherModel = await weatherService.featchWeather(cityName);
      this.cityName = cityName;
      emit(WeatherScuess(weatherModel!, cityName));
    } catch (e) {
      emit(WeatherFaliuere("this error by : $e"));
    }
  }
}
