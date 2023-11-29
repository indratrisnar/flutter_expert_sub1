import 'package:flutter_test/flutter_test.dart';
import 'package:submission1/data/models/tv_series_table.dart';
import 'package:submission1/domain/entities/tv_series_entity.dart';

import '../../dummy_data/dummy_tv_series.dart';

void main() {
  test(
    'should return valid [TvSeriesTable] from entity',
    () async {
      // act
      final result = TvSeriesTable.fromEntity(testTvSeriesDetailEntity);

      // assert
      expect(result, testTvSeriesTable);
    },
  );
  test(
    'should return valid [TvSeriesTable] from map',
    () async {
      // act
      final result = TvSeriesTable.fromMap(testTvSeriesTableMap);

      // assert
      expect(result, testTvSeriesTable);
    },
  );

  test(
    'should return valid map',
    () async {
      // act
      final result = testTvSeriesTable.toJson();

      // assert
      expect(result, testTvSeriesTableMap);
    },
  );

  test(
    'should return valid entity',
    () async {
      // act
      final result = testTvSeriesTable.toEntity();

      // assert
      final expectedEntity = TvSeriesEntity(
        adult: null,
        backdropPath: null,
        genreIds: null,
        id: testTvSeriesEntity.id,
        originalLanguage: null,
        originalName: null,
        overview: testTvSeriesEntity.overview,
        popularity: null,
        posterPath: testTvSeriesEntity.posterPath,
        firstAirDate: null,
        name: testTvSeriesEntity.name,
        voteAverage: null,
        voteCount: null,
      );
      expect(result, expectedEntity);
    },
  );
}
