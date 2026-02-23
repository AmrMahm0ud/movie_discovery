import 'package:movie_discovery/data/sources/remote/movie/model/remote_movie_model.dart';
import 'package:movie_discovery/domain/entity/movie/movie_result.dart';

class RemoteMovieResultModel {
  final List<RemoteMovieModel>? results;
  final int? totalPages;

  RemoteMovieResultModel({
    this.results,
    this.totalPages,
  });

  factory RemoteMovieResultModel.fromJson(Map<String, dynamic> json) {
    return RemoteMovieResultModel(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) =>
              RemoteMovieModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
    );
  }
}

extension RemoteMovieResultModelMapper on RemoteMovieResultModel {
  MovieResult mapToDomain() {
    return MovieResult(
      movies: (results ?? []).map((m) => m.mapToDomain()).toList(),
      totalPages: totalPages ?? 1,
    );
  }
}
