import 'package:hive/hive.dart';
import 'package:movie_discovery/data/sources/remote/movie/model/remote_movie_model.dart';
import 'package:movie_discovery/data/sources/remote/movie/model/remote_movie_result_model.dart';

class MovieLocalDataSource {
  static const String boxName = 'movies';

  static const String _popularMoviesKey = 'popular_movies';
  static const String _popularTotalPagesKey = 'popular_total_pages';
  static const String _popularLastPageKey = 'popular_last_page';

  final Box _box;

  MovieLocalDataSource(this._box);

  Future<void> savePopularMovies({
    required List<RemoteMovieModel> movies,
    required int page,
    required int totalPages,
  }) async {
    final existingRaw = _box.get(_popularMoviesKey);
    final List<Map<String, dynamic>> existing =
        page == 1
            ? []
            : (existingRaw as List?)
                    ?.map((e) => Map<String, dynamic>.from(e as Map))
                    .toList() ??
                [];

    existing.addAll(movies.map((m) => m.toJson()));

    await _box.put(_popularMoviesKey, existing);
    await _box.put(_popularTotalPagesKey, totalPages);
    await _box.put(_popularLastPageKey, page);
  }

  RemoteMovieResultModel? getPopularMovies() {
    final raw = _box.get(_popularMoviesKey);
    if (raw == null) return null;

    final List<Map<String, dynamic>> jsonList =
        (raw as List).map((e) => Map<String, dynamic>.from(e as Map)).toList();

    if (jsonList.isEmpty) return null;

    final totalPages = _box.get(_popularTotalPagesKey, defaultValue: 1) as int;

    return RemoteMovieResultModel(
      results: jsonList.map((j) => RemoteMovieModel.fromJson(j)).toList(),
      totalPages: totalPages,
    );
  }

  Future<void> clearPopularMovies() async {
    await _box.delete(_popularMoviesKey);
    await _box.delete(_popularTotalPagesKey);
    await _box.delete(_popularLastPageKey);
  }
}
