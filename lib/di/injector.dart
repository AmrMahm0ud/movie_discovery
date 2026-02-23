import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_discovery/core/utils/network/api_channel.dart';
import 'package:movie_discovery/data/repositories/movie/movie_repository_implementation.dart';
import 'package:movie_discovery/data/sources/local/movie/movie_local_data_source.dart';
import 'package:movie_discovery/data/sources/remote/movie/movie_api_services.dart';
import 'package:movie_discovery/domain/repositories/movie/movie_repository.dart';
import 'package:movie_discovery/domain/usecases/movie/get_movie_detail_use_case.dart';
import 'package:movie_discovery/domain/usecases/movie/get_popular_movies_use_case.dart';
import 'package:movie_discovery/domain/usecases/movie/search_movies_use_case.dart';
import 'package:movie_discovery/presentation/blocs/movie/movie_bloc.dart';
import 'package:movie_discovery/presentation/blocs/movie_detail/movie_detail_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  await Hive.initFlutter();
  final moviesBox = await Hive.openBox(MovieLocalDataSource.boxName);

  injector.registerSingleton<ApiChannel>(ApiChannel());

  injector.registerSingleton<MovieApiServices>(MovieApiServices(injector()));

  injector.registerSingleton<MovieLocalDataSource>(
    MovieLocalDataSource(moviesBox),
  );

  injector.registerSingleton<MovieRepository>(
    MovieRepositoryImplementation(injector(), injector()),
  );

  injector.registerSingleton<GetPopularMoviesUseCase>(
    GetPopularMoviesUseCase(injector()),
  );
  injector.registerSingleton<SearchMoviesUseCase>(
    SearchMoviesUseCase(injector()),
  );
  injector.registerSingleton<GetMovieDetailUseCase>(
    GetMovieDetailUseCase(injector()),
  );

  injector.registerFactory<MovieBloc>(
    () => MovieBloc(
      getPopularMoviesUseCase: injector(),
      searchMoviesUseCase: injector(),
    ),
  );
  injector.registerFactory<MovieDetailBloc>(
    () => MovieDetailBloc(getMovieDetailUseCase: injector()),
  );
}
