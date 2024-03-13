import 'package:film_tracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Make sure to add this import for GoogleFonts

import '../../screens/detail_screen/tv_show_detail_screen.dart';

class TVShowSlider extends StatelessWidget {
 const TVShowSlider({
    super.key,
    required this.snapshot,
 });
 final AsyncSnapshot snapshot;

 @override
 Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(
                    builder: (context) => TVShowDetailsPage(
                      tvShow: snapshot.data[index],
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
                          '${Constants.imagePath}${snapshot.data![index].posterPath}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data![index].name,
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
