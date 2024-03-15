import 'package:film_tracker/constants%20_values.dart';
import 'package:film_tracker/screens/detail_screen/movie_detail_screen.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:film_tracker/widgets/watch_later_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:film_tracker/models/movie.dart';


class WatchLaterMovieScreen extends StatefulWidget {
 @override
 
 _WatchLaterMovieScreenState createState() => _WatchLaterMovieScreenState();
}

class _WatchLaterMovieScreenState extends State<WatchLaterMovieScreen> {
  // List to store watched Movies
 List<Movie> watchLaterMovies = [];

 @override
 void initState() {
   super.initState();
   // Loads watch later Movies when the widget is initialized
   loadWatchLaterMovies();
 }

  // Loads watch later Movies from shared preferences
  Future<void> loadWatchLaterMovies() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Filter keys to only include those that start with 'Movie_' and end with '_WatchLater'
  List<String> keys = prefs.getKeys().where((key) => key.startsWith('Movie_') && key.endsWith('_WatchLater')).toList();
  watchLaterMovies = [];
  
  // Fetches details for each watched Movies
  for (String key in keys) {
        String movieId = prefs.getString(key)!;
        Movie? movie = await fetchMovieDetails(movieId);
        if (movie != null) {
          setState(() {
            watchLaterMovies.add(movie);
          });
        }
  }
  }

  // Fetches details for a Movies from TMDb
  Future<Movie?> fetchMovieDetails(String movieId) async {
  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$movieId?api_key=${ConstantValues.apiKey}'));

  if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
  } else {
      // Log the error or handle it as needed
      print('Failed to load movie details for movieId: $movieId');
      return null; // Return null if the movie details cannot be fetched
  }
  }

  // Removes a Movie from the watched list
  Future<void> removeFromWatchLater(String movieId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Filter keys to only include those that end with '_WatchLater'
  List<String> keys = prefs.getKeys().where((key) => key.endsWith('_WatchLater')).toList();
  for (String key in keys) {
      if (prefs.getString(key) == movieId) {
        await prefs.remove(key);
        break;
      }
  }
  setState(() {
    // Removes the Movies from the watch later movies list
      watchLaterMovies.removeWhere((movie) => movie.id == int.parse(movieId));
  });
  }


@override
Widget build(BuildContext context) {
 return Scaffold(
    appBar: AppBar(
      title: Text('Watch Later (Movies)'),
    ),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: watchLaterMovies.length,
            itemBuilder: (context, index) {
              Movie? movie = watchLaterMovies[index];
              return Column(
                children: [
                 ListTile(
                    title: Row(
                      children: [
                        movie?.posterPath != null ? Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: 100, // Set the width of the image
                          height: 150, // Set the height of the image
                          fit: BoxFit.cover,
                        ) : Container(),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (movie != null) {
                                Navigator.push(
                                 context,
                                 // Navigates to the Movie details page
                                 MaterialPageRoute(
                                    builder: (context) => MovieDetailsPage(film: movie),
                                 ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text('Failed to load movie details')),
                                );
                              }
                            },
                            child: Text(movie?.title ?? 'Failed to load movie details'),// Displays the Movie Title
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => removeFromWatchLater(watchLaterMovies[index].id.toString()),// Removes the Movies from the watch later list
                    ),
                 ),
                 Divider(height: 1, color: Colors.grey),
                ],
              );
            },
          ),
        ),
      ],
    ),
    bottomNavigationBar: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WatchLaterToggle(),// Watched toggle button
        bottomAppBar(context: context),// bottom app bar
      ],
    ),
 );
}
}
