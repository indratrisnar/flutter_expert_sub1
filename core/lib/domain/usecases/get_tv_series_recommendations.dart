import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/tv_series_repository.dart';

class GetTvSeriesRecommendations {
  final TvSeriesRepository repository;

  GetTvSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TvSeriesEntity>>> execute(id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
