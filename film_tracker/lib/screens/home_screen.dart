import 'package:film_tracker/api/api.dart';
import 'package:film_tracker/models/movie.dart';
import 'package:film_tracker/models/tv_show.dart';
import 'package:film_tracker/widgets/movie_slider.dart';
import 'package:film_tracker/widgets/tv_show_slider.dart';
import 'package:film_tracker/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:film_tracker/screens/search_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<TVShow>> airingTVShows;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    airingTVShows = Api().getAiringTVShows();
    upcomingMovies = Api().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/filmtracker_s_w.png',
          fit: BoxFit.contain,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 30),

              Text('Trending Movies', style: GoogleFonts.oswald(fontSize: 25),
              ),

              const SizedBox(height: 30),

              SizedBox(
                child: FutureBuilder(
                  future: trendingMovies,
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

              Text('Airing TV Shows', style: GoogleFonts.oswald(fontSize: 25),),

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

              Text('Upcoming Movies', style: GoogleFonts.oswald(fontSize: 25,),
              ),

              SizedBox(
                child: FutureBuilder(
                  future: upcomingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return  MoviesSlider(snapshot: snapshot,);
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
    );
  }
}