import 'package:film_tracker/background_color.dart';
import 'package:film_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Film Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}