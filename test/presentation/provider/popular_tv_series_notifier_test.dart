import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission1/common/failure.dart';
import 'package:submission1/common/state_enum.dart';
import 'package:submission1/domain/usecases/get_popular_tv_series.dart';
import 'package:submission1/presentation/provider/popular_tv_series_notifier.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockGetPopularTvSeries extends Mock implements GetPopularTvSeries {}

void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    notifier = PopularTvSeriesNotifier(mockGetPopularTvSeries)
      ..addListener(() => listenerCallCount++);
  });

  test(
    'should return state loading before usecase call',
    () async {
      // arrange
      when(
        () => mockGetPopularTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right([testTvSeriesEntity]),
      );

      // act
      notifier.fetchPopularTvs();

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
        () => mockGetPopularTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right([testTvSeriesEntity]),
      );

      // act
      await notifier.fetchPopularTvs();

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
        () => mockGetPopularTvSeries.execute(),
      ).thenAnswer(
        (_) async => Left(ServerFailure('Server Error')),
      );

      // act
      await notifier.fetchPopularTvs();

      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Error');
      expect(listenerCallCount, 2);
    },
  );
}
