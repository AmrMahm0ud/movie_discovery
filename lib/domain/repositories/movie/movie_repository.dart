import 'package:movie_discovery/core/resources/data_state.dart';
import 'package:movie_discovery/domain/entity/movie/movie_detail.dart';
import 'package:movie_discovery/domain/entity/movie/movie_result.dart';

abstract class MovieRepository {
  Future<DataState<MovieResult>> getPopularMovies({required int page});

  Future<DataState<MovieResult>> searchMovies({
    required String query,
    required int page,
  });

  Future<DataState<MovieDetail>> getMovieDetail({required int movieId});
}
