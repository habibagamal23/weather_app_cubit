import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/weather_cubit.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: SearchBar(
            searchController: _searchController,
            onSearch: (data) => _submitSearch(context, data),
            onClear: () => _clearAndExit(context),
          ),
        ),
        body: FutureBuilder<List<String>>(
          future: BlocProvider.of<WeatherCubit>(context).getSearchHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final searchHistory = snapshot.data!;
              return ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.history, color: Colors.blue),
                    title: Text(searchHistory[index],
                        style: const TextStyle(color: Colors.black)),
                    onTap: () {
                      // When a search history item is tapped, fetch its weather data
                      BlocProvider.of<WeatherCubit>(context)
                          .getWeather(cityName: searchHistory[index]);
                      Navigator.pop(context); // Return to home screen
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text('No recent searches found.'));
            }
          },
        ),
      ),
    );
  }

  void _submitSearch(BuildContext context, String cityName) {
    if (cityName.isNotEmpty) {
      BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName);
      Navigator.pop(context); // Return to home screen
    }
  }

  void _clearAndExit(BuildContext context) {
    _searchController.clear(); // Clear the search input
    Navigator.pop(context); // Pop back to home screen
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final VoidCallback onClear;

  const SearchBar({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextField(
        controller: searchController,
        onSubmitted: onSearch,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search for a city',
          hintStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Colors.blue[800],
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: IconButton(
            icon: const Icon(Icons.cancel, color: Colors.white),
            onPressed: onClear,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
