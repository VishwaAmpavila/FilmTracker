import 'package:film_tracker/screens/watched/watched_movie_screen.dart';
import 'package:film_tracker/screens/watched/watched_tvshow_screen.dart';
import 'package:flutter/material.dart';

class WatchedToggle extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: const Color.fromARGB(255, 0, 0, 0), // Background color
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.movie),
                onPressed: () {
                 // Navigate to the Movie Watch Later screen
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WatchedMovieScreen()),
                 );
                },
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(Icons.live_tv),
                onPressed: () {
                 // Navigate to the TV Show Watch Later screen
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WatchedTvShowScreen()),
                 );
                },
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
 }
}
