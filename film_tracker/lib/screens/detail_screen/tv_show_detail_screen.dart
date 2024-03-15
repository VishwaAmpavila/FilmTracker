import 'package:film_tracker/background_color.dart';
import 'package:film_tracker/constants%20_values.dart';
import 'package:film_tracker/models/tv_show.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TVShowDetailsPage extends StatelessWidget {
 const TVShowDetailsPage({
    Key? key,
    required this.tvShow,
 }) : super(key: key);

// TV show object
 final TVShow tvShow;

  // Saves the TV show to the watch later list.
  Future<void> _saveTVShowToWatchLater() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String key = 'TVShow_${tvShow.id}_WatchLater'; // Unique key for the TV show
  if (!prefs.containsKey(key)) {
      await prefs.setString(key, tvShow.id.toString());
      print("TV Show saved");
  } else {
      print("TV Show already saved");
  }
  }

  // Saves the TV show as watched.
 Future<void> _saveTVShowAsWatched() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 String key = 'TVShow_${tvShow.id}_Watched'; // Unique key for the watched TV show.
 if (!prefs.containsKey(key)) {
    await prefs.setString(key, tvShow.id.toString());
    print("TV Show marked as Watched");
 } else {
    print("TV Show already marked as Watched");
 }
}



 @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colours.scaffoldBgColor,// Background color of the app bar
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                 bottomLeft: Radius.circular(24),
                 bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                 '${ConstantValues.imagePath}${tvShow.posterPath}',// Image URL
                 filterQuality: FilterQuality.high,// High-quality image scaling
                 fit: BoxFit.contain,
                ),
              ),
            ),
          ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                    Text(
                    tvShow.name,// TV show name
                    style: GoogleFonts.belleza(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,// Star icon
                          color: Colors.amber,
                        ),
                        Text(
                          '${tvShow.voteAverage.toStringAsFixed(1)}/10',// Vote average
                          style: GoogleFonts.roboto(
                           fontSize: 17,
                           fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Release Date: ${tvShow.firstAirDate}',// Release date
                            style: GoogleFonts.roboto(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Language: ${tvShow.language}',// Language
                            style: GoogleFonts.roboto(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  Text(
                    'Overview',
                    style: GoogleFonts.openSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                 ),

                 const SizedBox(height: 16),

                 Text(
                    tvShow.overview,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                 ),
                  
                 const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () => _saveTVShowToWatchLater(),// Saves the TV show to watch later
                  child: Text('Watch Later'),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () => _saveTVShowAsWatched(),// Marks the TV show as watched
                  child: Text('Watched'),
                ),

                
                 const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomAppBar(context: context),// bottom app ba
    );
 }
}

