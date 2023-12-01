import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/domain/usecases/search_tv_series.dart';
import 'package:core/presentation/provider/tv_search_notifier.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockSearchTvSeries extends Mock implements SearchTvSeries {}

void main() {
  late MockSearchTvSeries mockSearchTvSeries;
  late TvSearchNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    notifier = TvSearchNotifier(searchTvs: mockSearchTvSeries)
      ..addListener(() => listenerCallCount++);
  });

  test(
    'should set state loading before call search usecase',
    () async {
      // arrange
      when(
        () => mockSearchTvSeries.execute(any()),
      ).thenAnswer((_) async => Right(testTvSeriesList));

      // act
      notifier.fetchTvSearch('query');

      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    },
  );

  test(
    'should return loaded when usecase success',
    () async {
      // arrange
      when(
        () => mockSearchTvSeries.execute(any()),
      ).thenAnswer((_) async => Right(testTvSeriesList));

      // act
      await notifier.fetchTvSearch('query');

      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.searchResult, testTvSeriesList);
      expect(listenerCallCount, 2);
    },
  );

  test(
    'should return failure when execute failed',
    () async {
      // arrange
      when(
        () => mockSearchTvSeries.execute(any()),
      ).thenAnswer((_) async => Left(ServerFailure('Failed')));

      // act
      await notifier.fetchTvSearch('query');

      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Failed');
      expect(listenerCallCount, 2);
    },
  );
}
