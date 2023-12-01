import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/tv_series_repository.dart';

class SearchTvSeries {
  final TvSeriesRepository repository;

  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TvSeriesEntity>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
