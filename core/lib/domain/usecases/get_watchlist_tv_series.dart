import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/tv_series_repository.dart';

class GetWatchlistTvSeries {
  final TvSeriesRepository _repository;

  GetWatchlistTvSeries(this._repository);

  Future<Either<Failure, List<TvSeriesEntity>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
}
