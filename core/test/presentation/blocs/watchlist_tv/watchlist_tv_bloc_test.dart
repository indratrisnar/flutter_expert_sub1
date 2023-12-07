import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';
import 'package:core/presentation/blocs/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_tv_series.dart';

class MockGetWatchlistTvSeries extends Mock implements GetWatchlistTvSeries {}

void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late WatchlistTvBloc bloc;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    bloc = WatchlistTvBloc(mockGetWatchlistTvSeries);
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'emits [WatchlistTvLoading, WatchlistTvLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetWatchlistTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right(testTvSeriesList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlistTv()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvLoaded(testTvSeriesList),
    ],
  );
  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'emits [WatchlistTvLoading, WatchlistTvFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetWatchlistTvSeries.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlistTv()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvFailure('Error'),
    ],
  );
}
