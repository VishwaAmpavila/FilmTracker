import 'package:flutter/material.dart';
import 'package:film_tracker/api/api.dart';
import 'package:film_tracker/models/movie.dart';
import 'package:film_tracker/widgets/movie_slider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Movie>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = Api().getTrendingMovies();
  }

  void _searchMovies(String query) {
    setState(() {
      _searchResults = Api().searchMovies(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
          ),
          onSubmitted: _searchMovies,
        ),
      ),
      body: FutureBuilder(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return MoviesSlider(snapshot: snapshot,);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
