import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission1/domain/repositories/tv_series_repository.dart';
import 'package:submission1/domain/usecases/get_tv_series_detail.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetTvSeriesDetail usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  const testTvSeriesId = 1;

  test(
    'should return [TvSeriesDetailEntity] '
    'when repo success',
    () async {
      // arrange
      when(
        () => mockTvSeriesRepository.getTvSeriesDetail(any()),
      ).thenAnswer((_) async => Right(testTvSeriesDetailEntity));

      // act
      final result = await usecase.execute(testTvSeriesId);

      // assert
      verify(() => mockTvSeriesRepository.getTvSeriesDetail(testTvSeriesId));
      expect(result, Right(testTvSeriesDetailEntity));
    },
  );
}
