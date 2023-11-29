import 'package:dartz/dartz.dart';
import 'package:submission1/common/failure.dart';
import 'package:submission1/domain/entities/tv_series_detail_entity.dart';

import '../repositories/tv_series_repository.dart';

class SaveWatchlistTvSeries {
  final TvSeriesRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetailEntity tvSeries) {
    return repository.saveWatchlist(tvSeries);
  }
}
