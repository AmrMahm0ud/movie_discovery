import 'package:movie_discovery/domain/entity/movie/movie.dart';

class RemoteMovieModel {
  final int? id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final double? voteAverage;
  final String? releaseDate;

  RemoteMovieModel({
    this.id,
    this.title,
    this.posterPath,
    this.overview,
    this.voteAverage,
    this.releaseDate,
  });

  factory RemoteMovieModel.fromJson(Map<String, dynamic> json) {
    return RemoteMovieModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      posterPath: json['poster_path'] as String?,
      overview: json['overview'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      releaseDate: json['release_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate,
    };
  }
}

extension RemoteMovieModelMapper on RemoteMovieModel {
  Movie mapToDomain() {
    return Movie(
      id: id ?? 0,
      title: title ?? '',
      posterPath: posterPath ?? '',
      overview: overview ?? '',
      voteAverage: voteAverage ?? 0.0,
      releaseDate: releaseDate ?? '',
    );
  }
}
