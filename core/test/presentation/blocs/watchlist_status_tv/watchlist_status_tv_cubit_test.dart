import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/save_watchlist_tv_series.dart';
import 'package:core/presentation/blocs/watchlist_status_tv/watchlist_status_tv_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_tv_series.dart';

class MockGetWatchListStatusTvSeries extends Mock
    implements GetWatchListStatusTvSeries {}

class MockSaveWatchlistTvSeries extends Mock implements SaveWatchlistTvSeries {}

class MockRemoveWatchlistTvSeries extends Mock
    implements RemoveWatchlistTvSeries {}

void main() {
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late WatchlistStatusTvCubit cubit;

  setUp(() {
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    cubit = WatchlistStatusTvCubit(
      mockGetWatchListStatusTvSeries,
      mockSaveWatchlistTvSeries,
      mockRemoveWatchlistTvSeries,
    );
    registerFallbackValue(testTvSeriesDetailEntity);
  });

  const tId = 1;
  group('check initial watchlist', () {
    blocTest<WatchlistStatusTvCubit, bool>(
      'emits [true] when get watchlist',
      build: () {
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) async => await cubit.checkWatchlist(tId),
      expect: () => [true],
    );
    blocTest<WatchlistStatusTvCubit, bool>(
      'emits [false] when save watchlist failed',
      build: () {
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.checkWatchlist(tId),
      expect: () => [false],
    );
  });

  group('tv not saved', () {
    blocTest<WatchlistStatusTvCubit, bool>(
      'emits [true] when save watchlist success',
      build: () {
        when(
          () => mockSaveWatchlistTvSeries.execute(any()),
        ).thenAnswer(
          (_) async => const Right('Added to Watchlist'),
        );
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) async => await cubit.tapButton(testTvSeriesDetailEntity),
      expect: () => [true],
    );
    blocTest<WatchlistStatusTvCubit, bool>(
      'emits [false] when save watchlist failed',
      build: () {
        when(
          () => mockSaveWatchlistTvSeries.execute(any()),
        ).thenAnswer(
          (_) async => const Left(DatabaseFailure('Error')),
        );
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.tapButton(testTvSeriesDetailEntity),
      expect: () => [false],
    );
  });

  group('tv saved', () {
    blocTest<WatchlistStatusTvCubit, bool>(
      'emits [false] when remove watchlist success',
      build: () {
        when(
          () => mockSaveWatchlistTvSeries.execute(any()),
        ).thenAnswer(
          (_) async => const Right('Removed from Watchlist'),
        );
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) async => await cubit.tapButton(testTvSeriesDetailEntity),
      expect: () => [false],
    );
    blocTest<WatchlistStatusTvCubit, bool>(
      'emits [true] when remove watchlist failed',
      build: () {
        when(
          () => mockSaveWatchlistTvSeries.execute(any()),
        ).thenAnswer(
          (_) async => const Left(DatabaseFailure('Error')),
        );
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.tapButton(testTvSeriesDetailEntity),
      expect: () => [true],
    );
  });
}
