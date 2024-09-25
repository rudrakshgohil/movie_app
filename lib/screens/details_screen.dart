import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/models/show.dart';

class DetailsScreen extends StatelessWidget {
  final Show show;

  DetailsScreen({required this.show});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          show.name,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: show.image ?? 'https://via.placeholder.com/300',
                  width: 300,
                  height: 450,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 300,
                    height: 450,
                    color: Colors.grey.shade300,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error, size: 100),
                ),
              ),
              SizedBox(height: 16),
              Text(
                show.name,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              ),
              SizedBox(height: 8),
              Text(
                'Premiered: ${show.premiered}',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade700),
              ),
              SizedBox(height: 8),
              Text(
                'Language: ${show.language}',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade700),
              ),
              SizedBox(height: 8),
              Text(
                'Genres: ${show.genres.join(', ')}',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade700),
              ),
              SizedBox(height: 16),
              Text(
                'Summary',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              ),
              SizedBox(height: 8),
              Text(
                _removeHtmlTags(show.summary),
                style: TextStyle(fontSize: 16, color: Colors.blue.shade800),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _removeHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}
