import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onQueryChanged;
  final String query;
  const SearchWidget(
      {super.key, required this.onQueryChanged, required this.query});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(text: query);

    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        onQueryChanged(value);
      },
    );
  }
}
