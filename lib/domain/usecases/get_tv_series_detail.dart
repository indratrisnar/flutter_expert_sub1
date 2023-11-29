import 'package:dartz/dartz.dart';
import 'package:submission1/domain/entities/tv_series_detail_entity.dart';
import 'package:submission1/common/failure.dart';

import '../repositories/tv_series_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetailEntity>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
