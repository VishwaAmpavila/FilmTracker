import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
 final Function(BuildContext)? onTap;

// Constructor for MyButton, requires the onTap function
 const MyButton({super.key, required this.onTap});

 @override
 Widget build(BuildContext context) {
  // Returns a GestureDetector that calls the onTap function when tapped
    return GestureDetector(
      onTap: () => onTap!(context),
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 59, 58, 58),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
 }
}