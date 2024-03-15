import 'dart:async';
import 'dart:convert';
import 'package:film_tracker/models/tv_show.dart';
import 'package:film_tracker/screens/detail_screen/tv_show_detail_screen.dart';
import 'package:film_tracker/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:film_tracker/models/movie.dart';
import 'package:film_tracker/screens/detail_screen/movie_detail_screen.dart';
import 'package:film_tracker/constants%20_values.dart';

// Enum to differentiate between movie and TV show searches
enum SearchType { movie, tvShow}

class SearchScreen extends StatefulWidget {
 const SearchScreen({Key? key}) : super(key: key);

 @override
 _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // Text editing controller for the search field
 final _searchController = TextEditingController();
 // List to store search results
 List<dynamic> _searchResults = [];
 // Flag to indicate loading state
 bool _isLoading = false;
 // Timer for debouncing search input
 Timer? _debounce;
 // Selected search type
 SearchType _selectedSearchType = SearchType.movie;

 @override
 void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
 }

// Fetches search results based on the query
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

    String searchURLType;
    if(_selectedSearchType == SearchType.movie){
      
      searchURLType = "search/movie";
    }else if(_selectedSearchType == SearchType.tvShow){

      searchURLType = "search/tv";
    }else{

      return;
    }

    final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/$searchURLType?api_key=${ConstantValues.apiKey}&query=$query')
      );
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

  // Handles search text changes with a debounce
 void _onSearchTextChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchSearchResults(text);
    });
 }

// Navigates to the movie details screen
 void _navigateToMovieDetailsScreen(dynamic media) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(film: Movie.fromJson(media)),
      ),
    );
 }

   // Navigates to the TV show details screen
  void _navigateToTVShowDetailsScreen(dynamic media) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TVShowDetailsPage(tvShow: TVShow.fromJson(media)),
      ),
    );
 }

@override
Widget build(BuildContext context) {
 return Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchTextChanged,
              decoration: const InputDecoration(
                hintText: 'Search...',
              ),
            ),
          ),
          DropdownButton<SearchType>(
            value: _selectedSearchType,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (SearchType? newValue) {
              setState(() {
                _searchResults.clear();
                _searchController.clear();
                _selectedSearchType = newValue!;
              });
            },
            items: SearchType.values.map((SearchType searchType) {
              return DropdownMenuItem<SearchType>(
                value: searchType,
                child: Text(searchType.toString().split('.').last),
              );
            }).toList(),
          ),
        ],
      ),
    ),
    body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _searchResults.isNotEmpty
            ? ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                 final media = _searchResults[index];
                 if(_selectedSearchType == SearchType.movie){

                 return ListTile(
                    title: Text(media['title']),
                    subtitle: Text(media['overview']),
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${media['poster_path']}',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.movie);
                      },
                    ),
                    // On tap runs _navigateToMovieDetailsScreen function
                    onTap: () => _navigateToMovieDetailsScreen(media),
                 );
                 }else if(_selectedSearchType == SearchType.tvShow){
                  
                  return ListTile(
                    title: Text(media['name']),
                    subtitle: Text(media['overview']),
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${media['poster_path']}',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.tv);
                      },
                    ),
                    // On tap runs _navigateToTVShowDetailsScreen function
                    onTap: () => _navigateToTVShowDetailsScreen(media),
                 );
                 }
            },
          )
        : const Center(
            child: Text('No results found'),
          ),
    //bottom app bar
    bottomNavigationBar: bottomAppBar(context: context),
 );
}

}
