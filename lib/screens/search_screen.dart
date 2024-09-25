import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/models/show.dart';
import 'package:movie_app/widgets/show_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Show> searchResults = [];
  bool isLoading = false;
  bool hasError = false;
  TextEditingController searchController = TextEditingController();

  Future<void> searchShows(String query) async {
    if (query.isEmpty) return;
    setState(() {
      isLoading = true;
      hasError = false;
    });
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          searchResults = data.map((item) => Show.fromJson(item['show'])).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error searching shows: $e');
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  Widget _buildSearchResults() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (hasError) {
      return Center(
        child: Text(
          'Failed to load search results. Please try again.',
          style: TextStyle(color: Colors.red),
        ),
      );
    } else if (searchResults.isEmpty) {
      return Center(child: Text('No results found.'));
    } else {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ShowCard(show: searchResults[index]);
        },
      );
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    searchShows(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search for shows...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white54),
          ),
          style: TextStyle(color: Colors.white, fontSize: 18),
          textInputAction: TextInputAction.search,
          onSubmitted: _onSearchSubmitted,
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: _buildSearchResults(),
    );
  }
}
