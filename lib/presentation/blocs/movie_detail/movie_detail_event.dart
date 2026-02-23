part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetailCallApiEvent extends MovieDetailEvent {
  final int movieId;

  const GetMovieDetailCallApiEvent({required this.movieId});
}
