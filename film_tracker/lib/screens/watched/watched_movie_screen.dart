import 'package:film_tracker/constants.dart';
import 'package:film_tracker/screens/detail_screen/movie_detail_screen.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:film_tracker/widgets/watched_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:film_tracker/models/movie.dart';

class WatchedMovieScreen extends StatefulWidget {
 @override
 _WatchedMovieScreenState createState() => _WatchedMovieScreenState();
}

class _WatchedMovieScreenState extends State<WatchedMovieScreen> {
 List<Movie> watchedMovies = [];

 @override
 void initState() {
   super.initState();
   loadWatchedMovies();
 }

  Future<void> loadWatchedMovies() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Filter keys to only include those that start with 'Movie_' and end with '_Watched'
  List<String> keys = prefs.getKeys().where((key) => key.startsWith('Movie_') && key.endsWith('_Watched')).toList();
  watchedMovies = [];

  for (String key in keys) {
        String movieId = prefs.getString(key)!;
        Movie? movie = await fetchMovieDetails(movieId);
        if (movie != null) {
          setState(() {
            watchedMovies.add(movie);
          });
        }
  }
  }


 Future<Movie?> fetchMovieDetails(String movieId) async {
 final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$movieId?api_key=${Constants.apiKey}'));

 if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
 } else {
      print('Failed to load movie details for movieId: $movieId');
      return null;
 }
}

  Future<void> removeFromWatched(String movieId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Filter keys to only include those that end with '_Watched'
  List<String> keys = prefs.getKeys().where((key) => key.endsWith('_Watched')).toList();
  for (String key in keys) {
      if (prefs.getString(key) == movieId) {
        await prefs.remove(key);
        break;
      }
  }
  setState(() {
      watchedMovies.removeWhere((movie) => movie.id == int.parse(movieId));
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
            itemCount: watchedMovies.length,
            itemBuilder: (context, index) {
              Movie? movie = watchedMovies[index];
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
                            child: Text(movie?.title ?? 'Failed to load movie details'),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => removeFromWatched(watchedMovies[index].id.toString()),
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
         WatchedToggle(),
         bottomAppBar(context: context),
       ],
     ),
   );
 }
}
