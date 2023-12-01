import 'package:core/domain/entities/tv_series_detail_entity.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/tv_series_repository.dart';

class SaveWatchlistTvSeries {
  final TvSeriesRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetailEntity tvSeries) {
    return repository.saveWatchlist(tvSeries);
  }
}
