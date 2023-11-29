import 'package:dartz/dartz.dart';
import 'package:submission1/common/failure.dart';
import 'package:submission1/domain/entities/tv_series_entity.dart';

import '../repositories/tv_series_repository.dart';

class SearchTvSeries {
  final TvSeriesRepository repository;

  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TvSeriesEntity>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
