import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetWatchlistTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeries(mockTvSeriesRepository);
  });

  test(
    'should return list of [TvSeriesEntity] watchlist '
    'when repo success',
    () async {
      // arrange
      when(
        () => mockTvSeriesRepository.getWatchlistTvSeries(),
      ).thenAnswer((_) async => Right(testTvSeriesList));

      // act
      final result = await usecase.execute();

      // assert
      verify(() => mockTvSeriesRepository.getWatchlistTvSeries());
      expect(result, Right(testTvSeriesList));
    },
  );
}
