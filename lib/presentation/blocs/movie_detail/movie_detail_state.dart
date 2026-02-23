part of 'movie_detail_bloc.dart';

sealed class MovieDetailState {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailShowLoadingState extends MovieDetailState {}

class MovieDetailHideLoadingState extends MovieDetailState {}

class SuccessGetMovieDetailState extends MovieDetailState {
  final MovieDetail movieDetail;

  SuccessGetMovieDetailState({required this.movieDetail});
}

class FailGetMovieDetailState extends MovieDetailState {
  final String message;

  const FailGetMovieDetailState({required this.message});
}
