import 'package:film_tracker/background_color.dart';
import 'package:film_tracker/firebase_options.dart';
import 'package:film_tracker/screens/home_screen.dart';
import 'package:film_tracker/screens/login_screens/login_screen.dart';
import 'package:film_tracker/screens/login_screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
