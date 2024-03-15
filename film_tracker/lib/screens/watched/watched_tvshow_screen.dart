import 'package:film_tracker/constants%20_values.dart';
import 'package:film_tracker/screens/detail_screen/tv_show_detail_screen.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:film_tracker/widgets/watched_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:film_tracker/models/tv_show.dart';

class WatchedTvShowScreen extends StatefulWidget {
 @override

 // Constructor for WatchedTvShowScreen
 _WatchedTvShowScreenState createState() => _WatchedTvShowScreenState();
}

class _WatchedTvShowScreenState extends State<WatchedTvShowScreen> {

  // List to store watched TV shows
 List<TVShow> watchedTvShows = [];

 @override
 void initState() {
   super.initState();
   // Loads watched TV shows when the widget is initialized
   loadWatchedTvShows();
 }

  // Loads watched TV shows from shared preferences
 Future<void> loadWatchedTvShows() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 // Filters keys to get only those related to watched TV shows
 List<String> keys = prefs.getKeys().where((key) => key.startsWith('TVShow_') && key.endsWith('_Watched')).toList();
 watchedTvShows = [];

  // Fetches details for each watched TV show
 for (String key in keys) {
      String tvShowId = prefs.getString(key)!;
      TVShow? tvShow = await fetchTvShowDetails(tvShowId);
      if (tvShow != null) {
        setState(() {
          watchedTvShows.add(tvShow);
        });
      }
 }
}

  // Fetches details for a TV show from TMDb
 Future<TVShow?> fetchTvShowDetails(String tvShowId) async {
 final response = await http.get(Uri.parse('https://api.themoviedb.org/3/tv/$tvShowId?api_key=${ConstantValues.apiKey}'));

 if (response.statusCode == 200) {
      return TVShow.fromJson(jsonDecode(response.body));
 } else {
      print('Failed to load TV show details for tvShowId: $tvShowId');
      return null;
 }
}

  // Removes a TV show from the watched list
 Future<void> removeFromWatched(String tvShowId) async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 // Filters keys to get only those related to watched TV shows
 List<String> keys = prefs.getKeys().where((key) => key.endsWith('_Watched')).toList();
 for (String key in keys) {
    if (prefs.getString(key) == tvShowId) {
      await prefs.remove(key);
      break;
    }
 }
 setState(() {
    // Removes the TV show from the watched TV Shows list
    watchedTvShows.removeWhere((tvShow) => tvShow.id == int.parse(tvShowId));
 });
}

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Watched (TV Shows)'),
     ),
     body: Column(
       children: [
         Expanded(
           child: ListView.builder(
             itemCount: watchedTvShows.length,
             itemBuilder: (context, index) {
               TVShow? tvShow = watchedTvShows[index];
               return Column(
                 children: [
                   ListTile(
                     title: Row(
                       children: [
                         tvShow?.posterPath != null ? Image.network(
                           'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                           width: 100, // Set the width of the image
                           height: 150, // Set the height of the image
                           fit: BoxFit.cover,
                         ) : Container(),
                         SizedBox(width: 10),
                         Expanded(
                           child: GestureDetector(
                             onTap: () {
                               Navigator.push(
                                 context,
                                 // Navigates to the TV show details page
                                 MaterialPageRoute(
                                   builder: (context) => TVShowDetailsPage(tvShow: tvShow),
                                 ),
                               );
                              },
                             child: Text(tvShow?.name ?? 'Failed to load TV show details'),// Displays the TV show name
                           ),
                         ),
                       ],
                     ),
                     trailing: IconButton(
                       icon: Icon(Icons.delete),
                       onPressed: () => removeFromWatched(watchedTvShows[index].id.toString()),// Removes the TV show from the watched list
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
         WatchedToggle(),// Watched toggle button
         bottomAppBar(context: context),// bottom app bar
       ],
     ),
   );
 }
}
