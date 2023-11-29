import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission1/common/failure.dart';
import 'package:submission1/common/state_enum.dart';
import 'package:submission1/domain/usecases/get_watchlist_tv_series.dart';
import 'package:submission1/presentation/provider/watchlist_tv_notifier.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockGetWatchlistTvSeries extends Mock implements GetWatchlistTvSeries {}

void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late WatchlistTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    notifier = WatchlistTvNotifier(getWatchlistTvs: mockGetWatchlistTvSeries)
      ..addListener(() => listenerCallCount++);
  });

  test(
    'should return state loading before usecase call',
    () async {
      // arrange
      when(
        () => mockGetWatchlistTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right([testTvSeriesEntity]),
      );

      // act
      notifier.fetchWatchlistMovies();

      // assert
      expect(notifier.watchlistState, RequestState.Loading);
      expect(listenerCallCount, 1);
    },
  );

  test(
    'should return tv list when data is present',
    () async {
      // arrange
      when(
        () => mockGetWatchlistTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right([testTvSeriesEntity]),
      );

      // act
      await notifier.fetchWatchlistMovies();

      // assert
      expect(notifier.watchlistState, RequestState.Loaded);
      expect(notifier.watchlistTvs, [testTvSeriesEntity]);
      expect(listenerCallCount, 2);
    },
  );

  test(
    'should return message error when failure occured',
    () async {
      // arrange
      when(
        () => mockGetWatchlistTvSeries.execute(),
      ).thenAnswer(
        (_) async => Left(ServerFailure('Server Error')),
      );

      // act
      await notifier.fetchWatchlistMovies();

      // assert
      expect(notifier.watchlistState, RequestState.Error);
      expect(notifier.message, 'Server Error');
      expect(listenerCallCount, 2);
    },
  );
}
