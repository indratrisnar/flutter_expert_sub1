import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/blocs/watchlist_status_movie/watchlist_status_movie_cubit.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}

class MockSaveWatchlist extends Mock implements SaveWatchlist {}

class MockRemoveWatchlist extends Mock implements RemoveWatchlist {}

void main() {
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late WatchlistStatusMovieCubit cubit;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    cubit = WatchlistStatusMovieCubit(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
    registerFallbackValue(testMovieDetail);
  });

  const tId = 1;
  group('check initial watchlist', () {
    blocTest<WatchlistStatusMovieCubit, bool>(
      'emits [true] when get watchlist',
      build: () {
        when(
          () => mockGetWatchListStatus.execute(any()),
        ).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) async => await cubit.checkWatchlist(tId),
      expect: () => [true],
    );
    blocTest<WatchlistStatusMovieCubit, bool>(
      'emits [false] when save watchlist failed',
      build: () {
        when(
          () => mockGetWatchListStatus.execute(any()),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.checkWatchlist(tId),
      expect: () => [false],
    );
  });

  group('movie not saved', () {
    blocTest<WatchlistStatusMovieCubit, bool>(
      'emits [true] when save watchlist success',
      build: () {
        when(
          () => mockSaveWatchlist.execute(any()),
        ).thenAnswer(
          (_) async => const Right('Added to Watchlist'),
        );
        when(
          () => mockGetWatchListStatus.execute(any()),
        ).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) async => await cubit.tapButton(testMovieDetail),
      expect: () => [true],
    );
    blocTest<WatchlistStatusMovieCubit, bool>(
      'emits [false] when save watchlist failed',
      build: () {
        when(
          () => mockSaveWatchlist.execute(any()),
        ).thenAnswer(
          (_) async => const Left(DatabaseFailure('Error')),
        );
        when(
          () => mockGetWatchListStatus.execute(any()),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.tapButton(testMovieDetail),
      expect: () => [false],
    );
  });

  group('movie saved', () {
    blocTest<WatchlistStatusMovieCubit, bool>(
      'emits [false] when remove watchlist success',
      build: () {
        when(
          () => mockSaveWatchlist.execute(any()),
        ).thenAnswer(
          (_) async => const Right('Removed from Watchlist'),
        );
        when(
          () => mockGetWatchListStatus.execute(any()),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) async => await cubit.tapButton(testMovieDetail),
      expect: () => [false],
    );
    blocTest<WatchlistStatusMovieCubit, bool>(
      'emits [true] when remove watchlist failed',
      build: () {
        when(
          () => mockSaveWatchlist.execute(any()),
        ).thenAnswer(
          (_) async => const Left(DatabaseFailure('Error')),
        );
        when(
          () => mockGetWatchListStatus.execute(any()),
        ).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.tapButton(testMovieDetail),
      expect: () => [true],
    );
  });
}
