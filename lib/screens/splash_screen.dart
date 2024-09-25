import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash_logo.png',
            width: 270, 
            height: 270, 
          ),
          SizedBox(height: 5), 

          
          Text(
            'Movie Time',
            style: TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          ),
          SizedBox(height: 2), 

          
          Text(
            'Made by Rudraksh Gohil',
            style: TextStyle(
              fontSize: 10, 
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue.shade900,
      nextScreen: HomeScreen(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
      splashIconSize: 350, 
      animationDuration: Duration(milliseconds: 1500),
    );
  }
}
