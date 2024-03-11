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

  Future<void> _saveMovie(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = '${film.id}_$status';
    if (!prefs.containsKey(key)) {
      await prefs.setString(key, film.id.toString());
      print("Saved");
    } else {
      print("Already saved");
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
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                '${film.voteAverage.toStringAsFixed(1)}/10',
                                style: GoogleFonts.poppins(
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
                            style: GoogleFonts.poppins(
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
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                 ),
                 Text(
                    'Overview',
                    style: GoogleFonts.poppins(
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
                  onPressed: () => _saveMovie('WatchLater'),
                  child: Text('Watch Later'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _saveMovie('Watched'),
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

