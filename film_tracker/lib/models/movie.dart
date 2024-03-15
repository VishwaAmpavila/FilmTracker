// Movie class represents a movie with its details
// It includes properties like id, title, backDropPath, overview, posterPath, releaseDate, voteAverage, and language
// The class also includes a factory constructor fromJson to create a Movie object from a JSON map

class Movie {
  int id;
  String title;
  String backDropPath;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;
  String language;

  Movie({
    required this.id,
    required this.title,
    required this.backDropPath,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.language,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"] ?? "not Found",
      title: json["title"] ?? "not Found",
      backDropPath: json["backdrop_path"] ?? "not Found",
      overview: json["overview"] ?? "not Found",
      posterPath: json["poster_path"] ?? "not Found",
      releaseDate: json["release_date"] ?? "not Found",
      voteAverage: json["vote_average"].toDouble(),
      language: json["original_language"] ?? "not Found",
    );
  }
}