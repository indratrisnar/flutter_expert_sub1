import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';

import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:core/presentation/provider/tv_list_notifier.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockGetNowPlayingTvSeries extends Mock implements GetNowPlayingTvSeries {}

class MockGetPopularTvSeries extends Mock implements GetPopularTvSeries {}

class MockGetTopRatedTvSeries extends Mock implements GetTopRatedTvSeries {}

void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TvListNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    notifier = TvListNotifier(
      getNowPlayingTvs: mockGetNowPlayingTvSeries,
      getPopularTvs: mockGetPopularTvSeries,
      getTopRatedTvs: mockGetTopRatedTvSeries,
    )..addListener(() => listenerCallCount++);
  });

  group('now playing', () {
    test(
      'should loading before execute usecase',
      () async {
        // arrange
        when(
          () => mockGetNowPlayingTvSeries.execute(),
        ).thenAnswer((_) async => Right(testTvSeriesList));

        // act
        notifier.fetchNowPlayingTvs();

        // assert
        expect(notifier.nowPlayingState, RequestState.Loading);
        expect(listenerCallCount, 1);
      },
    );

    test(
      'should return loaded when usecase success',
      () async {
        // arrange
        when(
          () => mockGetNowPlayingTvSeries.execute(),
        ).thenAnswer((_) async => Right(testTvSeriesList));

        // act
        await notifier.fetchNowPlayingTvs();

        // assert
        expect(notifier.nowPlayingState, RequestState.Loaded);
        expect(notifier.nowPlayingTvs, testTvSeriesList);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return failure when execute failed',
      () async {
        // arrange
        when(
          () => mockGetNowPlayingTvSeries.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Failed')));

        // act
        await notifier.fetchNowPlayingTvs();

        // assert
        expect(notifier.nowPlayingState, RequestState.Error);
        expect(notifier.message, 'Failed');
        expect(listenerCallCount, 2);
      },
    );
  });

  group('popular', () {
    test(
      'should loading before execute usecase',
      () async {
        // arrange
        when(
          () => mockGetPopularTvSeries.execute(),
        ).thenAnswer((_) async => Right(testTvSeriesList));

        // act
        notifier.fetchPopularTvs();

        // assert
        expect(notifier.popularTvsState, RequestState.Loading);
        expect(listenerCallCount, 1);
      },
    );

    test(
      'should return loaded when usecase success',
      () async {
        // arrange
        when(
          () => mockGetPopularTvSeries.execute(),
        ).thenAnswer((_) async => Right(testTvSeriesList));

        // act
        await notifier.fetchPopularTvs();

        // assert
        expect(notifier.popularTvsState, RequestState.Loaded);
        expect(notifier.popularTvs, testTvSeriesList);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return failure when execute failed',
      () async {
        // arrange
        when(
          () => mockGetPopularTvSeries.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Failed')));

        // act
        await notifier.fetchPopularTvs();

        // assert
        expect(notifier.popularTvsState, RequestState.Error);
        expect(notifier.message, 'Failed');
        expect(listenerCallCount, 2);
      },
    );
  });

  group('top rated', () {
    test(
      'should loading before execute usecase',
      () async {
        // arrange
        when(
          () => mockGetTopRatedTvSeries.execute(),
        ).thenAnswer((_) async => Right(testTvSeriesList));

        // act
        notifier.fetchTopRatedTvs();

        // assert
        expect(notifier.topRatedTvsState, RequestState.Loading);
        expect(listenerCallCount, 1);
      },
    );

    test(
      'should return loaded when usecase success',
      () async {
        // arrange
        when(
          () => mockGetTopRatedTvSeries.execute(),
        ).thenAnswer((_) async => Right(testTvSeriesList));

        // act
        await notifier.fetchTopRatedTvs();

        // assert
        expect(notifier.topRatedTvsState, RequestState.Loaded);
        expect(notifier.topRatedTvs, testTvSeriesList);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return failure when execute failed',
      () async {
        // arrange
        when(
          () => mockGetTopRatedTvSeries.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Failed')));

        // act
        await notifier.fetchTopRatedTvs();

        // assert
        expect(notifier.topRatedTvsState, RequestState.Error);
        expect(notifier.message, 'Failed');
        expect(listenerCallCount, 2);
      },
    );
  });
}
