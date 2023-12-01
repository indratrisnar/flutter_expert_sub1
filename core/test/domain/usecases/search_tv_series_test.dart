import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/search_tv_series.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late SearchTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  const testQuery = 'Faltu';

  test(
    'should return list of [TvSeriesEntity] '
    'when repo success',
    () async {
      // arrange
      when(
        () => mockTvSeriesRepository.searchTvSeries(any()),
      ).thenAnswer((_) async => Right(testTvSeriesList));

      // act
      final result = await usecase.execute(testQuery);

      // assert
      verify(() => mockTvSeriesRepository.searchTvSeries(testQuery));
      expect(result, Right(testTvSeriesList));
    },
  );
}
