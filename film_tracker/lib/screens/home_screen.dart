import 'package:film_tracker/api/api.dart';
import 'package:film_tracker/models/movie.dart';
import 'package:film_tracker/models/tv_show.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:film_tracker/widgets/home_screen_widgets/movie_slider.dart';
import 'package:film_tracker/widgets/home_screen_widgets/tv_show_slider.dart';
import 'package:film_tracker/widgets/home_screen_widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {

  // Constructor for HomeScreen.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Futures for fetching trending movies, airing TV shows, best movies of the year, 
//highest grossing movies, and children friendly movies
class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> currentlyAiringMovies;
  late Future<List<TVShow>> airingTVShows;
  late Future<List<Movie>> bestMoviesOfTheYear;
  late Future<List<Movie>> getHighestGrossingMovies;
  late Future<List<Movie>> getChildrenMovies;

  @override
  void initState() {
    super.initState();
    // Initializing futures in initState to fetch data when the widget is created
    currentlyAiringMovies = Api().getCurrentlyAiringMovies();
    airingTVShows = Api().getAiringTVShows();
    bestMoviesOfTheYear = Api().getBestMoviesOfTheYear();
    getHighestGrossingMovies = Api().getHighestGrossingMovies();
    getChildrenMovies = Api().getChildrenMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,// Removes the default back button
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/filmtracker_s_w.png',
          fit: BoxFit.contain,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),// Bouncing effect on scroll
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 30),
              
              Center(
                child:
                Text('Whats On At The Cinema?', 
                style: GoogleFonts.poppins(
                  fontSize: 20),
                ),
              ),

              // Carousel for trending movies
              SizedBox(
                child: FutureBuilder(
                  future: currentlyAiringMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return  Carousel(snapshot: snapshot,);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),

              const SizedBox(height: 30),

              Center(
                child:
                Text('Whats On TV Tonight?', 
                style: GoogleFonts.poppins(
                  fontSize: 20),
                ),
              ),

              // TV show slider for airing TV shows
              SizedBox(
                child: FutureBuilder(
                 future: airingTVShows,
                 builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      return TVShowSlider(snapshot: snapshot,);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                 },
                ),
              ),

              const SizedBox(height: 30),

              Center(
              child: Text(
                  'Best Movies This Year',
                  style: GoogleFonts.poppins(fontSize: 20),
              ),
              ),

              // Movie slider for best movies of the year
              SizedBox(
              child: FutureBuilder<List<Movie>>(
                  future: bestMoviesOfTheYear,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      return MovieSlider(snapshot: snapshot,);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
              ),
              ),

              const SizedBox(height: 30),

              Center(
              child: Text(
                  'Highest Grossing Movies',
                  style: GoogleFonts.poppins(fontSize: 20),
              ),
              ),

              // Movie slider for highest grossing movies
              SizedBox(
              child: FutureBuilder<List<Movie>>(
                  future: getHighestGrossingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      return MovieSlider(snapshot: snapshot,);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
              ),
              ),

              const SizedBox(height: 30),

              Center(
              child: Text(
                  'Children Friendly Movies',
                  style: GoogleFonts.poppins(fontSize: 20),
              ),
              ),

              // Movie slider for children friendly movies
              SizedBox(
              child: FutureBuilder<List<Movie>>(
                  future: getChildrenMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      return MovieSlider(snapshot: snapshot,);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
              ),
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
      //bottom app bar
      bottomNavigationBar: bottomAppBar(context: context),
    );
  }
}