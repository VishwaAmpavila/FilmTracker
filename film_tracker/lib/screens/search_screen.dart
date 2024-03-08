import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:film_tracker/models/movie.dart';
import 'package:film_tracker/screens/movie_detail_screen.dart';
import 'package:film_tracker/constants.dart';

class SearchScreen extends StatefulWidget {
 const SearchScreen({Key? key}) : super(key: key);

 @override
 _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
 final _searchController = TextEditingController();
 List<dynamic> _searchResults = [];
 bool _isLoading = false;
 Timer? _debounce;

 @override
 void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
 }

 Future<void> _fetchSearchResults(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isLoading = false;
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}&query=$query'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      setState(() {
        _isLoading = false;
        _searchResults = jsonBody['results'];
      });
    } else {
      setState(() {
        _isLoading = false;
        _searchResults = [];
      });
    }
 }

 void _onSearchTextChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchSearchResults(text);
    });
 }

 void _navigateToDetailsScreen(dynamic movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(film: Movie.fromJson(movie)),
      ),
    );
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchTextChanged,
          decoration: const InputDecoration(
            hintText: 'Search for a movie...',
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isNotEmpty
              ? ListView.builder(
                 itemCount: _searchResults.length,
                 itemBuilder: (context, index) {
                    final movie = _searchResults[index];
                    return ListTile(
                      title: Text(movie['title']),
                      subtitle: Text(movie['overview']),
                      leading: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.movie);
                        },
                      ),
                      onTap: () => _navigateToDetailsScreen(movie),
                    );
                 },
                )
              : const Center(
                 child: Text('No results found'),
                ),
    );
 }
}
