import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission1/domain/repositories/tv_series_repository.dart';
import 'package:submission1/domain/usecases/get_tv_series_recommendations.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetTvSeriesRecommendations usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  const testTvSeriesId = 1;

  test(
    'should return list of [TvSeriesEntity] '
    'when repo success',
    () async {
      // arrange
      when(
        () => mockTvSeriesRepository.getTvSeriesRecommendations(any()),
      ).thenAnswer((_) async => Right(testTvSeriesList));

      // act
      final result = await usecase.execute(testTvSeriesId);

      // assert
      verify(() =>
          mockTvSeriesRepository.getTvSeriesRecommendations(testTvSeriesId));
      expect(result, Right(testTvSeriesList));
    },
  );
}
