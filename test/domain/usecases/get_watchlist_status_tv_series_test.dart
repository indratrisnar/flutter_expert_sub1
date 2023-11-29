import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission1/domain/repositories/tv_series_repository.dart';
import 'package:submission1/domain/usecases/get_watchlist_status_tv_series.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetWatchListStatusTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchListStatusTvSeries(mockTvSeriesRepository);
  });

  const testTvSeriesId = 1;

  test(
    'should return true '
    'when repo success',
    () async {
      // arrange
      when(
        () => mockTvSeriesRepository.isAddedToWatchlist(any()),
      ).thenAnswer((_) async => true);

      // act
      final result = await usecase.execute(testTvSeriesId);

      // assert
      verify(() => mockTvSeriesRepository.isAddedToWatchlist(testTvSeriesId));
      expect(result, true);
    },
  );
}
