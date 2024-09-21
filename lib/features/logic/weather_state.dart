part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final Weather weather;
  final String cityname;

  WeatherSuccess(this.weather, this.cityname);
}

class WeatherFailure extends WeatherState {
  final String errorMessage;
  WeatherFailure(this.errorMessage);
}
