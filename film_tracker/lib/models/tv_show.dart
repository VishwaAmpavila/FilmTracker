class TVShow {
 String name;
 String originalName;
 String overview;
 String posterPath;
 String firstAirDate;
 double voteAverage;

 TVShow({
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
 });

 factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      name: json["name"],
      originalName: json["original_name"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      firstAirDate: json["first_air_date"],
      voteAverage: json["vote_average"].toDouble(),
    );
 }
}
