import 'package:carousel_slider/carousel_slider.dart';
import 'package:film_tracker/constants%20_values.dart';
import 'package:film_tracker/screens/detail_screen/movie_detail_screen.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {

  // Constructor for Carousel, requires the snapshot
  const Carousel({
    super.key,
    required this.snapshot,
  });

  // Snapshot of the data to be displayed
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    // Returns a SizedBox containing a CarouselSlider.builder for displaying movies
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,// Number of items to display
        options: CarouselOptions(
          height: 300,
          autoPlay: true,// Automatically plays the carousel
          viewportFraction: 0.45,
          enlargeCenterPage: true,// Enlarges the center page
          pageSnapping: true,// Snaps to pages
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          // Builds each item in the carousel
          return GestureDetector(
            onTap: () {
              // Navigates to the movie details page when an item is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsPage(
                    film: snapshot.data[itemIndex],
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 300,
                width: 200,
                child: Column(
                 children: [
                    Expanded(
                      child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        '${ConstantValues.imagePath}${snapshot.data[itemIndex].posterPath}',// Image URL
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data[itemIndex].title,// Movie title
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                 ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}