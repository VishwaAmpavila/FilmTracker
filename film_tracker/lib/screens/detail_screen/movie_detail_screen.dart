import 'package:film_tracker/background_color.dart';
import 'package:film_tracker/constants.dart';
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

 final Movie film;

  Future<void> _saveMovieToWatchLater() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String key = 'Movie_${film.id}_WatchLater';
  if (!prefs.containsKey(key)) {
      await prefs.setString(key, film.id.toString());
      print("Movie saved");
  } else {
      print("Movie already saved");
  }
  }

 Future<void> _saveMovieAsWatched() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 String key = 'Movie_${film.id}_Watched';
 if (!prefs.containsKey(key)) {
    await prefs.setString(key, film.id.toString());
    print("Movie marked as Watched");
 } else {
    print("Movie already marked as Watched");
 }
}

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colours.scaffoldBgColor,
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
                 '${Constants.imagePath}${film.posterPath}',
                 filterQuality: FilterQuality.high,
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
                    film.title,
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
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          '${film.voteAverage.toStringAsFixed(1)}/10',
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
                            'Release Date: ${film.releaseDate}',
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
                            'Language: ${film.language}',
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
                    film.overview,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      
                    ),
                 ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () => _saveMovieToWatchLater(),
                  child: Text('Watch Later'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _saveMovieAsWatched(),
                  child: Text('Watched'),
                ),

                 const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomAppBar(context: context),
    );
 }
}

