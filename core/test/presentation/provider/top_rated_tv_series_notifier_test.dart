import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:core/presentation/provider/top_rated_tv_series_notifier.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockGetTopRatedTvSeries extends Mock implements GetTopRatedTvSeries {}

void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    notifier = TopRatedTvSeriesNotifier(
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    )..addListener(() => listenerCallCount++);
  });

  test(
    'should return state loading before usecase call',
    () async {
      // arrange
      when(
        () => mockGetTopRatedTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right([testTvSeriesEntity]),
      );

      // act
      notifier.fetchTopRatedTvSeriesEntitys();

      // assert
      expect(notifier.state, RequestState.loading);
      expect(listenerCallCount, 1);
    },
  );

  test(
    'should return tv list when data is present',
    () async {
      // arrange
      when(
        () => mockGetTopRatedTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right([testTvSeriesEntity]),
      );

      // act
      await notifier.fetchTopRatedTvSeriesEntitys();

      // assert
      expect(notifier.state, RequestState.loaded);
      expect(notifier.tvs, [testTvSeriesEntity]);
      expect(listenerCallCount, 2);
    },
  );

  test(
    'should return message error when failure occured',
    () async {
      // arrange
      when(
        () => mockGetTopRatedTvSeries.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Server Error')),
      );

      // act
      await notifier.fetchTopRatedTvSeriesEntitys();

      // assert
      expect(notifier.state, RequestState.error);
      expect(notifier.message, 'Server Error');
      expect(listenerCallCount, 2);
    },
  );
}
