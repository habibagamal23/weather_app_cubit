import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_test/features/model/weather_model.dart';
import '../../core/network_services/web_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WebService weatherService;

  WeatherCubit(this.weatherService) : super(WeatherInitial());

  WeatherModel? weatherModel;

  Future<void> getWeather(String cityName) async {
    emit(WeatherLoading());
    try {
      weatherModel = await weatherService.fetchWeather(cityName);
      emit(WeatherScuess(weatherModel!, cityName));
    } on DioError catch (dioError) {
      emit(WeatherFaliuere("Network issue: ${dioError.message}"));
    } catch (e) {
      emit(WeatherFaliuere("An unexpected error occurred: $e"));
    }
  }
}
