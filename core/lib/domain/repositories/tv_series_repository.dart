import 'package:core/domain/entities/tv_series_detail_entity.dart';
import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeriesEntity>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeriesEntity>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeriesEntity>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetailEntity>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeriesEntity>>> getTvSeriesRecommendations(
    int id,
  );
  Future<Either<Failure, List<TvSeriesEntity>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetailEntity tvSeries);
  Future<Either<Failure, String>> removeWatchlist(
    TvSeriesDetailEntity tvSeries,
  );
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeriesEntity>>> getWatchlistTvSeries();
}
