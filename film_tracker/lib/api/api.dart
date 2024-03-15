import 'dart:convert';

import 'package:film_tracker/constants%20_values.dart';
import 'package:film_tracker/models/tv_show.dart';
import 'package:film_tracker/models/movie.dart';
import 'package:http/http.dart' as http;

// Api class for fetching data from the TMDb API.
class Api {
 // URLs for different types of movie and TV show data.
 static const _currentlyairingmovieUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=${ConstantValues.apiKey}';
 static const _currentlyairingtvURL = 'https://api.themoviedb.org/3/tv/on_the_air?api_key=${ConstantValues.apiKey}';
 static const _moviesoftheyearURL = 'https://api.themoviedb.org/3/discover/movie?api_key=${ConstantValues.apiKey}&primary_release_year=2023&sort_by=popularity.desc';
 static const _highestgrossingURL = 'https://api.themoviedb.org/3/discover/movie?api_key=${ConstantValues.apiKey}&sort_by=revenue.desc';
 static const _childrenfriendlyURL = 'https://api.themoviedb.org/3/discover/movie?api_key=${ConstantValues.apiKey}&with_genres=10751';

 // Fetches currently airing movies.
 Future<List<Movie>> getCurrentlyAiringMovies() async {
    final response = await http.get(Uri.parse(_currentlyairingmovieUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
 }

 // Fetches currently airing TV shows.
 Future<List<TVShow>> getAiringTVShows() async {
    final response = await http.get(Uri.parse(_currentlyairingtvURL));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((tvShow) => TVShow.fromJson(tvShow)).toList();
    } else {
      throw Exception('Something happened');
    }
 }

 // Fetches best movies of the year.
 Future<List<Movie>> getBestMoviesOfTheYear() async {
    final response = await http.get(Uri.parse(_moviesoftheyearURL));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
 }

 // Fetches highest grossing movies.
 Future<List<Movie>> getHighestGrossingMovies() async {
    final response = await http.get(Uri.parse(_highestgrossingURL));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
 }

 // Fetches children-friendly movies.
 Future<List<Movie>> getChildrenMovies() async {
    final response = await http.get(Uri.parse(_childrenfriendlyURL));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
 }
}