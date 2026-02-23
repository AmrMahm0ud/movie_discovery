import 'package:movie_discovery/core/resources/data_state.dart';
import 'package:movie_discovery/domain/entity/movie/movie_detail.dart';
import 'package:movie_discovery/domain/repositories/movie/movie_repository.dart';

class GetMovieDetailUseCase {
  final MovieRepository _movieRepository;

  GetMovieDetailUseCase(this._movieRepository);

  Future<DataState<MovieDetail>> call({required int movieId}) async {
    return await _movieRepository.getMovieDetail(movieId: movieId);
  }
}
