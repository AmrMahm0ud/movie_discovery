import 'package:movie_discovery/core/resources/data_state.dart';
import 'package:movie_discovery/domain/entity/movie/movie_result.dart';
import 'package:movie_discovery/domain/repositories/movie/movie_repository.dart';

class GetPopularMoviesUseCase {
  final MovieRepository _movieRepository;

  GetPopularMoviesUseCase(this._movieRepository);

  Future<DataState<MovieResult>> call({required int page}) async {
    return await _movieRepository.getPopularMovies(page: page);
  }
}
