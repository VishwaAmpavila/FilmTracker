import 'package:film_tracker/api/api.dart';
import 'package:film_tracker/models/movie.dart';
import 'package:film_tracker/models/tv_show.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:film_tracker/widgets/tv_show_slider.dart';
import 'package:film_tracker/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<TVShow>> airingTVShows;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    airingTVShows = Api().getAiringTVShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        physics: const BouncingScrollPhysics(),
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

              Center(
                child:
                Text('Whats On TV Tonight?', 
                style: GoogleFonts.poppins(
                  fontSize: 20),
                ),
              ),

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
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomAppBar(context: context),
    );
  }
}