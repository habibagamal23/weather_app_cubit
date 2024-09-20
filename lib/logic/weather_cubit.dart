import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/weather_model.dart';
import '../utils/services/web_sevices.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  final WebService _weatherService =
      WebService();

  Weather? weatherModel;
  String cityName ='';

  Future<void> getWeather({required String cityName}) async {
    emit(WeatherLoading()); // Emit loading state

    try {
      // Fetch weather data using the instantiated WeatherService
      weatherModel = await _weatherService.fetchWeather(cityName);
      this.cityName = cityName;
      emit(WeatherSuccess()); // Emit success state with data
    } catch (e) {
      emit(WeatherFailure()); // Emit failure state
    }
  }
}
