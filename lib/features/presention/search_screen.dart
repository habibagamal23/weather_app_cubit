import 'package:flutter/material.dart';

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
        body: Container()
      ),
    );
  }

  void _submitSearch(BuildContext context, String cityName) {

  }

  void _clearAndExit(BuildContext context) {
Navigator.pop(context);
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
