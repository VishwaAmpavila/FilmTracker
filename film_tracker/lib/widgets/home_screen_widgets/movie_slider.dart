import 'package:film_tracker/constants%20_values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/detail_screen/movie_detail_screen.dart';

class MovieSlider extends StatelessWidget {

  // Constructor for MovieSlider, requires the snapshot
 const MovieSlider({
    super.key,
    required this.snapshot,
 });

 // Snapshot of the data to be displayed
 final AsyncSnapshot snapshot;

 @override
 Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,// Horizontal Scrolling
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,// Number of items to display
        itemBuilder: (context, index) {
          // Builds each item in the list
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Navigates to the movie details page when an item is tapped
                Navigator.push(
                 context,
                 MaterialPageRoute(
                    builder: (context) => MovieDetailsPage(
                      film: snapshot.data[index],
                    ),
                 ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                 height: 200,
                 width: 150,
                 child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          '${ConstantValues.imagePath}${snapshot.data![index].posterPath}',// Image URL
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data![index].title,// Movie title
                          style: GoogleFonts.belleza(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                 ),
                ),
              ),
            ),
          );
        },
      ),
    );
 }
}
