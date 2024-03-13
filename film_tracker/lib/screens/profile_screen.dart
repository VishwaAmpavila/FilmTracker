import 'package:film_tracker/screens/login_screens/login_screen.dart';
import 'package:film_tracker/screens/login_screens/sign_up.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

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
              
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Logged Out");
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
      bottomNavigationBar: bottomAppBar(context: context),
    );
  }
}
