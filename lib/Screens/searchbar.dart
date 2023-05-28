import 'package:flutter/material.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  static const String screenId = 'search';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [      IconButton(        icon: Icon(Icons.clear),        onPressed: () {          query = '';        },      )    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    // Implement the search functionality and return the results.
    List<String> results = ['Result 1', 'Result 2', 'Result 3'];
    List<String> filteredResults = results
        .where((result) => result.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(filteredResults[index]),
        onTap: () {
          close(context, filteredResults[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Provide suggestions based on the user's query.
    List<String> suggestions = ['Suggestion 1', 'Suggestion 2', 'Suggestion 3'];
    List<String> filteredSuggestions = suggestions
        .where((suggestion) =>
        suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(filteredSuggestions[index]),
        onTap: () {
          query = filteredSuggestions[index];
        },
      ),
    );
  }
}
