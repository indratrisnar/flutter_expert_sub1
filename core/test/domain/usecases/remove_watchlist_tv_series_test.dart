import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_series.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late RemoveWatchlistTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(mockTvSeriesRepository);
    registerFallbackValue(testTvSeriesDetailEntity);
  });

  test(
    'should return message removed '
    'when repo success',
    () async {
      // arrange
      when(
        () => mockTvSeriesRepository.removeWatchlist(any()),
      ).thenAnswer((_) async => const Right('Removed from watchlist'));

      // act
      final result = await usecase.execute(testTvSeriesDetailEntity);

      // assert
      verify(() =>
          mockTvSeriesRepository.removeWatchlist(testTvSeriesDetailEntity));
      expect(result, const Right('Removed from watchlist'));
    },
  );
}
