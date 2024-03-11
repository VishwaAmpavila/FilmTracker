import 'package:film_tracker/constants.dart';
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
 List<Movie> watchLaterMovies = [];

 @override
 void initState() {
   super.initState();
   loadWatchLaterMovies();
 }

 Future<void> loadWatchLaterMovies() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   List<String> keys = prefs.getKeys().where((key) => key.contains('WatchLater')).toList();
   watchLaterMovies = [];

   for (String key in keys) {
     String movieId = prefs.getString(key)!;
     Movie movie = await fetchMovieDetails(movieId);
     setState(() {
       watchLaterMovies.add(movie);
     });
   }
 }

 Future<Movie> fetchMovieDetails(String movieId) async {
   final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$movieId?api_key=${Constants.apiKey}'));

   if (response.statusCode == 200) {
     return Movie.fromJson(jsonDecode(response.body));
   } else {
     throw Exception('Failed to load movie details');
   }
 }

 Future<void> removeFromWatchLater(String movieId) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   List<String> keys = prefs.getKeys().where((key) => key.contains('WatchLater')).toList();
   for (String key in keys) {
     if (prefs.getString(key) == movieId) {
       await prefs.remove(key);
       break;
     }
   }
   setState(() {
     watchLaterMovies.removeWhere((movie) => movie.id == int.parse(movieId));
   });
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Watch Later (Movies)'),
     ),
     body: ListView.builder(
       itemCount: watchLaterMovies.length,
       itemBuilder: (context, index) {
         return ListTile(
           title: GestureDetector(
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => MovieDetailsPage(film: watchLaterMovies[index]),
                 ),
               );
             },
             child: Text(watchLaterMovies[index].title),
           ),
           trailing: IconButton(
             icon: Icon(Icons.delete),
             onPressed: () => removeFromWatchLater(watchLaterMovies[index].id.toString()),
           ),
         );
       },
     ),
          bottomNavigationBar: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         WatchLaterToggle(),
         bottomAppBar(context: context),
       ],
     ),
   );
 }
}
