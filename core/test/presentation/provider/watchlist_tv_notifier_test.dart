import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';
import 'package:core/presentation/provider/watchlist_tv_notifier.dart';

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
      expect(notifier.watchlistState, RequestState.loading);
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
      expect(notifier.watchlistState, RequestState.loaded);
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
        (_) async => const Left(ServerFailure('Server Error')),
      );

      // act
      await notifier.fetchWatchlistMovies();

      // assert
      expect(notifier.watchlistState, RequestState.error);
      expect(notifier.message, 'Server Error');
      expect(listenerCallCount, 2);
    },
  );
}
