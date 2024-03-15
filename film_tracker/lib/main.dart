import 'package:film_tracker/background_color.dart';
import 'package:film_tracker/controller/dependancy_injection.dart';
import 'package:film_tracker/firebase_options.dart';
import 'package:film_tracker/screens/home_screen.dart';
import 'package:film_tracker/screens/login_screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensures that widget binding is initialized. This is required before using any plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Firebase with the default options for the current platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// Retrieves shared preferences instance to check if the user is logged in
 SharedPreferences prefs = await SharedPreferences.getInstance();
 bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

 runApp(MyApp(isLoggedIn: isLoggedIn));
 DependancyInjection.init();
}

class MyApp extends StatelessWidget {

  // Whether the user is logged in or not
  final isLoggedIn;

  // Constructor for MyApp, requires the login status
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
        useMaterial3: true,
      ),
      // Displays the home screen if logged in, otherwise the login screen
      home: isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }
}
