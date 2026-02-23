part of 'movie_bloc.dart';

sealed class MovieState {
  const MovieState();
}

class MovieInitial extends MovieState {}

class MovieShowSkeletonState extends MovieState {}

class MovieHideSkeletonState extends MovieState {}

class MovieShowLoadingState extends MovieState {}

class MovieHideLoadingState extends MovieState {}

class SuccessGetMoviesState extends MovieState {
  final List<Movie> movies;

  SuccessGetMoviesState({required this.movies});
}

class FailGetMoviesState extends MovieState {
  final String message;

  const FailGetMoviesState({required this.message});
}

class MovieResetState extends MovieState {}
