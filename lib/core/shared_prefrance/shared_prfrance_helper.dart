import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const String citiesKey = 'cities';

  Future<void> setCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searchHistory = prefs.getStringList(citiesKey) ?? [];
    if (!searchHistory.contains(cityName)) {
      searchHistory.add(cityName);
      await prefs.setStringList(citiesKey, searchHistory);
    }
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(citiesKey) ?? [];
  }
}
