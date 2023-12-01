import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:core/data/models/tv_series_detail_model.dart';

import '../../dummy_data/dummy_tv_series.dart';
import '../../json_reader.dart';

void main() {
  test(
    'should return valid [TvSeriesDetailModel]',
    () async {
      // arrange
      String stringTvSeries = readJson('dummy_data/tv_series_detail.json');
      Map<String, dynamic> mapTvSeries = Map.from(jsonDecode(stringTvSeries));

      // act
      final result = TvSeriesDetailModel.fromJson(mapTvSeries);

      // assert
      expect(result, testTvSeriesDetailModel);
    },
  );

  test(
    'should return valid json',
    () async {
      // act
      final result = testTvSeriesDetailModel.toJson();

      // assert
      expect(result, testTvSeriesDetailJson);
    },
  );

  test(
    'should return valid entity',
    () async {
      // act
      final result = testTvSeriesDetailModel.toEntity;

      // assert
      expect(result, testTvSeriesDetailEntity);
    },
  );
}
