class TVShow {
 int id;
 String name;
 String overview;
 String posterPath;
 String firstAirDate;
 double voteAverage;
 String language;

 TVShow({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
    required this.language,
 });

 factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      id: json["id"] ?? "not Found",
      name: json["name"] ?? "not Found",
      overview: json["overview"] ?? "not Found",
      posterPath: json["poster_path"] ?? "not Found",
      firstAirDate: json["first_air_date"] ?? "not Found",
      voteAverage: json["vote_average"].toDouble(),
      language: json["original_language"] ?? "not Found",
    );
 }
}
