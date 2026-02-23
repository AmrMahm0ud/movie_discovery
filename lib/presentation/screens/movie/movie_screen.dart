import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery/config/routes/routes_manager.dart';
import 'package:movie_discovery/config/theme/color_manager.dart';
import 'package:movie_discovery/core/base/widget/base_stateful_widget.dart';
import 'package:movie_discovery/domain/entity/movie/movie.dart';
import 'package:movie_discovery/presentation/blocs/movie/movie_bloc.dart';
import 'package:movie_discovery/presentation/screens/movie/widget/movie_card_widget.dart';
import 'package:movie_discovery/presentation/screens/movie/widget/movie_skeleton_effect_widget.dart';
import 'package:movie_discovery/presentation/widgets/build_app_bar_widget.dart';
import 'package:movie_discovery/presentation/widgets/custom_empty_list_widget.dart';
import 'package:movie_discovery/presentation/widgets/search_text_field_widget.dart';

class MovieScreen extends BaseStatefulWidget {
  const MovieScreen({super.key});

  @override
  BaseState<MovieScreen> baseCreateState() => _MovieScreenState();
}

class _MovieScreenState extends BaseState<MovieScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(const GetPopularMoviesCallApiEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final bloc = context.read<MovieBloc>();
      if (bloc.currentPage <= bloc.totalPages) {
        if (bloc.searchQuery.isNotEmpty) {
          bloc.add(
            SearchMoviesCallApiEvent(
              query: bloc.searchQuery,
              showLoading: true,
            ),
          );
        } else {
          bloc.add(const GetPopularMoviesCallApiEvent(showLoading: true));
        }
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isNotEmpty) {
      context.read<MovieBloc>().add(SearchMoviesCallApiEvent(query: trimmed));
    }
  }

  void _onSearchChanged(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      _onClearSearch();
      return;
    }
    context.read<MovieBloc>().add(SearchMoviesCallApiEvent(query: trimmed));
  }

  void _onClearSearch() {
    _searchController.clear();
    context.read<MovieBloc>().add(const ClearSearchEvent());
  }

  void _onRetry() {
    final bloc = context.read<MovieBloc>();
    if (bloc.searchQuery.isNotEmpty) {
      bloc.add(SearchMoviesCallApiEvent(query: bloc.searchQuery));
    } else {
      bloc.add(const GetPopularMoviesCallApiEvent());
    }
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: buildAppBarWidget(title: 'Movie Discovery'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SearchTextFieldWidget(
              controller: _searchController,
              onSubmitted: _onSearch,
              onChanged: _onSearchChanged,
              onClear: _onClearSearch,
            ),
          ),
          Expanded(
            child: BlocConsumer<MovieBloc, MovieState>(
              listener: (context, state) {
                if (state is MovieShowLoadingState) {
                  showLoading();
                } else if (state is MovieHideLoadingState) {
                  hideLoading();
                }
              },
              buildWhen: (previous, current) {
                return current is SuccessGetMoviesState ||
                    current is FailGetMoviesState ||
                    current is MovieShowSkeletonState ||
                    current is MovieResetState;
              },
              builder: (context, state) {
                if (state is MovieShowSkeletonState) {
                  return const MovieSkeletonEffectWidget();
                }
                if (state is FailGetMoviesState) {
                  return CustomEmptyListWidget(
                    message: state.message,
                    icon: Icons.wifi_off_rounded,
                    onRetry: _onRetry,
                  );
                }
                if (state is SuccessGetMoviesState) {
                  if (state.movies.isEmpty) {
                    return const CustomEmptyListWidget();
                  }
                  return _buildMovieGrid(state.movies);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieGrid(List<Movie> movies) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCardWidget(
          movie: movie,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.movieDetail,
              arguments: movie.id,
            );
          },
        );
      },
    );
  }
}
