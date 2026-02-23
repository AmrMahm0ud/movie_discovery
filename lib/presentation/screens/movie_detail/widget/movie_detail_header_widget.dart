import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_discovery/config/theme/color_manager.dart';
import 'package:movie_discovery/config/theme/font_manager.dart';
import 'package:movie_discovery/config/theme/styles_manager.dart';
import 'package:movie_discovery/data/sources/api_keys.dart';
import 'package:movie_discovery/domain/entity/movie/movie_detail.dart';

class MovieDetailHeaderWidget extends StatelessWidget {
  final MovieDetail movieDetail;

  const MovieDetailHeaderWidget({
    super.key,
    required this.movieDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBackdrop(context),
        const SizedBox(height: 16),
        _buildTitleRow(),
        const SizedBox(height: 8),
        _buildMetaInfo(),
        const SizedBox(height: 12),
        _buildGenres(),
        const SizedBox(height: 16),
        _buildOverview(),
      ],
    );
  }

  Widget _buildBackdrop(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          movieDetail.backdropPath.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: ApiKeys.backdropUrl(movieDetail.backdropPath),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: ColorManager.lightGray,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorManager.secondary,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: ColorManager.lightGray,
                    child: const Icon(
                      Icons.broken_image_outlined,
                      size: 60,
                      color: ColorManager.disabled,
                    ),
                  ),
                )
              : Container(
                  color: ColorManager.lightGray,
                  child: const Icon(
                    Icons.movie_outlined,
                    size: 60,
                    color: ColorManager.disabled,
                  ),
                ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  ColorManager.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              movieDetail.title,
              style: getBoldStyle(
                fontSize: FontSize.s24,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: ColorManager.ratingYellow.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  size: 18,
                  color: ColorManager.ratingYellow,
                ),
                const SizedBox(width: 4),
                Text(
                  movieDetail.voteAverage.toStringAsFixed(1),
                  style: getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (movieDetail.runtime > 0)
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 16,
                  color: ColorManager.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${movieDetail.runtime} min',
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMetaInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Release Date: ${movieDetail.releaseDate}',
        style: getRegularStyle(
          fontSize: FontSize.s14,
          color: ColorManager.textSecondary,
        ),
      ),
    );
  }

  Widget _buildGenres() {
    if (movieDetail.genres.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: movieDetail.genres.map((genre) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ColorManager.secondary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ColorManager.secondary.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              genre.name,
              style: getMediumStyle(
                fontSize: FontSize.s12,
                color: ColorManager.primary,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOverview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: getSemiBoldStyle(
              fontSize: FontSize.s18,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movieDetail.overview,
            style: getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
