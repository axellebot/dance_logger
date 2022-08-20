import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class DancesSearchDelegate extends SearchDelegate {
  DancesSearchDelegate({super.searchFieldLabel});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return DanceListView(
      ofSearch: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return DanceListView(
      ofSearch: query,
    );
  }
}
