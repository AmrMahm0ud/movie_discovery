import 'package:flutter/services.dart';
import 'package:movie_discovery/core/resources/data_state.dart';
import 'package:movie_discovery/core/utils/error_message_mapper.dart';
import 'package:movie_discovery/data/sources/remote/movie/model/remote_movie_detail_model.dart';
import 'package:movie_discovery/data/sources/remote/movie/model/remote_movie_result_model.dart';
import 'package:movie_discovery/data/sources/remote/movie/movie_api_services.dart';
import 'package:movie_discovery/domain/entity/movie/movie_detail.dart';
import 'package:movie_discovery/domain/entity/movie/movie_result.dart';
import 'package:movie_discovery/domain/repositories/movie/movie_repository.dart';

class MovieRepositoryImplementation implements MovieRepository {
  final MovieApiServices _movieApiServices;

  MovieRepositoryImplementation(this._movieApiServices);

  @override
  Future<DataState<MovieResult>> getPopularMovies({required int page}) async {
    try {
      final json = await _movieApiServices.getPopularMovies(page: page);
      final model = RemoteMovieResultModel.fromJson(json);
      return DataSuccess(data: model.mapToDomain());
    } on PlatformException catch (e) {
      return DataFailed(error: e, message: ErrorMessageMapper.map(e.message));
    } catch (e) {
      return DataFailed(message: ErrorMessageMapper.map(e.toString()));
    }
  }

  @override
  Future<DataState<MovieResult>> searchMovies({
    required String query,
    required int page,
  }) async {
    try {
      final json = await _movieApiServices.searchMovies(
        query: query,
        page: page,
      );
      final model = RemoteMovieResultModel.fromJson(json);
      return DataSuccess(data: model.mapToDomain());
    } on PlatformException catch (e) {
      return DataFailed(error: e, message: ErrorMessageMapper.map(e.message));
    } catch (e) {
      return DataFailed(message: ErrorMessageMapper.map(e.toString()));
    }
  }

  @override
  Future<DataState<MovieDetail>> getMovieDetail({required int movieId}) async {
    try {
      final json = await _movieApiServices.getMovieDetail(movieId: movieId);
      final model = RemoteMovieDetailModel.fromJson(json);
      return DataSuccess(data: model.mapToDomain());
    } on PlatformException catch (e) {
      return DataFailed(error: e, message: ErrorMessageMapper.map(e.message));
    } catch (e) {
      return DataFailed(message: ErrorMessageMapper.map(e.toString()));
    }
  }
}
