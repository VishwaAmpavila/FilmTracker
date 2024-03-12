import 'package:film_tracker/constants.dart';
import 'package:film_tracker/screens/detail_screen/tv_show_detail_screen.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:film_tracker/widgets/watch_later_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:film_tracker/models/tv_show.dart';
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
  List<String> keys = prefs.getKeys().where((key) => key.startsWith('TVShow_') && key.endsWith('_WatchLater')).toList();
  watchLaterTVShows = [];

  for (String key in keys) {
      String tvShowId = prefs.getString(key)!;
      TVShow? tvShow = await fetchTVShowDetails(tvShowId);
      if (tvShow != null) {
        setState(() {
          watchLaterTVShows.add(tvShow);
        });
      }
  }
  }

  Future<TVShow?> fetchTVShowDetails(String tvShowId) async {
  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/tv/$tvShowId?api_key=${Constants.apiKey}'));

  if (response.statusCode == 200) {
      return TVShow.fromJson(jsonDecode(response.body));
  } else {
      // Log the error or handle it as needed
      print('Failed to load TV show details for tvShowId: $tvShowId');
      return null; // Return null if the TV show details cannot be fetched
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
       title: Text('Watch Later (TV Shows)'),
     ),
     body: Column(
       children: [
         Expanded(
           child: ListView.builder(
             itemCount: watchLaterTVShows.length,
             itemBuilder: (context, index) {
               TVShow? tvShow = watchLaterTVShows[index];
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
                               if (tvShow != null) {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) => TVShowDetailsPage(tvShow: tvShow),
                                   ),
                                 );
                               } else {
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(content: Text('Failed to load TV show details')),
                                 );
                               }
                             },
                             child: Text(tvShow?.name ?? 'Failed to load TV show details'),
                           ),
                         ),
                       ],
                     ),
                     trailing: IconButton(
                       icon: Icon(Icons.delete),
                       onPressed: () => removeFromWatchLater(watchLaterTVShows[index].id.toString()),
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
         WatchLaterToggle(),
         bottomAppBar(context: context),
       ],
     ),
   );
 }
}
