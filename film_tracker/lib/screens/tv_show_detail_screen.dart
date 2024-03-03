import 'package:film_tracker/background_color.dart';
import 'package:film_tracker/constants.dart';
import 'package:film_tracker/models/tv_show.dart';
import 'package:film_tracker/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TVShowDetailsPage extends StatelessWidget {
 const TVShowDetailsPage({
    Key? key,
    required this.tvShow,
 }) : super(key: key);

 final TVShow tvShow;

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const BackBtn(),
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                tvShow.name,
                style: GoogleFonts.belleza(
                 fontSize: 17,
                 fontWeight: FontWeight.w600,
                ),
              ),
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
                    'Overview',
                    style: GoogleFonts.openSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                 ),
                 const SizedBox(height: 16),
                 Text(
                    tvShow.overview,
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                 ),
                 const SizedBox(height: 16),
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
                      ],
                    ),
                 ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
 }
}

