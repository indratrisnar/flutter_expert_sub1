import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission1/common/failure.dart';
import 'package:submission1/common/state_enum.dart';
import 'package:submission1/domain/usecases/get_tv_series_detail.dart';
import 'package:submission1/domain/usecases/get_tv_series_recommendations.dart';
import 'package:submission1/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:submission1/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:submission1/domain/usecases/save_watchlist_tv_series.dart';
import 'package:submission1/presentation/provider/tv_detail_notifier.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockGetTvSeriesDetail extends Mock implements GetTvSeriesDetail {}

class MockGetTvSeriesRecommendations extends Mock
    implements GetTvSeriesRecommendations {}

class MockGetWatchListStatusTvSeries extends Mock
    implements GetWatchListStatusTvSeries {}

class MockSaveWatchlistTvSeries extends Mock implements SaveWatchlistTvSeries {}

class MockRemoveWatchlistTvSeries extends Mock
    implements RemoveWatchlistTvSeries {}

void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late TvDetailNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    notifier = TvDetailNotifier(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatus: mockGetWatchListStatusTvSeries,
      saveWatchlist: mockSaveWatchlistTvSeries,
      removeWatchlist: mockRemoveWatchlistTvSeries,
    )..addListener(() => listenerCallCount++);
    registerFallbackValue(testTvSeriesDetailEntity);
  });

  const tId = 1;

  _initDetailUsecase() async {
    when(() => mockGetTvSeriesDetail.execute(any())).thenAnswer(
      (_) async => Right(testTvSeriesDetailEntity),
    );
    when(() => mockGetTvSeriesRecommendations.execute(any())).thenAnswer(
      (_) async => Right(testTvSeriesList),
    );
  }

  group('Main Detail View', () {
    test(
      'should return state loading before usecase execute',
      () async {
        // arrange
        _initDetailUsecase();

        // act
        notifier.fetchTvSeriesDetail(tId);

        // assert
        expect(notifier.tvState, RequestState.Loading);
        expect(listenerCallCount, 1);
      },
    );

    test(
      'should return state loaded after usecase execute',
      () async {
        // arrange
        _initDetailUsecase();

        // act
        await notifier.fetchTvSeriesDetail(tId);

        // assert
        expect(notifier.tvState, RequestState.Loaded);
        expect(notifier.tv, testTvSeriesDetailEntity);
        expect(notifier.tvRecommendations, testTvSeriesList);
        expect(listenerCallCount, 3);
      },
    );

    test(
      'should return state error detail '
      'after usecase execute',
      () async {
        // arrange
        when(
          () => mockGetTvSeriesDetail.execute(tId),
        ).thenAnswer(
          (_) async => Left(ServerFailure('Server Error')),
        );
        when(
          () => mockGetTvSeriesRecommendations.execute(tId),
        ).thenAnswer(
          (_) async => Right(testTvSeriesList),
        );

        // act
        await notifier.fetchTvSeriesDetail(tId);

        // assert
        expect(notifier.tvState, RequestState.Error);
        expect(notifier.message, 'Server Error');
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return state error recommendations '
      'after usecase execute',
      () async {
        // arrange
        when(
          () => mockGetTvSeriesDetail.execute(tId),
        ).thenAnswer(
          (_) async => Right(testTvSeriesDetailEntity),
        );
        when(
          () => mockGetTvSeriesRecommendations.execute(tId),
        ).thenAnswer(
          (_) async => Left(ServerFailure('Server Error')),
        );

        // act
        await notifier.fetchTvSeriesDetail(tId);

        // assert
        expect(notifier.recommendationState, RequestState.Error);
        expect(notifier.message, 'Server Error');
        expect(listenerCallCount, 3);
      },
    );
  });

  group('watchlist', () {
    test(
      'should return true when call getWatchlistStatus',
      () async {
        // arrange
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => true);

        // act
        await notifier.loadWatchlistStatus(tId);

        // assert
        verify(() => mockGetWatchListStatusTvSeries.execute(tId));
        expect(notifier.isAddedToWatchlist, true);
      },
    );

    test(
      'should update message watchlist when save success',
      () async {
        // arrange
        when(
          () => mockSaveWatchlistTvSeries.execute(any()),
        ).thenAnswer((_) async => const Right('Saved'));
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => true);

        // act
        await notifier.addWatchlist(testTvSeriesDetailEntity);

        // assert
        verify(
          () => mockSaveWatchlistTvSeries.execute(testTvSeriesDetailEntity),
        );
        expect(notifier.watchlistMessage, 'Saved');
        expect(notifier.isAddedToWatchlist, true);
      },
    );

    test(
      'should update message watchlist when save failed',
      () async {
        // arrange
        when(
          () => mockSaveWatchlistTvSeries.execute(any()),
        ).thenAnswer(
          (_) async => Left(DatabaseFailure('Error')),
        );
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => false);

        // act
        await notifier.addWatchlist(testTvSeriesDetailEntity);

        // assert
        verify(
          () => mockSaveWatchlistTvSeries.execute(testTvSeriesDetailEntity),
        );
        expect(notifier.watchlistMessage, 'Error');
        expect(notifier.isAddedToWatchlist, false);
      },
    );

    test(
      'should update message watchlist when remove success',
      () async {
        // arrange
        when(
          () => mockRemoveWatchlistTvSeries.execute(any()),
        ).thenAnswer((_) async => const Right('Removed'));
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => false);

        // act
        await notifier.removeFromWatchlist(testTvSeriesDetailEntity);

        // assert
        verify(
          () => mockRemoveWatchlistTvSeries.execute(testTvSeriesDetailEntity),
        );
        expect(notifier.watchlistMessage, 'Removed');
        expect(notifier.isAddedToWatchlist, false);
      },
    );

    test(
      'should update message watchlist when remove failed',
      () async {
        // arrange
        when(
          () => mockRemoveWatchlistTvSeries.execute(any()),
        ).thenAnswer(
          (_) async => Left(DatabaseFailure('Error')),
        );
        when(
          () => mockGetWatchListStatusTvSeries.execute(any()),
        ).thenAnswer((_) async => true);

        // act
        await notifier.removeFromWatchlist(testTvSeriesDetailEntity);

        // assert
        verify(
          () => mockRemoveWatchlistTvSeries.execute(testTvSeriesDetailEntity),
        );
        expect(notifier.watchlistMessage, 'Error');
        expect(notifier.isAddedToWatchlist, true);
      },
    );
  });
}
