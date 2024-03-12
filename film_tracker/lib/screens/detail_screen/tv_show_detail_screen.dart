import 'package:film_tracker/background_color.dart';
import 'package:film_tracker/constants.dart';
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

 final TVShow tvShow;

  Future<void> _saveTVShowToWatchLater() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String key = 'TVShow_${tvShow.id}_WatchLater'; // Use a prefix to distinguish TV shows
  if (!prefs.containsKey(key)) {
      await prefs.setString(key, tvShow.id.toString());
      print("TV Show saved");
  } else {
      print("TV Show already saved");
  }
  }

 Future<void> _saveTVShowAsWatched() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 String key = 'TVShow_${tvShow.id}_Watched'; // Use 'Watched' status
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
                 '${Constants.imagePath}${tvShow.posterPath}',
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
                    tvShow.name,
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
                          '${tvShow.voteAverage.toStringAsFixed(1)}/10',
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
                            'Release Date: ${tvShow.firstAirDate}',
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
                            'Language: ${tvShow.language}',
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
                  onPressed: () => _saveTVShowToWatchLater(),
                  child: Text('Watch Later'),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () => _saveTVShowAsWatched(),
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

