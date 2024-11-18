import 'package:flutter/material.dart';
import 'package:media_player_app/screens/home_screen.dart';
import 'package:media_player_app/screens/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'SplashScreen',
    routes:{
      '/': (context) => const HomeScreen(),
      'SplashScreen': (context) => const SplashScreen(),
    },
  ));
}