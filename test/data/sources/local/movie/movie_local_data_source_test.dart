import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:movie_discovery/data/sources/local/movie/movie_local_data_source.dart';
import 'package:movie_discovery/data/sources/remote/movie/model/remote_movie_model.dart';

void main() {
  late MovieLocalDataSource dataSource;
  late Box box;
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(tempDir.path);
    box = await Hive.openBox('test_movies');
    dataSource = MovieLocalDataSource(box);
  });

  tearDown(() async {
    await box.clear();
    await box.close();
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  RemoteMovieModel _makeMovie(int id, String title) {
    return RemoteMovieModel(
      id: id,
      title: title,
      posterPath: '/poster_$id.jpg',
      overview: 'Overview for $title',
      voteAverage: 7.5,
      releaseDate: '2025-01-01',
    );
  }

  group('MovieLocalDataSource', () {
    test('getPopularMovies returns null when box is empty', () {
      final result = dataSource.getPopularMovies();
      expect(result, isNull);
    });

    test('save page 1 then read returns saved data', () async {
      final movies = [_makeMovie(1, 'Movie A'), _makeMovie(2, 'Movie B')];

      await dataSource.savePopularMovies(
        movies: movies,
        page: 1,
        totalPages: 5,
      );

      final result = dataSource.getPopularMovies();

      expect(result, isNotNull);
      expect(result!.results!.length, 2);
      expect(result.results![0].id, 1);
      expect(result.results![1].title, 'Movie B');
      expect(result.totalPages, 5);
    });

    test('save page 1 then page 2 returns combined list', () async {
      final page1 = [_makeMovie(1, 'Movie A'), _makeMovie(2, 'Movie B')];
      final page2 = [_makeMovie(3, 'Movie C')];

      await dataSource.savePopularMovies(
        movies: page1,
        page: 1,
        totalPages: 3,
      );
      await dataSource.savePopularMovies(
        movies: page2,
        page: 2,
        totalPages: 3,
      );

      final result = dataSource.getPopularMovies();

      expect(result, isNotNull);
      expect(result!.results!.length, 3);
      expect(result.results![0].id, 1);
      expect(result.results![2].id, 3);
      expect(result.totalPages, 3);
    });

    test('save page 1 again clears old data and resets', () async {
      final page1 = [_makeMovie(1, 'Movie A')];
      final page2 = [_makeMovie(2, 'Movie B')];
      final newPage1 = [_makeMovie(10, 'New Movie')];

      await dataSource.savePopularMovies(
        movies: page1,
        page: 1,
        totalPages: 5,
      );
      await dataSource.savePopularMovies(
        movies: page2,
        page: 2,
        totalPages: 5,
      );

      // Save page 1 again — should reset
      await dataSource.savePopularMovies(
        movies: newPage1,
        page: 1,
        totalPages: 10,
      );

      final result = dataSource.getPopularMovies();

      expect(result, isNotNull);
      expect(result!.results!.length, 1);
      expect(result.results![0].id, 10);
      expect(result.results![0].title, 'New Movie');
      expect(result.totalPages, 10);
    });

    test('clearPopularMovies removes all cached data', () async {
      final movies = [_makeMovie(1, 'Movie A')];

      await dataSource.savePopularMovies(
        movies: movies,
        page: 1,
        totalPages: 5,
      );

      expect(dataSource.getPopularMovies(), isNotNull);

      await dataSource.clearPopularMovies();

      expect(dataSource.getPopularMovies(), isNull);
    });
  });
}
