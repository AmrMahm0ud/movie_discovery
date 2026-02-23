import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery/core/resources/data_state.dart';
import 'package:movie_discovery/domain/entity/movie/movie.dart';
import 'package:movie_discovery/domain/entity/movie/movie_result.dart';
import 'package:movie_discovery/domain/usecases/movie/get_popular_movies_use_case.dart';
import 'package:movie_discovery/domain/usecases/movie/search_movies_use_case.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final SearchMoviesUseCase searchMoviesUseCase;

  MovieBloc({
    required this.getPopularMoviesUseCase,
    required this.searchMoviesUseCase,
  }) : super(MovieInitial()) {
    on<GetPopularMoviesCallApiEvent>(_onGetPopularMoviesCallApiEvent);
    on<SearchMoviesCallApiEvent>(_onSearchMoviesCallApiEvent);
    on<MovieResetEvent>(_onMovieResetEvent);
    on<ClearSearchEvent>(_onClearSearchEvent);
  }

  int currentPage = 1;
  int totalPages = 1;
  List<Movie> movies = [];
  String searchQuery = '';

  Future<void> _onGetPopularMoviesCallApiEvent(
    GetPopularMoviesCallApiEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (currentPage > 1 || event.showLoading) {
      emit(MovieShowLoadingState());
    } else {
      emit(MovieShowSkeletonState());
    }

    DataState<MovieResult> result =
        await getPopularMoviesUseCase(page: currentPage);

    if (result is DataSuccess) {
      movies.addAll(result.data?.movies ?? []);
      totalPages = result.data?.totalPages ?? 1;
      emit(SuccessGetMoviesState(movies: movies));
      currentPage++;
    } else if (result is DataFailed) {
      emit(FailGetMoviesState(
        message: result.message ?? 'Failed to fetch movies',
      ));
    }

    if (currentPage > 1 || event.showLoading) {
      emit(MovieHideLoadingState());
    } else {
      emit(MovieHideSkeletonState());
    }
  }

  Future<void> _onSearchMoviesCallApiEvent(
    SearchMoviesCallApiEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (event.query != searchQuery) {
      currentPage = 1;
      movies = [];
      searchQuery = event.query;
    }

    if (currentPage > 1 || event.showLoading) {
      emit(MovieShowLoadingState());
    } else {
      emit(MovieShowSkeletonState());
    }

    DataState<MovieResult> result = await searchMoviesUseCase(
      query: searchQuery,
      page: currentPage,
    );

    if (result is DataSuccess) {
      movies.addAll(result.data?.movies ?? []);
      totalPages = result.data?.totalPages ?? 1;
      emit(SuccessGetMoviesState(movies: movies));
      currentPage++;
    } else if (result is DataFailed) {
      emit(FailGetMoviesState(
        message: result.message ?? 'Search failed',
      ));
    }

    if (currentPage > 1 || event.showLoading) {
      emit(MovieHideLoadingState());
    } else {
      emit(MovieHideSkeletonState());
    }
  }

  void _onMovieResetEvent(
    MovieResetEvent event,
    Emitter<MovieState> emit,
  ) {
    currentPage = 1;
    totalPages = 1;
    movies = [];
    searchQuery = '';
    emit(MovieResetState());
  }

  Future<void> _onClearSearchEvent(
    ClearSearchEvent event,
    Emitter<MovieState> emit,
  ) async {
    currentPage = 1;
    totalPages = 1;
    movies = [];
    searchQuery = '';
    add(const GetPopularMoviesCallApiEvent());
  }
}
