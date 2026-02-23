import 'package:movie_discovery/core/resources/data_state.dart';
import 'package:movie_discovery/domain/entity/movie/movie_result.dart';
import 'package:movie_discovery/domain/repositories/movie/movie_repository.dart';

class SearchMoviesUseCase {
  final MovieRepository _movieRepository;

  SearchMoviesUseCase(this._movieRepository);

  Future<DataState<MovieResult>> call({
    required String query,
    required int page,
  }) async {
    return await _movieRepository.searchMovies(query: query, page: page);
  }
}
