import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/models/show.dart';
import 'package:movie_app/widgets/show_card.dart';
import 'package:movie_app/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Show> shows = [];
  bool isLoading = true;
  bool hasError = false;


  bool showBanner = true;

  @override
  void initState() {
    super.initState();
    fetchShows();
  }


  Future<void> fetchShows() async {
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all')); // Fetch all shows
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          shows = data.map((item) => Show.fromJson(item['show'])).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Column(
        children: [

          if (showBanner)
            MaterialBanner(
              backgroundColor: Colors.blue.shade200,
              content: Text(
                "Can't find it? Search it!",
                style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      showBanner = false;
                    });
                  },
                  child: Text(
                    'DISMISS',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                ),
              ],
            ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : hasError
                ? Center(
              child: Text(
                'Failed to load shows. Please try again.',
                style: TextStyle(color: Colors.red),
              ),
            )
                : RefreshIndicator(
              onRefresh: fetchShows,
              child: ListView.builder(
                itemCount: shows.length,
                itemBuilder: (context, index) {
                  return ShowCard(show: shows[index]);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade900,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blue.shade200,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
