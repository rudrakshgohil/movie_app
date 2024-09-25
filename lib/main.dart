import 'package:flutter/material.dart';
import 'package:movie_app/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Define a custom theme
  final ThemeData theme = ThemeData(
    primaryColor: Colors.blue.shade900,
    hintColor: Colors.blue.shade700,
    scaffoldBackgroundColor: Colors.blue.shade50,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade900,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.blue.shade900),
      bodyMedium: TextStyle(color: Colors.blue.shade800),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SplashScreenPage(),
    );
  }
}
