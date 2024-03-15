import 'package:film_tracker/screens/login_screens/login_screen.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {

  // Constructor for ProfileScreen
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Retrieves the current user from Firebase Authentication
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 0, 0, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              // logo
              const Icon(
                Icons.person,
                size: 100,
              ),

              const SizedBox(height: 100),

              // Display the user's email
              Text(
                user?.email ?? 'No email found',
                style: TextStyle(fontSize: 24),
              ),

              const SizedBox(height: 25),
              
              // Sign out button
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    SharedPreferences.getInstance().then((prefs) {
                    prefs.setBool('isLoggedIn', false);// Sets 'isLoggedIn' to false
                    });
                    print("Logged Out");
                    // Navigates to the login screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  });
                },
                child: const Text('Sign Out'),
              ),

            ],
          ),
        ),
      ),
      //bottom app bar
      bottomNavigationBar: bottomAppBar(context: context),
    );
  }
}
