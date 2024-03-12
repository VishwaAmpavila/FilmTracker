import 'dart:convert';

import 'package:film_tracker/constants.dart';
import 'package:film_tracker/models/tv_show.dart';
import 'package:film_tracker/models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';
  static const _airingtvURL = 'https://api.themoviedb.org/3/tv/on_the_air?api_key=${Constants.apiKey}';
  static const _moviesoftheyearURL = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&primary_release_year=2023&sort_by=vote_average.desc';
  static const _highestgrossingURL = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&sort_by=revenue.desc';
  static const _childrenfriendlyURL = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&include_adult=false';
  

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<TVShow>> getAiringTVShows() async {
    final response = await http.get(Uri.parse(_airingtvURL));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((tvShow) => TVShow.fromJson(tvShow)).toList();
   } else {
      throw Exception('Failed to load airing TV shows');
   }
  }


  Future<List<Movie>> getBestMoviesOfTheYear() async {
  final response = await http.get(Uri.parse(_moviesoftheyearURL));
  if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
  } else {
      throw Exception('Failed to load best movies of the year');
  }
  }

  Future<List<Movie>> getHighestGrossingMovies() async {
  final response = await http.get(Uri.parse(_highestgrossingURL));
  if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
  } else {
      throw Exception('Failed to load highest-grossing movies of all time');
  }
  }

  Future<List<Movie>> getChildrenMovies() async {
  final response = await http.get(Uri.parse(_childrenfriendlyURL));
  if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
  } else {
      throw Exception('Failed to load non-adult movies');
  }
  }

}