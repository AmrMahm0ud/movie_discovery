import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery/core/resources/data_state.dart';
import 'package:movie_discovery/domain/entity/movie/movie_detail.dart';
import 'package:movie_discovery/domain/usecases/movie/get_movie_detail_use_case.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetailUseCase getMovieDetailUseCase;

  MovieDetailBloc({required this.getMovieDetailUseCase})
      : super(MovieDetailInitial()) {
    on<GetMovieDetailCallApiEvent>(_onGetMovieDetailCallApiEvent);
  }

  Future<void> _onGetMovieDetailCallApiEvent(
    GetMovieDetailCallApiEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailShowLoadingState());

    DataState<MovieDetail> result =
        await getMovieDetailUseCase(movieId: event.movieId);

    if (result is DataSuccess) {
      emit(SuccessGetMovieDetailState(movieDetail: result.data!));
    } else if (result is DataFailed) {
      emit(FailGetMovieDetailState(
        message: result.message ?? 'Failed to load movie details',
      ));
    }

    emit(MovieDetailHideLoadingState());
  }
}
