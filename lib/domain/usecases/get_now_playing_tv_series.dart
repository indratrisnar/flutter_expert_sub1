import 'package:dartz/dartz.dart';
import 'package:submission1/domain/entities/tv_series_entity.dart';
import 'package:submission1/common/failure.dart';

import '../repositories/tv_series_repository.dart';

class GetNowPlayingTvSeries {
  final TvSeriesRepository repository;

  GetNowPlayingTvSeries(this.repository);

  Future<Either<Failure, List<TvSeriesEntity>>> execute() {
    return repository.getNowPlayingTvSeries();
  }
}
