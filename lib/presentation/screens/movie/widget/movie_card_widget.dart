import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_discovery/config/theme/color_manager.dart';
import 'package:movie_discovery/config/theme/font_manager.dart';
import 'package:movie_discovery/config/theme/styles_manager.dart';
import 'package:movie_discovery/data/sources/api_keys.dart';
import 'package:movie_discovery/domain/entity/movie/movie.dart';

class MovieCardWidget extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCardWidget({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ColorManager.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: _buildPoster(),
            ),
            Expanded(
              flex: 1,
              child: _buildInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoster() {
    return Stack(
      fit: StackFit.expand,
      children: [
        movie.posterPath.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: ApiKeys.posterUrl(movie.posterPath),
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
                    size: 40,
                    color: ColorManager.disabled,
                  ),
                ),
              )
            : Container(
                color: ColorManager.lightGray,
                child: const Icon(
                  Icons.movie_outlined,
                  size: 40,
                  color: ColorManager.disabled,
                ),
              ),
        Positioned(
          top: 6,
          right: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: ColorManager.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  size: 14,
                  color: ColorManager.ratingYellow,
                ),
                const SizedBox(width: 2),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: getSemiBoldStyle(
                    fontSize: FontSize.s12,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getSemiBoldStyle(
              fontSize: FontSize.s12,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            movie.releaseDate,
            style: getRegularStyle(
              fontSize: FontSize.s10,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
