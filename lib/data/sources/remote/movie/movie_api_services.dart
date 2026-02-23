import 'package:movie_discovery/core/utils/network/api_channel.dart';
import 'package:movie_discovery/data/sources/api_keys.dart';

class MovieApiServices {
  final ApiChannel _apiChannel;

  MovieApiServices(this._apiChannel);

  Future<Map<String, dynamic>> getPopularMovies({required int page}) async {
    return await _apiChannel.get(
      baseUrl: ApiKeys.baseUrl,
      path: '/movie/popular',
      queryParams: {
        'page': page,
      },
      headers: ApiKeys.authHeaders,
    );
  }

  Future<Map<String, dynamic>> searchMovies({
    required String query,
    required int page,
  }) async {
    return await _apiChannel.get(
      baseUrl: ApiKeys.baseUrl,
      path: '/search/movie',
      queryParams: {
        'query': query,
        'page': page,
      },
      headers: ApiKeys.authHeaders,
    );
  }

  Future<Map<String, dynamic>> getMovieDetail({required int movieId}) async {
    return await _apiChannel.get(
      baseUrl: ApiKeys.baseUrl,
      path: '/movie/$movieId',
      headers: ApiKeys.authHeaders,
    );
  }
}
