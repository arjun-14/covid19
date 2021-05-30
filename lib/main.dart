import 'package:covid19/screens/home.dart';
import 'package:flutter/material.dart';
import 'screens/homeScreen.dart';
import 'screens/essentialScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        EssentialScreen.id: (context) => EssentialScreen(),
      },
      home: HomeScreen(),
      theme: ThemeData.dark().copyWith(
        canvasColor: Color(0xFF222237),
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF222237),
      ),
    );
  }
}
