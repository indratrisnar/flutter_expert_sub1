import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission1/domain/repositories/tv_series_repository.dart';
import 'package:submission1/domain/usecases/get_top_rated_tv_series.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetTopRatedTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockTvSeriesRepository);
  });

  test(
    'should return list of [TvSeriesEntity] '
    'when repo success',
    () async {
      // arrange
      when(
        () => mockTvSeriesRepository.getTopRatedTvSeries(),
      ).thenAnswer((_) async => Right(testTvSeriesList));

      // act
      final result = await usecase.execute();

      // assert
      verify(() => mockTvSeriesRepository.getTopRatedTvSeries());
      expect(result, Right(testTvSeriesList));
    },
  );
}
