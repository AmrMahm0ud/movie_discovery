import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery/config/theme/color_manager.dart';
import 'package:movie_discovery/core/base/widget/base_stateful_widget.dart';
import 'package:movie_discovery/di/injector.dart';
import 'package:movie_discovery/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_discovery/presentation/screens/movie_detail/widget/movie_detail_header_widget.dart';
import 'package:movie_discovery/presentation/widgets/build_app_bar_widget.dart';
import 'package:movie_discovery/presentation/widgets/custom_empty_list_widget.dart';

class MovieDetailScreen extends BaseStatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  BaseState<MovieDetailScreen> baseCreateState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends BaseState<MovieDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<MovieDetailBloc>(
      context,
    ).add(GetMovieDetailCallApiEvent(movieId: widget.movieId));
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: buildAppBarWidget(title: 'Movie Details'),
      body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
        listener: (context, state) {
          if (state is MovieDetailShowLoadingState) {
            showLoading();
          } else if (state is MovieDetailHideLoadingState) {
            hideLoading();
          }
        },
        buildWhen: (previous, current) {
          return current is SuccessGetMovieDetailState ||
              current is FailGetMovieDetailState;
        },
        builder: (context, state) {
          if (state is SuccessGetMovieDetailState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  MovieDetailHeaderWidget(movieDetail: state.movieDetail),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
          if (state is FailGetMovieDetailState) {
            return CustomEmptyListWidget(
              message: state.message,
              icon: Icons.wifi_off_rounded,
              onRetry: () {
                context.read<MovieDetailBloc>().add(
                  GetMovieDetailCallApiEvent(movieId: widget.movieId),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
