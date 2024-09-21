import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_test/features/presention/search_screen.dart';


import '../logic/weather_cubit.dart';
import '../model/weather_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: Padding(
              padding:
                  const EdgeInsets.only(top: 20), // Add more space from top
              child: const Text("Weather App"),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherSuccess) {
              Weather? weatherData = state.weather;
              return WeatherDisplayWidget(
                weatherData: weatherData!,
                cityName: state.cityname,
              );
            } else if (state is WeatherFailure) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Center(
                  child: Text('Enter a city name to fetch weather.'));
            }
          })),
    );
  }
}

class WeatherDisplayWidget extends StatelessWidget {
  final Weather weatherData;
  final String cityName;
  // Pass in the weather data

  const WeatherDisplayWidget(
      {Key? key, required this.weatherData, required this.cityName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 3,
        ),
        // City name fetched from Provider
        Text(
          '${cityName}',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Updated time
        Text(
          'updated at : ${weatherData.date.hour.toString()}:${weatherData.date.minute.toString()}',
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
        const Spacer(),
        // Weather data row: Image, temperature, max/min temp
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              weatherData.temp.toInt().toString(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                Text('maxTemp : ${weatherData.maxTemp.toInt()}'),
                Text('minTemp : ${weatherData.minTemp.toInt()}'),
              ],
            ),
          ],
        ),
        const Spacer(),
        // Weather state name
        Text(
          weatherData.weatherStateName,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }
}
