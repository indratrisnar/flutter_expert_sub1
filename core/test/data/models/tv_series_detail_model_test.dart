import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:core/data/models/tv_series_detail_model.dart';

import '../../dummy_data/dummy_tv_series.dart';

void main() {
  test(
    'should return valid [TvSeriesDetailModel]',
    () async {
      // arrange
      var dir = Directory.current.path;
      final Map<String, dynamic> jsonMap = json.decode(
        File('$dir/test/data/models/tv_series_detail_new.json')
            .readAsStringSync(),
      );
      Map<String, dynamic> mapTvSeries = Map.from(jsonMap);

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
