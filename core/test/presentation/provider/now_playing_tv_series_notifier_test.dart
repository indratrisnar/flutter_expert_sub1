import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:core/presentation/provider/now_playing_tv_series_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockGetNowPlayingTvSeries extends Mock implements GetNowPlayingTvSeries {}

void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late NowPlayingTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    notifier = NowPlayingTvSeriesNotifier(mockGetNowPlayingTvSeries)
      ..addListener(() => listenerCallCount++);
  });

  test(
    'should return state loading before usecase call',
    () async {
      // arrange
      when(
        () => mockGetNowPlayingTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right([testTvSeriesEntity]),
      );

      // act
      notifier.fetchNowPlayingTvs();

      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    },
  );

  test(
    'should return tv list when data is present',
    () async {
      // arrange
      when(
        () => mockGetNowPlayingTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right([testTvSeriesEntity]),
      );

      // act
      await notifier.fetchNowPlayingTvs();

      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.tvs, [testTvSeriesEntity]);
      expect(listenerCallCount, 2);
    },
  );

  test(
    'should return message error when failure occured',
    () async {
      // arrange
      when(
        () => mockGetNowPlayingTvSeries.execute(),
      ).thenAnswer(
        (_) async => Left(ServerFailure('Server Error')),
      );

      // act
      await notifier.fetchNowPlayingTvs();

      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Error');
      expect(listenerCallCount, 2);
    },
  );
}
