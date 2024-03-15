import 'package:film_tracker/background_color.dart';
import 'package:film_tracker/constants%20_values.dart';
import 'package:film_tracker/models/movie.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailsPage extends StatelessWidget {
 const MovieDetailsPage({
    Key? key,
    required this.film,
 }) : super(key: key);

 final Movie film; // Movie object.

 // Saves the movie to the watch later list.
 Future<void> _saveMovieToWatchLater() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 String key = 'Movie_${film.id}_WatchLater'; // Unique key for the movie.
 if (!prefs.containsKey(key)) {
      await prefs.setString(key, film.id.toString());
      print("Movie saved");
 } else {
      print("Movie already saved");
 }
 }

 // Saves the movie as watched.
 Future<void> _saveMovieAsWatched() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 String key = 'Movie_${film.id}_Watched'; // Unique key for the watched movie.
 if (!prefs.containsKey(key)) {
    await prefs.setString(key, film.id.toString());
    print("Movie marked as Watched");
 } else {
    print("Movie already marked as Watched");
 }
}

 @override
 Widget build(BuildContext context) {
    // Builds the movie details page UI.
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colours.scaffoldBgColor, // Background color of the app bar.
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
                 '${ConstantValues.imagePath}${film.posterPath}', // Image URL.
                 filterQuality: FilterQuality.high, // High-quality image scaling.
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
                    film.title, // Movie title.
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
                          Icons.star, // Star icon.
                          color: Colors.amber, 
                        ),
                        Text(
                          '${film.voteAverage.toStringAsFixed(1)}/10', // Vote average.
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
                      'Release Date: ${film.releaseDate}', // Release date.
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
                      'Language: ${film.language}', // Language.
                      style: GoogleFonts.roboto(
                        fontSize: 17, 
                        fontWeight: FontWeight.bold, 
                      ),
                    ),
                 ),
                 Text(
                    'Overview', // Overview title.
                    style: GoogleFonts.openSans(
                      fontSize: 30, 
                      fontWeight: FontWeight.w800, 
                    ),
                 ),
                 const SizedBox(height: 16),
                 Text(
                    film.overview, // Movie overview.
                    textAlign: TextAlign.center, 
                    style: GoogleFonts.poppins(
                      fontSize: 25, 
                      fontWeight: FontWeight.w400, 
                    ),
                 ),
                 const SizedBox(height: 16), 
                 ElevatedButton(
                    onPressed: () => _saveMovieToWatchLater(), // Saves the movie to watch later.
                    child: Text('Watch Later'), 
                 ),
                 const SizedBox(height: 16), 
                 ElevatedButton(
                    onPressed: () => _saveMovieAsWatched(), // Marks the movie as watched.
                    child: Text('Watched'), 
                 ),
                 const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomAppBar(context: context), // bottom app bar.
    );
 }
}

