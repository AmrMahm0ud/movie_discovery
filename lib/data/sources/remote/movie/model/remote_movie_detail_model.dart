import 'package:movie_discovery/domain/entity/movie/movie_detail.dart';



class RemoteMovieDetailModel {
  final int? id;
  final String? title;
  final String? posterPath;
  final String? backdropPath;
  final String? overview;
  final double? voteAverage;
  final String? releaseDate;
  final List<RemoteGenreModel>? genres;
  final int? runtime;

  RemoteMovieDetailModel({
    this.id,
    this.title,
    this.posterPath,
    this.backdropPath,
    this.overview,
    this.voteAverage,
    this.releaseDate,
    this.genres,
    this.runtime,
  });

  factory RemoteMovieDetailModel.fromJson(Map<String, dynamic> json) {
    return RemoteMovieDetailModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      overview: json['overview'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      releaseDate: json['release_date'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) =>
              RemoteGenreModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      runtime: (json['runtime'] as num?)?.toInt(),
    );
  }
}

extension RemoteMovieDetailModelMapper on RemoteMovieDetailModel {
  MovieDetail mapToDomain() {
    return MovieDetail(
      id: id ?? 0,
      title: title ?? '',
      posterPath: posterPath ?? '',
      backdropPath: backdropPath ?? '',
      overview: overview ?? '',
      voteAverage: voteAverage ?? 0.0,
      releaseDate: releaseDate ?? '',
      genres: (genres ?? [])
          .map((g) => Genre(id: g.id ?? 0, name: g.name ?? ''))
          .toList(),
      runtime: runtime ?? 0,
    );
  }
}


class RemoteGenreModel {
  final int? id;
  final String? name;

  RemoteGenreModel({
    this.id,
    this.name,
  });

  factory RemoteGenreModel.fromJson(Map<String, dynamic> json) {
    return RemoteGenreModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );
  }
}
