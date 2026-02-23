class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });
}

class MovieDetail {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final double voteAverage;
  final String releaseDate;
  final List<Genre> genres;
  final int runtime;

  MovieDetail({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
    required this.runtime,
  });
}
