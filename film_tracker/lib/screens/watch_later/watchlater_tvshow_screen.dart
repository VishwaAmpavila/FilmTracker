import 'package:film_tracker/constants.dart';
import 'package:film_tracker/screens/detail_screen/tv_show_detail_screen.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:film_tracker/models/tv_show.dart'; // Import the TVShow model

class WatchLaterTVShowScreen extends StatefulWidget {
 @override
 _WatchLaterTVShowScreenState createState() => _WatchLaterTVShowScreenState();
}

class _WatchLaterTVShowScreenState extends State<WatchLaterTVShowScreen> {
 List<TVShow> watchLaterTVShows = [];

 @override
 void initState() {
   super.initState();
   loadWatchLaterTVShows();
 }

 Future<void> loadWatchLaterTVShows() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   List<String> keys = prefs.getKeys().where((key) => key.contains('WatchLater')).toList();
   watchLaterTVShows = [];

   for (String key in keys) {
     String tvShowId = prefs.getString(key)!;
     TVShow tvShow = await fetchTVShowDetails(tvShowId);
     setState(() {
       watchLaterTVShows.add(tvShow);
     });
   }
 }

 Future<TVShow> fetchTVShowDetails(String tvShowId) async {
   final response = await http.get(Uri.parse('https://api.themoviedb.org/3/tv/$tvShowId?api_key=${Constants.apiKey}'));

   if (response.statusCode == 200) {
     return TVShow.fromJson(jsonDecode(response.body));
   } else {
     throw Exception('Failed to load TV show details');
   }
 }

 Future<void> removeFromWatchLater(String tvShowId) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   List<String> keys = prefs.getKeys().where((key) => key.contains('WatchLater')).toList();
   for (String key in keys) {
     if (prefs.getString(key) == tvShowId) {
       await prefs.remove(key);
       break;
     }
   }
   setState(() {
     watchLaterTVShows.removeWhere((tvShow) => tvShow.id == int.parse(tvShowId));
   });
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Watch Later TV Shows'),
     ),
     body: ListView.builder(
       itemCount: watchLaterTVShows.length,
       itemBuilder: (context, index) {
         return ListTile(
           title: GestureDetector(
             onTap: () {
               // Navigate to the TV show detail page
               // You'll need to create a similar detail page for TV shows
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => TVShowDetailsPage(tvShow: watchLaterTVShows[index]),
                 ),
               );
             },
             child: Text(watchLaterTVShows[index].name),
           ),
           // Add more details as needed
           trailing: IconButton(
             icon: Icon(Icons.delete),
             onPressed: () => removeFromWatchLater(watchLaterTVShows[index].id.toString()),
           ),
         );
       },
     ),
    bottomNavigationBar: bottomAppBar(context: context),
   );
 }
}
