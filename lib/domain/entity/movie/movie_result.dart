import 'package:movie_discovery/domain/entity/movie/movie.dart';

class MovieResult {
  final List<Movie> movies;
  final int totalPages;

  MovieResult({
    required this.movies,
    required this.totalPages,
  });
}
