part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesCallApiEvent extends MovieEvent {
  final bool showLoading;

  const GetPopularMoviesCallApiEvent({this.showLoading = false});
}

class SearchMoviesCallApiEvent extends MovieEvent {
  final String query;
  final bool showLoading;

  const SearchMoviesCallApiEvent({
    required this.query,
    this.showLoading = false,
  });
}

class MovieResetEvent extends MovieEvent {
  const MovieResetEvent();
}

class ClearSearchEvent extends MovieEvent {
  const ClearSearchEvent();
}
