import 'package:dartz/dartz.dart';
import 'package:submission1/domain/entities/tv_series_entity.dart';
import 'package:submission1/common/failure.dart';

import '../repositories/tv_series_repository.dart';

class GetTvSeriesRecommendations {
  final TvSeriesRepository repository;

  GetTvSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TvSeriesEntity>>> execute(id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
