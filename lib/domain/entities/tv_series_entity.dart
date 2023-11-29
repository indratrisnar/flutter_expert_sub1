import 'package:equatable/equatable.dart';

class TvSeriesEntity extends Equatable {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  TvSeriesEntity({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  TvSeriesEntity.watchlist({
    this.adult,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props {
    return [
      adult,
      backdropPath,
      genreIds,
      id,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      firstAirDate,
      name,
      voteAverage,
      voteCount,
    ];
  }
}
