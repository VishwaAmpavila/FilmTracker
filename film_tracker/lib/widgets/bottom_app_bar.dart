import 'package:film_tracker/screens/home_screen.dart';
import 'package:film_tracker/screens/profile_screen.dart';
import 'package:film_tracker/screens/search_screen.dart';
import 'package:film_tracker/screens/watch_later/watchlater_movie_screen.dart';
import 'package:film_tracker/screens/watched/watched_movie_screen.dart';
import 'package:flutter/material.dart';

class bottomAppBar extends StatelessWidget {
 final BuildContext context;

 const bottomAppBar({Key? key, required this.context}) : super(key: key);

 @override
 Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color.fromRGBO(25, 26, 30, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          
          IconButton(
            icon: Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              Navigator.push(
                this.context, 
                MaterialPageRoute(builder: (context) => WatchedMovieScreen()),
              );
            },
          ),

          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () {
              Navigator.push(
                this.context, 
                MaterialPageRoute(builder: (context) => WatchLaterMovieScreen()),
              );
            },
          ),
          
          IconButton(
            iconSize: 40,
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                this.context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),

          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                this.context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
          
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                this.context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),

        ],
      ),
    );
 }
}
