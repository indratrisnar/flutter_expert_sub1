import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/save_watchlist_tv_series.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late SaveWatchlistTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
    registerFallbackValue(testTvSeriesDetailEntity);
  });

  test(
    'should return message saved '
    'when repo success',
    () async {
      // arrange
      when(
        () => mockTvSeriesRepository.saveWatchlist(any()),
      ).thenAnswer((_) async => const Right('Saved to watchlist'));

      // act
      final result = await usecase.execute(testTvSeriesDetailEntity);

      // assert
      verify(
          () => mockTvSeriesRepository.saveWatchlist(testTvSeriesDetailEntity));
      expect(result, const Right('Saved to watchlist'));
    },
  );
}
