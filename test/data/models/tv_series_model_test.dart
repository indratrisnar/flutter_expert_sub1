import 'package:flutter_test/flutter_test.dart';
import 'package:submission1/data/models/tv_series_model.dart';

import '../../dummy_data/dummy_tv_series.dart';

void main() {
  test(
    'should return valid [TvSeriesModel]',
    () async {
      // arrange
      Map<String, dynamic> mapTvSeries = testTvSeriesJson;

      // act
      final result = TvSeriesModel.fromJson(mapTvSeries);

      // assert
      expect(result, testTvSeriesModel);
    },
  );

  test(
    'should return valid json',
    () async {
      // act
      final result = testTvSeriesModel.toJson();

      // assert
      expect(result, testTvSeriesJson);
    },
  );

  test(
    'should return valid entity',
    () async {
      // act
      final result = testTvSeriesModel.toEntity;

      // assert
      expect(result, testTvSeriesEntity);
    },
  );
}
