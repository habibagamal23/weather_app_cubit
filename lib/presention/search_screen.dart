import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_test/logic/weather_cubit.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
            backgroundColor: Colors.blue,
            automaticallyImplyLeading:
                false,
            centerTitle: true,// To remove the default back button
            title: Text("Search")),
        body: Center(child: Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onSubmitted: (data) {
              if (data.isNotEmpty) {
                // Fetch the weather data and handle city name in the cubit
                BlocProvider.of<WeatherCubit>(context)
                    .getWeather(cityName: data);
                Navigator.pop(context); // Pop back to HomeScreen
              }
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search for a city',
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.grey[800],
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              suffixIcon: IconButton(
                icon: const Icon(Icons.cancel, color: Colors.white),
                onPressed: () {
                  _searchController.clear(); // Clear the search field
                  Navigator.pop(context); // Pop back to HomeScreen
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        )), // Body can be extended later
      ),
    );
  }
}
