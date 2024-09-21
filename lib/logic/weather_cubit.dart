import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/weather_model.dart';
import '../utils/services/web_sevices.dart';
import '../utils/shared_prfrance_helper.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  final WebService _weatherService = WebService();
  final SearchHistoryService shared = SearchHistoryService();

  Weather? weather;
  String cityName = '';
  List<String> lastCities = [];

  Future<void> getWeather({required String cityName}) async {
    emit(WeatherLoading());
    try {
      weather = await _weatherService.fetchWeather(cityName);
      this.cityName = cityName;
      await shared.setCity(cityName);
      emit(WeatherSuccess(weather!, cityName));
    } catch (e) {
      emit(WeatherFailure("Failed to fetch weather data $e"));
    }
  }

  Future<List<String>> getSearchHistory() async {
    return await shared.getSearchHistory();
  }
}
