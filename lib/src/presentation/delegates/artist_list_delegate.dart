import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class ArtistsSearchDelegate extends SearchDelegate {
  ArtistsSearchDelegate({super.searchFieldLabel});

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
    return ArtistListView(
      ofSearch: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ArtistListView(
      ofSearch: query,
    );
  }
}
